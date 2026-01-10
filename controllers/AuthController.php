<?php
declare(strict_types=1);

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../utils/Response.php';
require_once __DIR__ . '/../auth/AuthService.php';

class AuthController
{
    public static function login(): void
    {
        $input = json_decode(file_get_contents('php://input'), true);

        if (
            !isset($input['email']) ||
            !isset($input['password'])
        ) {
            Response::error('Email e senha são obrigatórios', 400);
        }

        $email = trim($input['email']);
        $password = $input['password'];

        $db = Database::getConnection();

        $stmt = $db->prepare(
            'SELECT id, password_hash FROM users WHERE email = :email'
        );
        $stmt->execute(['email' => $email]);

        $user = $stmt->fetch();
        
        $userId = $user['id'];

        if (!$user || !password_verify($password, $user['password_hash'])) {
            Response::error('Credenciais inválidas', 401);
        }

        $token = AuthService::generateToken((int)$user['id']);
        $stmt = $db->prepare("
        INSERT INTO sessions (user_id, session_token)
        VALUES (?, ?)
        ");
        $stmt->execute([$userId, $token]);

        

        Response::success([
            'token' => $token
        ]);
    }
}
