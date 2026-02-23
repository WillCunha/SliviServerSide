<?php

declare(strict_types=1);
error_reporting(E_ALL);
    ini_set('display_errors', '1');

require_once __DIR__ . '/../services/NotificationService.php';

class CronController
{
    private PDO $db;
    private NotificationService $notificationService;

    public function __construct(PDO $db)
    {
        $this->db = $db;
        $this->notificationService = new NotificationService($db);
    }

  public function processNotifications(): void
    {
        try {
            $stmt = $this->db->query("SELECT id FROM users WHERE active = 1");
            $users = $stmt->fetchAll(PDO::FETCH_COLUMN);

            $totalSent = 0;
            foreach ($users as $userId) {
                // Aqui somamos o retorno de checkAndNotify
                $totalSent += $this->notificationService->checkAndNotify((int)$userId);
            }

            echo json_encode([
                'status' => 'success', 
                'processed' => $totalSent, // Mostrará o total de notificações gravadas
                'users_checked' => count($users)
            ]);

        } catch (Throwable $e) {
            echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
        }
    }
}