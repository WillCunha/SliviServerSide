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
     * POST /slivi/game/quiz/create
     * Cria uma sala aguardando jogador (padrão: privada, para link)
     */
    public function createRoom(): void
    {
        try {
            $userId = AuthService::getUserIdFromHeader();

            $body = json_decode(file_get_contents('php://input'), true);
            $isPublic = $body['isPublic'] ?? false; // Se false, é sala de convite

            $questions = $this->quizService->getRandomQuestions(30);
            $roomId = $this->quizService->createFirebaseRoom((string)$userId, $isPublic, $questions);

            Response::success([
                'roomId' => $roomId,
                'questions' => $questions,
                'status' => 'waiting'
            ]);
        } catch (Exception $e) {
            Response::error($e->getMessage(), 401);
        }
    }

    /**
     * POST /slivi/game/quiz/join
     * Entra em uma sala específica (via link/código)
     */
    public function joinRoom(): void
    {
        try {
            $userId = AuthService::getUserIdFromHeader();
            $body = json_decode(file_get_contents('php://input'), true);
            $roomId = $body['roomId'] ?? null;

            if (!$roomId) throw new Exception("ID da sala é obrigatório.");

            // 1. Busca os dados da sala no Firebase
            $roomData = $this->quizService->getFirebaseRoom($roomId);
            if (!$roomData) throw new Exception("Sala não encontrada.");
            if ($roomData['status'] !== 'waiting') throw new Exception("Esta partida já começou ou foi finalizada.");

            // 2. Extrai os IDs das perguntas que já estão na sala
            $deckIds = $roomData['deck'] ?? [];
            $hostId = array_key_first($roomData['players']);
            $hostHandIds = $roomData['players'][$hostId]['hand'] ?? [];

            $allQuestionIds = array_merge($deckIds, $hostHandIds);

            // 3. Busca o texto EXATO dessas perguntas no banco de dados
            $questions = $this->quizService->getQuestionsByIds($allQuestionIds);

            // 4. Entra na sala no Firebase (pega as cartas e muda pra playing)
            $this->quizService->joinFirebaseRoom($roomId, (string)$userId, $deckIds);

            Response::success([
                'roomId' => $roomId,
                'questions' => $questions,
                'status' => 'playing'
            ]);
        } catch (Exception $e) {
            Response::error($e->getMessage(), 400);
        }
    }

    /**
     * POST /slivi/game/quiz/matchmake
     * Procura partida online. Se não achar, cria uma pública.
     */
    public function matchmake(): void
    {
        try {
            $userId = AuthService::getUserIdFromHeader();

            // 1. Tenta achar uma sala pública esperando
            $availableRoomId = $this->quizService->findWaitingPublicRoom();

            if ($availableRoomId) {
                // Achou! Injeta o ID no body e simula a função de Join
                $_POST['roomId'] = $availableRoomId;
                $json = json_encode(['roomId' => $availableRoomId]);
                file_put_contents('php://input', $json);
                $this->joinRoom();
                return;
            }

            // 2. Não achou? Então cria uma nova sala PÚBLICA e fica esperando
            $questions = $this->quizService->getRandomQuestions(30);
            $roomId = $this->quizService->createFirebaseRoom((string)$userId, true, $questions);

            Response::success([
                'roomId' => $roomId,
                'questions' => $questions,
                'status' => 'waiting'
            ]);
        } catch (Exception $e) {
            Response::error($e->getMessage(), 400);
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
