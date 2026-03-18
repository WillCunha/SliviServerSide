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
            SELECT category, cloth_slug
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

    // Salva a nova roupa equipada no banco
    public function equipClothing(int $userId, string $slug): void
    {
        // 1. Primeiro, descobrimos qual é a categoria desse slug
        $stmtCat = $this->db->prepare("SELECT category FROM slivi_clothes WHERE slug = ? LIMIT 1");
        $stmtCat->execute([$slug]);
        $cloth = $stmtCat->fetch(PDO::FETCH_ASSOC);

        if (!$cloth) {
            throw new Exception("Roupa não encontrada no catálogo.");
        }

        $category = $cloth['category'];

        // 2. Inserimos ou atualizamos o slot específico (ex: substitui o chapéu atual pelo novo)
        $stmt = $this->db->prepare("
            INSERT INTO slivi_user_equipped_clothes (user_id, category, cloth_slug, updated_at)
            VALUES (?, ?, ?, NOW())
            ON DUPLICATE KEY UPDATE 
                cloth_slug = VALUES(cloth_slug),
                updated_at = NOW()
        ");
        $stmt->execute([$userId, $category, $slug]);
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
