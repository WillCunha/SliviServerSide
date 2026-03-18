<?php

declare(strict_types=1);

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../utils/Response.php';
require_once __DIR__ . '/../auth/AuthService.php';
require_once __DIR__ . '/../services/ClothingService.php';
require_once __DIR__ . '/../services/SliviService.php';

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

    // Adicione este método dentro da classe AuthController
    public static function updateDeviceToken(): void
    {
        try {
            // Verifica o token JWT no Header e retorna o ID do usuário logado
            $userId = AuthService::getUserIdFromHeader();

            $input = json_decode(file_get_contents('php://input'), true);

            if (!isset($input['device_token'])) {
                Response::error('Device token é obrigatório', 400);
            }

            $deviceToken = trim($input['device_token']);

            // Atualiza o token no banco
            AuthService::updateDeviceToken($userId, $deviceToken);

            Response::success([
                'message' => 'Device token atualizado com sucesso'
            ]);
        } catch (Exception $e) {
            // Se o JWT for inválido ou ausente, cai aqui
            Response::error($e->getMessage(), 401);
        }
    }

    public static function checkAvailability(): void
    {
        $input = json_decode(file_get_contents('php://input'), true);

        if (!isset($input['field']) || !isset($input['value'])) {
            var_dump($input);
            Response::error('Campo e valor são obrigatórios', 400);
        }

        $field = $input['field']; // 'email' ou 'username'
        $value = trim($input['value']);

        // Segurança extra: Garante que só podem pesquisar essas duas colunas (evita SQL Injection)
        if (!in_array($field, ['email', 'username'])) {
            Response::error('Campo inválido', 400);
        }

        $db = Database::getConnection();

        $stmt = $db->prepare("SELECT id FROM users WHERE $field = :value LIMIT 1");
        $stmt->execute(['value' => $value]);

        $exists = $stmt->fetch() ? true : false;

        Response::success([
            'exists' => $exists
        ]);
    }

    // Adicione este método dentro da classe AuthController
    public static function register(): void
    {
        $input = json_decode(file_get_contents('php://input'), true);

        // 1. Validação de dados obrigatórios
        if (
            !isset($input['email']) ||
            !isset($input['password']) ||
            !isset($input['username']) ||
            !isset($input['slivi_name'])
        ) {
            Response::error('Email, senha, username e nome do Slivi são obrigatórios', 400);
        }

        $email = trim($input['email']);
        $password = $input['password'];
        $username = trim($input['username']);
        $sliviName = trim($input['slivi_name']);

        // 2. Validação do formato do username (@)
        // Permite apenas letras, números e underscores, sem espaços.
        if (!preg_match('/^[a-zA-Z0-9_]+$/', $username)) {
            Response::error('O username deve conter apenas letras, números e underscores (sem espaços)', 400);
        }

        $db = Database::getConnection();

        // 3. Verifica se o email ou username já estão em uso
        $stmt = $db->prepare('SELECT id FROM users WHERE email = :email OR username = :username LIMIT 1');
        $stmt->execute([
            'email' => $email,
            'username' => $username
        ]);

        if ($stmt->fetch()) {
            Response::error('Email ou username já estão em uso', 409);
        }

        // 4. Cria o hash seguro para a senha
        $passwordHash = password_hash($password, PASSWORD_DEFAULT);

        // 5. Insere o novo usuário no banco de dados
        $stmt = $db->prepare("
            INSERT INTO users (username, slivi_name, password_hash, email, device_token, active)
            VALUES (:username, :slivi_name, :password_hash, :email, :device_token, :active)
        ");

        $stmt->execute([
            'username' => $username,
            'slivi_name' => $sliviName,
            'password_hash' => $passwordHash,
            'email' => $email,
            'device_token' => '', // Fica vazio até o app enviar via updateDeviceToken
            'active' => 1 // Define como ativo por padrão
        ]);

        $userId = (int) $db->lastInsertId();

        // 6. Gera o token (Auto-login) e salva a sessão
        $token = AuthService::generateToken($userId);
        $stmt = $db->prepare("
            INSERT INTO sessions (user_id, session_token)
            VALUES (?, ?)
        ");
        $stmt->execute([$userId, $token]);

        $sliviService = new SliviService($db);
        $sliviService->createInitialState($userId);

        $clothingService = new ClothingService($db);
        $clothingService->createWardrobe($userId);

        // 7. Retorna sucesso com o token
        Response::success([
            'message' => 'Usuário criado com sucesso',
            'token' => $token
        ]);
    }
}
