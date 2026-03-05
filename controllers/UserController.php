<?php

declare(strict_types=1);

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../utils/Response.php';

class UserController
{
    public static function getProfile(string $username): void
    {
        // Remove o '@' caso o front-end envie junto na requisição
        $username = ltrim($username, '@');

        $db = Database::getConnection();

        // Buscamos apenas os dados PÚBLICOS do usuário.
        // NUNCA inclua password_hash, email ou device_token aqui!
        $stmt = $db->prepare('
    SELECT username, slivi_name, created_at 
    FROM users 
    WHERE (username = :username 
           OR slivi_name = :slivi_name)
    AND active = 1
');

        $stmt->execute([
            'username' => $username,
            'slivi_name' => $username
        ]);

        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$user) {
            Response::error('Usuário não encontrado', 404);
        }

        // Você pode formatar a data de criação para ficar mais amigável, se quiser
        Response::success([
            'profile' => $user
        ]);
    }
}
