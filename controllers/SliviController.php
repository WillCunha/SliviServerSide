<?php

declare(strict_types=1);

require_once __DIR__ . '/../utils/Response.php';
require_once __DIR__ . '/../auth/AuthService.php';
require_once __DIR__ . '/../services/SliviService.php';
<<<<<<< HEAD
require_once __DIR__ . '/../services/ObjectivesService.php';
=======
>>>>>>> 9635734cbf4a11846b3b35f0d1d088150a6d72f7

class SliviController
{
    private SliviService $sliviService;
<<<<<<< HEAD
    private PDO $db;

    public function __construct(PDO $db)
    {
        $this->db = $db;
=======

    public function __construct(PDO $db)
    {
>>>>>>> 9635734cbf4a11846b3b35f0d1d088150a6d72f7
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
<<<<<<< HEAD
        // $gameService = new GameService();
        $objService = new ObjectivesService($this->db);

        try {
            $userId = AuthService::getUserIdFromHeader();
            $data = json_decode(file_get_contents('php://input'), true);

            if (!isset($data['game'], $data['score'], $data['stats'])) {
=======
        try {
            $userId = AuthService::getUserIdFromHeader();
            $body = json_decode(file_get_contents('php://input'), true);

            if (!isset($body['game'], $body['score'])) {
>>>>>>> 9635734cbf4a11846b3b35f0d1d088150a6d72f7
                throw new Exception('Dados do jogo incompletos');
            }

            $result = $this->sliviService->playGame(
                $userId,
<<<<<<< HEAD
                strtoupper($data['game']),
                (int)$data['score'],
                (int)($data['duration'] ?? 0)
            );

            // $gameService->save($userId, $data['game'], $data['score'], $data['duration']);

            // 2. Processa os objetivos
            // O array 'stats' deve vir do app com tudo: 'max_score', 'fever_count', etc.
            $objService->checkProgress($data['game'], (int)$data['score'], $data['stats']);
            

=======
                strtoupper($body['game']),
                (int)$body['score'],
                (int)($body['duration'] ?? 0)
            );

>>>>>>> 9635734cbf4a11846b3b35f0d1d088150a6d72f7
            Response::success($result);
        } catch (Exception $e) {
            Response::error($e->getMessage(), 400);
        }
    }
}
