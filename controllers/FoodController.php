<?php

declare(strict_types=1);

require_once __DIR__ . '/../utils/Response.php';
require_once __DIR__ . '/../auth/AuthService.php';
require_once __DIR__ . '/../services/FoodService.php';

class FoodController
{
    private FoodService $foodService;

    public function __construct(PDO $db)
    {
        $this->foodService = new FoodService($db);
    }

    /**
     * GET /slivi/market/foods
     */
    public function market(): void
    {
        try {
            $foods = $this->foodService->getMarket();
            Response::success($foods);
        } catch (Exception $e) {
            Response::error($e->getMessage(), 500);
        }
    }

    /**
     * GET /slivi/fridge
     */
    public function fridge(): void
    {
        try {
            $userId = AuthService::getUserIdFromHeader();
            $foods = $this->foodService->getFridge($userId);
            Response::success($foods);
        } catch (Exception $e) {
            Response::error($e->getMessage(), 401);
        }
    }


 /**
     * POST /slivi/market/buy
     * Body esperado: 
     * {
     * "items": [
     * { "food_id": 1, "quantity": 2 },
     * { "food_id": 2, "quantity": 3 },
     * { "food_id": 5, "quantity": 1 }
     * ]
     * }
     */
   public function buy(): void
    {
        try {
            $userId = AuthService::getUserIdFromHeader();
            $body = json_decode(file_get_contents('php://input'), true);
            
            // Verifica se o array 'items' foi enviado corretamente
            if (!isset($body['items']) || !is_array($body['items'])) {
                throw new Exception("Formato de carrinho inválido. Envie um array de itens.");
            }

            // Manda o carrinho para o service processar
            $this->foodService->buyCart($userId, $body['items']);
            
            Response::success([
                'message' => "Compra realizada com sucesso! Os itens já estão na geladeira."
            ]);

        } catch (Exception $e) {
            // Repassa o erro de saldo insuficiente ou comida inválida
            Response::error($e->getMessage(), 400);
        }
    }
}
