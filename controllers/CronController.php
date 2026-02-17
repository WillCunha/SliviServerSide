<?php

declare(strict_types=1);

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
        // ATENÇÃO: Em produção com muitos usuários, você deve fazer paginação (chunks)
        // para não estourar a memória do PHP.
        
        // 1. Pegar IDs de usuários ativos (ex: logaram nas últimas 24h ou 48h)
        // Não faz sentido gastar processamento com usuários inativos há meses.
        $stmt = $this->db->query("
            SELECT id FROM users 
            WHERE active = 1 
            -- AND last_login > DATE_SUB(NOW(), INTERVAL 2 DAY) 
        ");
        
        $users = $stmt->fetchAll(PDO::FETCH_COLUMN);

        $count = 0;
        foreach ($users as $userId) {
            try {
                $this->notificationService->checkAndNotify((int)$userId);
                $count++;
            } catch (Exception $e) {
                // Loga erro mas não para o loop
                error_log("Erro no Cron User $userId: " . $e->getMessage());
            }
        }

        echo json_encode(['status' => 'success', 'processed' => $count]);
    }
}