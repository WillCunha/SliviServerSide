<?php

declare(strict_types=1);
date_default_timezone_set('America/Sao_Paulo'); 

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
require_once __DIR__ . '/controllers/CronController.php';
require_once __DIR__ . '/controllers/FoodController.php';
require_once __DIR__ . '/controllers/LocalizationController.php';
require_once __DIR__ . '/controllers/SliviController.php';


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

    if ($path === '/auth/device-token' && $method === 'POST') {
        AuthController::updateDeviceToken();
        exit;
    }

    // SLIVI
    if ($path === '/slivi/state' && $method === 'GET') {
        $controller = new SliviController($db);
        $controller->state();
    }

    if ($path === '/slivi/foods' && $method === 'GET') {
        (new FoodController($db))->index();
        exit;
    }

    if ($path === '/slivi/action' && $method === 'POST') {
        $controller = new SliviController($db);
        $controller->action();
    }

    if ($path === '/location/sync' && $method === 'POST') {
        $controller = new LocalizationController($db);
        $controller->sync();
        exit;
    }

    if ($path === '/slivi/game' && $method === 'POST') {
        $controller = new SliviController($db);
        $controller->game();
    }

    if ($path === '/cron/notify' && $method === 'GET') {

        $cronKey = $_GET['key'] ?? '';
        if ($cronKey !== 'a1b2c3d4e5f67890123456789abcdef0123456789abcdef0123456789abcdef0') {
            Response::error('Acesso negado', 403);
            exit;
        }

        $controller = new CronController($db);
        $controller->processNotifications();
        exit;
    }

    // ROTA PARA O APP LER AS NOTIFICAÇÕES (O "Sininho" do app)
    if ($path === '/slivi/notifications' && $method === 'GET') {
        // Assumindo que você pega o ID do user via Header ou Token
        // $userId = Auth::getUserId(); 
        $userId = 1; // Fixo para teste

        $service = new NotificationService($db);
        $data = $service->getNotifications($userId);

        Response::success($data);
    }


    Response::error('Rota não encontrada' . $_SERVER['REQUEST_URI'], 404);
} catch (Throwable $e) {
    Response::error(
        'Erro interno: ' . $e->getMessage(),
        500
    );
}
