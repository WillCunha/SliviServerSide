<?php

declare(strict_types=1);

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Permitir chamadas do app (ajuste domínio em produção)
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: Content-Type, Authorization');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

// Autoload simples
require_once __DIR__ . '/config/database.php';
require_once __DIR__ . '/utils/Response.php';

// Controllers (vamos criar depois)
require_once __DIR__ . '/controllers/AuthController.php';
require_once __DIR__ . '/controllers/SliviController.php';
require_once __DIR__ . '/controllers/FoodController.php';


// Router simples
$method = $_SERVER['REQUEST_METHOD'];
$path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

// Remove /api do início, se existir
$path = str_replace('/slivi-game/api', '', $path);

$db = Database::getConnection();

try {
    // AUTH
    if ($path === '/auth/login' && $method === 'POST') {

        AuthController::login();
    }

    // SLIVI
    if ($path === '/slivi/state' && $method === 'GET') {
        $controller = new SliviController($db);
        $controller->state();
    }
    if ($path === '/slivi/action' && $method === 'POST') {
        $controller = new SliviController($db);
        $controller->action();
    }

    if ($path === '/slivi/foods' && $method === 'GET') {
        (new FoodController($db))->index();
        exit;
    }


    Response::error('Rota não encontrada' . $_SERVER['REQUEST_URI'], 404);
} catch (Throwable $e) {
    Response::error(
        'Erro interno: ' . $e->getMessage(),
        500
    );
}
