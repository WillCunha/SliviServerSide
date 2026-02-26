<?php

declare(strict_types=1);

require_once __DIR__ . '/../utils/Response.php';
require_once __DIR__ . '/../auth/AuthService.php';
require_once __DIR__ . '/../services/GameQuizService.php';

class GameQuizController
{
    private GameQuizService $quizService;

    public function __construct(PDO $db)
    {
        $this->quizService = new GameQuizService($db);
    }

    /**
     * GET /slivi/game/quiz/questions
     * Retorna o deck de perguntas para a partida
     */
    public function getQuestions(): void
    {
        try {
            // Valida se o usuário está logado
            AuthService::getUserIdFromHeader(); 
            
            // Busca 40 perguntas (para garantir que não falte na partida)
            $questions = $this->quizService->getRandomQuestions(40);

            Response::success(['questions' => $questions]);
        } catch (Exception $e) {
            Response::error($e->getMessage(), 401);
        }
    }

    /**
     * POST /slivi/game/quiz/finish
     * Recebe o payload do final da partida do Firebase/RN
     */
    public function finishMatch(): void
    {
        try {
            $userId = AuthService::getUserIdFromHeader();

            $body = json_decode(file_get_contents('php://input'), true);
            if (!$body) {
                throw new Exception('Payload de partida inválido.');
            }

            $this->quizService->processMatchResult($userId, $body);

            Response::success([
                'message' => 'Partida finalizada e status do Slivi atualizados!',
                'matchData' => $body
            ]);
        } catch (Exception $e) {
            Response::error($e->getMessage(), 400);
        }
    }
}