<?php

class FoodService
{
    private PDO $db;

    public function __construct(PDO $db)
    {
        $this->db = $db;
    }

    public function getById(int $foodId): array
    {
        $stmt = $this->db->prepare("
            SELECT
                id,
                name,
                image_key,
                hunger,
                energy,
                happiness,
                temperature
            FROM foods
            WHERE id = ?
            LIMIT 1
        ");
        $stmt->execute([$foodId]);

        $food = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$food) {
            throw new Exception('Comida inválida');
        }

        return $food;
    }

    public function getAll(): array
    {
        $stmt = $this->db->query("
            SELECT
                id,
                name,
                image_key,
                hunger,
                energy,
                happiness,
                temperature
            FROM foods
            ORDER BY name
        ");

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
