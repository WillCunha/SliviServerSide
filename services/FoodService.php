<?php

declare(strict_types=1);
require_once __DIR__ . '/WalletService.php';


class FoodService
{
    private PDO $db;
    private WalletService $walletService;

    public function __construct(PDO $db)
    {
        $this->db = $db;
        $this->walletService = new WalletService($this->db);
    }

    // Mercado: Busca todas as comidas disponíveis para venda
    public function getMarket(): array
    {
        $stmt = $this->db->query("
            SELECT id, name, image_key, type, tasty, hunger, energy, happiness, temperature, price
            FROM foods
            ORDER BY name
        ");

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getById(int $foodId): array
    {
        $stmt = $this->db->prepare("
            SELECT id, name, image_key, type, tasty, hunger, energy, happiness, temperature, price
            FROM foods WHERE id = ? LIMIT 1
        ");
        $stmt->execute([$foodId]);
        $food = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$food) throw new Exception('Comida inválida');
        return $food;
    }

    // Geladeira: Busca apenas o que o usuário comprou e a quantidade
    public function getFridge(int $userId): array
    {
        $stmt = $this->db->prepare("
            SELECT f.id, f.name, f.image_key, f.type, f.tasty, f.hunger, f.energy, f.happiness, f.temperature, uf.quantity
            FROM foods f
            INNER JOIN slivi_user_fridge uf ON f.id = uf.food_id
            WHERE uf.user_id = ?
            ORDER BY f.name
        ");
        $stmt->execute([$userId]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Compra: Adiciona na geladeira ou incrementa a quantidade se já existir
    public function buyCart(int $userId, array $cartItems): void
    {
        if (empty($cartItems)) {
            throw new Exception("O carrinho está vazio.");
        }

        $totalPrice = 0;
        $validItems = [];

        foreach ($cartItems as $item) {
            $foodId = (int) ($item['food_id'] ?? 0);
            $quantity = (int) ($item['quantity'] ?? 0);

            if ($foodId <= 0 || $quantity <= 0) {
                continue; 
            }

            $food = $this->getById($foodId); 
            $totalPrice += (int)$food['price'] * $quantity;
            
            $validItems[] = [
                'food_id' => $foodId,
                'quantity' => $quantity
            ];
        }

        if (empty($validItems)) {
            throw new Exception("Nenhum item válido para compra.");
        }

        $this->db->beginTransaction();

        try {
            $this->walletService->spendCoins($userId, $totalPrice);

            $stmt = $this->db->prepare("
                INSERT INTO slivi_user_fridge (user_id, food_id, quantity)
                VALUES (?, ?, ?)
                ON DUPLICATE KEY UPDATE 
                    quantity = quantity + ?,
                    updated_at = NOW()
            ");

            foreach ($validItems as $item) {
                $stmt->execute([
                    $userId, 
                    $item['food_id'], 
                    $item['quantity'], 
                    $item['quantity'] 
                ]);
            }

            $this->db->commit();

        } catch (Exception $e) {
            $this->db->rollBack();
            throw $e;
        }
    }

    // Consumo: Subtrai 1 da quantidade. Se zerar, deleta a linha.
    public function consumeFood(int $userId, int $foodId): array
    {
        $stmtCheck = $this->db->prepare("SELECT quantity FROM slivi_user_fridge WHERE user_id = ? AND food_id = ? LIMIT 1");
        $stmtCheck->execute([$userId, $foodId]);
        $fridgeItem = $stmtCheck->fetch(PDO::FETCH_ASSOC);

        if (!$fridgeItem) {
            throw new Exception("Você não tem esta comida na geladeira.");
        }

        $currentQuantity = (int) $fridgeItem['quantity'];

        if ($currentQuantity > 1) {
            // Se tem mais de 1, apenas diminui
            $stmtUpdate = $this->db->prepare("UPDATE slivi_user_fridge SET quantity = quantity - 1 WHERE user_id = ? AND food_id = ?");
            $stmtUpdate->execute([$userId, $foodId]);
        } else {
            // Se tem 1, ele comeu o último. Deleta o registro.
            $stmtDelete = $this->db->prepare("DELETE FROM slivi_user_fridge WHERE user_id = ? AND food_id = ?");
            $stmtDelete->execute([$userId, $foodId]);
        }

        // Retorna os dados da comida para o Controller aplicar os status (fome, energia) no Slivi
        return $this->getById($foodId);
    }
}
