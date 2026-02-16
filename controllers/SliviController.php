<?php

declare(strict_types=1);

require_once __DIR__ . '/../utils/Response.php';
require_once __DIR__ . '/../auth/AuthService.php';
require_once __DIR__ . '/../services/SliviService.php';

class SliviController
{
    private SliviService $sliviService;

    public function __construct(PDO $db)
    {
        $this->sliviService = new SliviService($db);
    }

    /**
     * GET /slivi/state
     * Retorna o estado completo do Slivi
     */
    public function state(): void
    {
        try {
            // 1️⃣ Valida token e obtém user_id
            $userId = AuthService::getUserIdFromHeader();

            // 2️⃣ Busca estado completo
            try {
                $state = $this->sliviService->getFullState($userId);
            } catch (Exception $e) {
                // 3️⃣ Se não existir estado, cria o inicial
                $this->sliviService->createInitialState($userId);
                $state = $this->sliviService->getFullState($userId);
            }

            // 4️⃣ Retorna para o app
            Response::success($state);
        } catch (Exception $e) {
            Response::error($e->getMessage(), 401);
        }
    }

    /**
     * POST /slivi/action
     * Body:
     * { "action": "FEED", "foodId": 1 }
     * { "action": "SLEEP" }
     */
    public function action(): void
    {
        try {
            // 🔐 Valida token e obtém o user_id
            $userId = AuthService::getUserIdFromHeader();

            // 📥 Lê o body da requisição
            $body = json_decode(file_get_contents('php://input'), true);

            if (!isset($body['action'])) {
                throw new Exception('Ação não informada');
            }

            $action = strtoupper($body['action']);
            $foodId = $body['foodId'] ?? null; // 👈 agora é opcional

            // 🎮 Executa a ação no Slivi
            $result = $this->sliviService->performAction(
                $userId,
                $action,
                $foodId
            );

            // 📤 Retorna novo estado
            Response::success($result);
        } catch (Exception $e) {
            Response::error($e->getMessage(), 400);
        }
    }


    /**
     * POST /slivi/game
     * Body:
     * {
     *   "game": "SLIVI-PULSE",
     *   "score": 1240,
     *   "duration": 42
     * }
     */
    public function game(): void
    {
        try {
            $userId = AuthService::getUserIdFromHeader();
            $body = json_decode(file_get_contents('php://input'), true);

            if (!isset($body['game'], $body['score'])) {
                throw new Exception('Dados do jogo incompletos');
            }

            $result = $this->sliviService->playGame(
                $userId,
                strtoupper($body['game']),
                (int)$body['score'],
                (int)($body['duration'] ?? 0)
            );

            Response::success($result);
        } catch (Exception $e) {
            Response::error($e->getMessage(), 400);
        }
    }
}
