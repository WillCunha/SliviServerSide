<?php

declare(strict_types=1);

require_once __DIR__ . '/../utils/Response.php';
require_once __DIR__ . '/../auth/AuthService.php';
require_once __DIR__ . '/../services/ClothingService.php';

class ClothingController
{
    private ClothingService $clothingService;

    public function __construct(PDO $db)
    {
        $this->clothingService = new ClothingService($db);
    }

    /**
     * GET /slivi/wardrobe
     * Retorna todas as roupas do usuário
     */
    public function index(): void
    {
        try {
            $userId = AuthService::getUserIdFromHeader();
            $clothes = $this->clothingService->getWardrobe($userId);

            Response::success($clothes);
        } catch (Exception $e) {
            Response::error($e->getMessage(), 401);
        }
    }

    /**
     * GET /slivi/store/clothes
     * Retorna todas as roupas disponíveis na loja, separadas por categoria
     */
    public function store(): void
    {
        try {
            $userId = AuthService::getUserIdFromHeader();
            $storeItems = $this->clothingService->getStore($userId);

            Response::success($storeItems);
        } catch (Exception $e) {
            Response::error($e->getMessage(), 401);
        }
    }

    /**
     * POST /slivi/store/buy
     * Corpo esperado: { "cloth_id": 4 }
     */
    public function buy(): void
    {
        try {
            $userId = AuthService::getUserIdFromHeader();
            $body = json_decode(file_get_contents('php://input'), true);

            // Verifica se mandou o ID corretamente
            if (!isset($body['cloth_id'])) {
                throw new Exception("ID da roupa não informado.");
            }

            $clothId = (int) $body['cloth_id'];

            // Chama o service simplificado
            $this->clothingService->buyCloth($userId, $clothId);

            Response::success([
                'message' => 'Roupa comprada com sucesso!',
                'cloth_id' => $clothId
            ]);
        } catch (Exception $e) {
            Response::error($e->getMessage(), 400);
        }
    }

    /**
     * GET /slivi/wardrobe/cloth/{id}
     * Retorna os detalhes de uma roupa específica
     */
    public function show(int $id): void
    {
        try {
            $cloth = $this->clothingService->getClothById($id);

            if (!$cloth) {
                throw new Exception("Roupa não encontrada.");
            }

            Response::success($cloth);
        } catch (Exception $e) {
            Response::error($e->getMessage(), 404);
        }
    }

    /**
     * GET /slivi/wardrobe/equipped
     * Retorna apenas a roupa equipada atualmente
     */
    public function equipped(): void
    {
        try {
            $userId = AuthService::getUserIdFromHeader();
            $equipped = $this->clothingService->getEquipped($userId);

            Response::success(['equipped' => $equipped]);
        } catch (Exception $e) {
            Response::error($e->getMessage(), 401);
        }
    }

    /**
     * POST /slivi/wardrobe/equip
     * Corpo esperado: { "slug": "item-slug", "action": "EQUIP" | "REMOVE" }
     */
    public function equip(): void
    {
        try {
            $userId = AuthService::getUserIdFromHeader();

            $body = json_decode(file_get_contents('php://input'), true);
            if (!isset($body['slug'])) {
                throw new Exception('Slug da roupa não informado.');
            }

            $slug = $body['slug'];
            $action = strtoupper($body['action'] ?? 'EQUIP');

            if ($action === 'REMOVE') {
                // Lógica para tirar a roupa
                $this->clothingService->unequipClothing($userId, $slug);
                Response::success(['message' => 'Roupa removida!', 'slug' => $slug]);
            } else {
                // Lógica padrão para equipar (já existente)
                $this->clothingService->equipClothing($userId, $slug);
                Response::success(['message' => 'Roupa equipada com sucesso!', 'slug' => $slug]);
            }
        } catch (Exception $e) {
            Response::error($e->getMessage(), 400);
        }
    }
}
