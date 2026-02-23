<?php
declare(strict_types=1);

class ClothingService
{
    private PDO $db;

    public function __construct(PDO $db)
    {
        $this->db = $db;
    }

    // Puxa todas as roupas que o usuário possui no guarda-roupas
    public function getWardrobe(int $userId): array
    {
        $stmt = $this->db->prepare("
            SELECT c.id, c.name, c.slug 
            FROM slivi_clothes c
            INNER JOIN slivi_user_wardrobe uw ON c.id = uw.cloth_id
            WHERE uw.user_id = ?
            ORDER BY c.name
        ");
        $stmt->execute([$userId]);

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
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
}