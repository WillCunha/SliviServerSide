<?php

declare(strict_types=1);


require_once __DIR__ . '/../services/Games/GameService.php';

class GameController
{
    private GameService $gameService;
    private GameEventService $gameEventService;
    private PDO $db;


    public function __construct()
    {
        $db = Database::getConnection();
        $this->gameService = new GameService($db);
    }

    public function finish()
    {
        $data = json_decode(file_get_contents('php://input'), true);

        $this->gameService->finishGame(
            $data['user_id'],
            $data['game_code'],
            $data['score'],
            $data['metadata'] ?? []
        );

        echo json_encode(['success' => true]);
    }

    public function event()
    {
        $data = json_decode(file_get_contents('php://input'), true);

        $this->gameService->registerEvent(
            $data['user_id'],
            $data['event_code'],
            $data['value'] ?? null
        );

        echo json_encode(['success' => true]);
    }


 
}
