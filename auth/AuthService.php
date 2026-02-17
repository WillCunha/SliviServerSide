<?php

declare(strict_types=1);

class AuthService
{
    private static string $secret = 'SLIVI_SUPER_SECRET_KEY';
    private static string $algo   = 'HS256';
    private static int $ttl       = 86400; // 24h

    public static function generateToken(int $userId): string
    {
        $header = [
            'alg' => self::$algo,
            'typ' => 'JWT'
        ];

        $payload = [
            'sub' => $userId,
            'iat' => time(),
            'exp' => time() + self::$ttl
        ];

        $base64Header  = self::base64UrlEncode(json_encode($header));
        $base64Payload = self::base64UrlEncode(json_encode($payload));

        $signature = hash_hmac(
            'sha256',
            $base64Header . '.' . $base64Payload,
            self::$secret,
            true
        );

        $base64Signature = self::base64UrlEncode($signature);

        return $base64Header . '.' . $base64Payload . '.' . $base64Signature;
    }

    public static function validateToken(string $token): int
    {
        global $db; // PDO criado no index.php

        $stmt = $db->prepare("
            SELECT user_id
            FROM sessions
            WHERE session_token = ?
            LIMIT 1
        ");
        $stmt->execute([$token]);

        $row = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$row) {
            throw new Exception('Token inválido');
        }

        return (int) $row['user_id'];
    }

    public static function getUserIdFromHeader(): int
    {
        $headers = getallheaders();

        if (!isset($headers['Authorization'])) {
            throw new Exception('Token não enviado');
        }

        $token = str_replace('Bearer ', '', $headers['Authorization']);

        return self::validateToken($token);
    }

    public static function updateDeviceToken(int $userId, string $deviceToken): void
    {
        // Recomendo usar o Database::getConnection() como no AuthController
        $db = Database::getConnection();

        $stmt = $db->prepare("
            UPDATE users 
            SET device_token = ? 
            WHERE id = ?
        ");
        $stmt->execute([$deviceToken, $userId]);
    }

    private static function base64UrlEncode(string $data): string
    {
        return rtrim(strtr(base64_encode($data), '+/', '-_'), '=');
    }

    private static function base64UrlDecode(string $data): string
    {
        return base64_decode(strtr($data, '-_', '+/'));
    }
}
