<?php

declare(strict_types=1);

class ClothingService
{
    private PDO $db;

    public function __construct(PDO $db)
    {
        $this->db = $db;
    }

    // Busca os detalhes de uma única roupa pelo ID
    public function getClothById(int $clothId): ?array
    {
        $stmt = $this->db->prepare("
            SELECT id, name, slug, temperature, category
            FROM slivi_clothes 
            WHERE id = ? 
            LIMIT 1
        ");
        $stmt->execute([$clothId]);

        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        return $row ?: null;
    }

    public function createWardrobe(int $userId): void
    {
        // Estados iniciais
        $stmt = $this->db->prepare("
            INSERT INTO slivi_user_wardrobe (user_id, cloth_id, value) VALUES
            (?, 1),
            (?, 2),
            (?, 4),
            (?, 5),
            (?, 6),
        ");
        $stmt->execute([$userId, $userId, $userId, $userId, $userId]);
    }

    // Busca todas as roupas da loja e verifica se o usuário já as possui
    public function getStore(int $userId): array
    {
        // 1. Busca o nível atual do usuário
        $stmtUser = $this->db->prepare("SELECT level FROM users WHERE id = ? LIMIT 1");
        $stmtUser->execute([$userId]);
        $userData = $stmtUser->fetch(PDO::FETCH_ASSOC);

        // Se por algum motivo não achar, assume nível 1 como segurança
        $userLevel = $userData ? (int)$userData['level'] : 1;

        // 2. Busca a loja, verificando posse (owned) e desbloqueio (unlocked)
        // Usamos o $userLevel no primeiro parâmetro e o $userId no segundo
        $stmt = $this->db->prepare("
            SELECT c.id, c.name, c.slug, c.temperature, c.category, c.classe, c.price, c.min_level,
                   IF(uw.cloth_id IS NOT NULL, true, false) as owned,
                   IF(? >= c.min_level, true, false) as unlocked
            FROM slivi_clothes c
            LEFT JOIN slivi_user_wardrobe uw ON c.id = uw.cloth_id AND uw.user_id = ?
            ORDER BY c.min_level ASC, c.price ASC
        ");

        $stmt->execute([$userLevel, $userId]);

        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $grouped = [];

        foreach ($rows as $item) {
            $category = $item['category'];

            // Conversão de tipos para garantir consistência no JSON
            $item['owned'] = (bool) $item['owned'];
            $item['unlocked'] = (bool) $item['unlocked'];
            $item['price'] = (int) $item['price'];
            $item['temperature'] = (int) $item['temperature'];
            $item['min_level'] = (int) $item['min_level'];

            if (!isset($grouped[$category])) {
                $grouped[$category] = [];
            }

            $grouped[$category][] = $item;
        }

        return $grouped;
    }

    // Compra uma única roupa e adiciona ao guarda-roupa
    public function buyCloth(int $userId, int $clothId): void
    {
        // 1. Busca apenas o preço da roupa para validar se ela existe
        $stmt = $this->db->prepare("SELECT price FROM slivi_clothes WHERE id = ? LIMIT 1");
        $stmt->execute([$clothId]);
        $cloth = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$cloth) {
            throw new Exception("Roupa não encontrada no catálogo.");
        }

        $price = (int) $cloth['price'];

        // 2. Inicia a transação de segurança
        $this->db->beginTransaction();

        try {
            // 3. Tenta descontar o valor da roupa
            require_once __DIR__ . '/WalletService.php';
            $walletService = new WalletService($this->db);
            $walletService->spendCoins($userId, $price);

            // 4. Tenta adicionar a roupa no guarda-roupa
            $stmtInsert = $this->db->prepare("
                INSERT IGNORE INTO slivi_user_wardrobe (user_id, cloth_id) 
                VALUES (?, ?)
            ");
            $stmtInsert->execute([$userId, $clothId]);

            // Se rowCount for 0, o INSERT IGNORE pulou a linha (o usuário já tinha a roupa)
            if ($stmtInsert->rowCount() === 0) {
                throw new Exception("Você já possui esta roupa no guarda-roupa.");
            }

            // 5. Deu tudo certo, confirma a compra!
            $this->db->commit();
        } catch (Exception $e) {
            // Se faltar saldo ou já tiver a roupa, desfaz a cobrança
            $this->db->rollBack();
            throw $e;
        }
    }

    //Pega todas as roupas do usuario no guarda-roupas dele
    public function getWardrobe(int $userId): array
    {
        $stmt = $this->db->prepare("
        SELECT c.id, c.name, c.slug, c.temperature, c.category
        FROM slivi_clothes c
        INNER JOIN slivi_user_wardrobe uw ON c.id = uw.cloth_id
        WHERE uw.user_id = ?
        ORDER BY c.name
    ");
        $stmt->execute([$userId]);

        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $grouped = [];

        foreach ($rows as $item) {
            $category = $item['category'];

            // cria a categoria se ainda não existir
            if (!isset($grouped[$category])) {
                $grouped[$category] = [];
            }

            $grouped[$category][] = $item;
        }

        return $grouped;
    }

    // Puxa as roupas que estão equipadas, organizadas por categoria
    public function getEquipped(int $userId): array
    {
        $stmt = $this->db->prepare("
            SELECT category, cloth_slug, temperature
            FROM slivi_user_equipped_clothes
            WHERE user_id = ?
        ");
        $stmt->execute([$userId]);

        $equipped = [];
        // Transforma o retorno em um array chave => valor. Ex: ['HAT' => 'chapeu-de-palha']
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $equipped[$row['category']] = $row['cloth_slug'];
        }

        return $equipped; // Retorna array vazio [] se estiver totalmente sem roupa
    }

    // Adicione no final do ClothingService.php
    public function getEquippedTemperatures(int $userId): array
    {
        $stmt = $this->db->prepare("
            SELECT temperature 
            FROM slivi_user_equipped_clothes 
            WHERE user_id = ?
        ");
        $stmt->execute([$userId]);

        // Retorna um array simples só com os números: [75, 75]
        return $stmt->fetchAll(PDO::FETCH_COLUMN);
    }

    // Salva a nova roupa equipada no banco
    public function equipClothing(int $userId, string $slug): void
    {
        // 1. Primeiro, descobrimos qual é a categoria desse slug
        $stmtCat = $this->db->prepare("SELECT category, temperature FROM slivi_clothes WHERE slug = ? LIMIT 1");
        $stmtCat->execute([$slug]);
        $cloth = $stmtCat->fetch(PDO::FETCH_ASSOC);

        if (!$cloth) {
            throw new Exception("Roupa não encontrada no catálogo.");
        }

        $category = $cloth['category'];
        $temperature = $cloth['temperature'];

        // 2. Inserimos ou atualizamos o slot específico (ex: substitui o chapéu atual pelo novo)
        $stmt = $this->db->prepare("
            INSERT INTO slivi_user_equipped_clothes (user_id, category, cloth_slug, temperature, updated_at)
            VALUES (?, ?, ?, ?, NOW())
            ON DUPLICATE KEY UPDATE 
                cloth_slug = VALUES(cloth_slug),
                updated_at = NOW()
        ");
        $stmt->execute([$userId, $category, $slug, $temperature]);
    }

    public function unequipClothing(int $userId, string $slug): void
    {
        $stmtCat = $this->db->prepare("SELECT category FROM slivi_clothes WHERE slug = ? LIMIT 1");
        $stmtCat->execute([$slug]);
        $cloth = $stmtCat->fetch(PDO::FETCH_ASSOC);

        if ($cloth) {
            $category = $cloth['category'];

            $stmt = $this->db->prepare("
            DELETE FROM slivi_user_equipped_clothes 
            WHERE user_id = ? AND category = ?
        ");
            $stmt->execute([$userId, $category]);
        }
    }
}
