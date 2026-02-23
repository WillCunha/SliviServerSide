<?php

declare(strict_types=1);

require_once __DIR__ . '/../utils/Response.php';
require_once __DIR__ . '/../auth/AuthService.php';
require_once __DIR__ . '/../services/SpeechService.php';

class SpeechController
{
    private SpeechService $speechService;

    public function __construct(PDO $db)
    {
        $this->speechService = new SpeechService($db);
    }

    public function generate(): void
    {
        try {
            $userId = AuthService::getUserIdFromHeader();
            $result = $this->speechService->createAndSaveSpeech($userId);
            Response::success($result);
        } catch (Exception $e) {
            Response::error($e->getMessage(), 400);
        }
    }

    public function getPending(): void
    {
        try {
            $userId = AuthService::getUserIdFromHeader();
            $speech = $this->speechService->getUnreadSpeech($userId);
            Response::success(['speech' => $speech]);
        } catch (Exception $e) {
            Response::error($e->getMessage(), 401);
        }
    }

    public function markRead(): void
    {
        try {
            $userId = AuthService::getUserIdFromHeader();
            $body = json_decode(file_get_contents('php://input'), true);
            $speechId = (int)($body['speech_id'] ?? 0);

            $success = $this->speechService->markAsRead($userId, $speechId);
            Response::success(['success' => $success]);
        } catch (Exception $e) {
            Response::error($e->getMessage(), 400);
        }
    }
}