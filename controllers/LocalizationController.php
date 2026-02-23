<?php
declare(strict_types=1);

require_once __DIR__ . '/../services/LocalizationServices.php';

class LocalizationController
{
    private PDO $db;

    public function __construct(PDO $db)
    {
        $this->db = $db;
    }

    public function sync(): void
    {
        // Pega o corpo da requisição
        $data = json_decode(file_get_contents('php://input'), true);

        // Validação básica
        if (!isset($data['latitude']) || !isset($data['longitude']) || !isset($data['user_id'])) {
            Response::error('Dados de localização ou usuário inválidos', 400);
            return;
        }

        try {
            $service = new LocalizationServices($this->db);
            
            $result = $service->processLocation(
                (int)$data['user_id'],
                (float)$data['latitude'],
                (float)$data['longitude']
            );

            Response::success($result);

        } catch (Throwable $e) {
            // Log do erro real no servidor se necessário
            Response::error('Erro ao processar localização: ' . $e->getMessage(), 500);
        }
    }
}