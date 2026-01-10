<?php
declare(strict_types=1);

class Response
{
    public static function json(
        array $data,
        int $statusCode = 200
    ): void {
        http_response_code($statusCode);
        header('Content-Type: application/json; charset=utf-8');

        echo json_encode(
            $data,
            JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES
        );

        exit;
    }

    public static function error(
        string $message,
        int $statusCode = 400
    ): void {
        self::json([
            'success' => false,
            'error'   => $message
        ], $statusCode);
    }

    public static function success(
        array $data = [],
        int $statusCode = 200
    ): void {
        self::json([
            'success' => true,
            'data'    => $data
        ], $statusCode);
    }
}
