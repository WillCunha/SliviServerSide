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
require_once __DIR__ . '/controllers/ClothingController.php';
require_once __DIR__ . '/controllers/CronController.php';
require_once __DIR__ . '/controllers/FoodController.php';
require_once __DIR__ . '/controllers/GameQuizController.php';
require_once __DIR__ . '/controllers/LocalizationController.php';
require_once __DIR__ . '/services/ObjectivesService.php';
require_once __DIR__ . '/controllers/SliviController.php';
require_once __DIR__ . '/controllers/SpeechController.php';


// Router simples
$method = $_SERVER['REQUEST_METHOD'];
$path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

// Remove /slivi-game/api do início, se existir
$path = str_replace('/slivi-game/api', '', $path);

$db = Database::getConnection();

try {
    // LOGIN
    if ($path === '/auth/login' && $method === 'POST') {

        AuthController::login();
    }

    // ATUAILZA DEVICE-TOKEN
    if ($path === '/auth/device-token' && $method === 'POST') {
        AuthController::updateDeviceToken();
        exit;
    }

    // CAPTURA STATUS
    if ($path === '/slivi/state' && $method === 'GET') {
        $controller = new SliviController($db);
        $controller->state();
    }

    // EXECUTA UMA AÇÃO
    if ($path === '/slivi/action' && $method === 'POST') {
        $controller = new SliviController($db);
        $controller->action();
    }

    //CAPTURA TODAS AS COMIDAS DISPONÍVEIS
    if ($path === '/slivi/foods' && $method === 'GET') {
        (new FoodController($db))->index();
        exit;
    }

    // ATUALIZA A LOCALIZAÇÃO
    if ($path === '/location/sync' && $method === 'POST') {
        $controller = new LocalizationController($db);
        $controller->sync();
        exit;
    }

    // INICIO SISTEMA DE ROUPAS
    if ($path === '/slivi/wardrobe' && $method === 'GET') {
        (new ClothingController($db))->index();
        exit;
    }

    if ($path === '/slivi/wardrobe/equipped' && $method === 'GET') {
        (new ClothingController($db))->equipped();
        exit;
    }

    if ($path === '/slivi/wardrobe/equip' && $method === 'POST') {
        (new ClothingController($db))->equip();
        exit;
    }
    // FIM SISTEMA DE ROUPAS

    // INÍCIO SISTEMA DE NOTIFICAÇÃO
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


    if ($path === '/slivi/notifications' && $method === 'GET') {
        $userId = 1;

        $service = new NotificationService($db);
        $data = $service->getNotifications($userId);

        Response::success($data);
    }
    // FIM SISTEMA DE NOTIFICAÇÃO

    // INICIO SISTEMA DE FALA
    if ($path === '/slivi/speech/generate' && $method === 'POST') {
        require_once __DIR__ . '/controllers/SpeechController.php';
        (new SpeechController($db))->generate();
        exit;
    }

    if ($path === '/slivi/speech/pending' && $method === 'GET') {
        require_once __DIR__ . '/controllers/SpeechController.php';
        (new SpeechController($db))->getPending();
        exit;
    }

    if ($path === '/slivi/speech/read' && $method === 'POST') {
        require_once __DIR__ . '/controllers/SpeechController.php';
        (new SpeechController($db))->markRead();
        exit;
    }
    // FIM SISTEMA DE FALA

    // INICIO SISTEMA DE MINIGAMES
    if ($path === '/slivi/game' && $method === 'POST') {
        $controller = new SliviController($db);
        $controller->game();
    }

    if ($method === 'GET' && preg_match('#^/slivi/objectives/([a-zA-Z0-9_-]+)$#', $path, $matches)) {

        require_once __DIR__ . '/services/ObjectivesService.php';

        $game = $matches[1]; // pulse | maestro | futuros jogos

        // (opcional, mas recomendado)
        $allowedGames = ['pulse', 'maestro'];
        if (!in_array($game, $allowedGames)) {
            Response::error('Game inválido', 400);
            exit;
        }

        $service = new ObjectivesService($db);
        $objectives = $service->getActiveObjectives($game);

        Response::success($objectives);
        exit;
    }
    // FIM SISTEMA DE MINIGAMES

    // INÍCIO SISTEMA GAME QUIZ BATTLE
    if ($path === '/slivi/game/quiz/questions' && $method === 'GET') {
        (new GameQuizController($db))->getQuestions();
        exit;
    }

    if ($path === '/slivi/game/quiz/finish' && $method === 'POST') {
        (new GameQuizController($db))->finishMatch();
        exit;
    }
    // FIM SISTEMA GAME QUIZ BATTLE


    Response::error('Rota não encontrada' . $_SERVER['REQUEST_URI'], 404);
} catch (Throwable $e) {
    Response::error(
        'Erro interno: ' . $e->getMessage(),
        500
    );
}
