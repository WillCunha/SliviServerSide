<?php

declare(strict_types=1);
// Força o erro a aparecer mesmo se o servidor tentar esconder
ini_set('display_errors', '1');
error_reporting(E_ALL);

require_once __DIR__ . '/SliviService.php';
require_once __DIR__ . '/WeatherServices.php';

class NotificationService
{
    private PDO $db;
    private SliviService $sliviService;
    private WeatherServices $weatherService;

    // URL oficial da API do Expo
    private string $expoApiUrl = 'https://exp.host/--/api/v2/push/send';

    // Configuração de Cooldown (em minutos) para não spammar
    private array $cooldowns = [
        'HUNGER_LOW'   => 120, // 2 horas
        'ENERGY_LOW'   => 180, // 3 horas
        'BORED'        => 240, // 4 horas
        'BRAVO'        => 240, // 4 horas
        'COLD'         => 360, // 6 horas
        'RAIN'         => 360  // 6 horas
    ];

    public function __construct(PDO $db)
    {
        $this->db = $db;
        $this->sliviService = new SliviService($db);
        $this->weatherService = new WeatherServices();
    }

    /**
     * Lógica principal chamada pelo CRON
     */
    public function checkAndNotify(int $userId): int
    {
        $sentCount = 0;
        $state = $this->sliviService->getFullState($userId);
        $stats = $state['states'];

        // 1. Gatilho de FOME
        if (($stats['HUNGER'] ?? 100) < 50) {
            if ($this->tryNotify($userId, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.')) {
                $sentCount++;
            }
        }

        // 2. Gatilho de SONO
        if (($stats['ENERGY'] ?? 100) < 30) {
            if ($this->tryNotify($userId, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.')) {
                $sentCount++;
            }
        }

        // 3. Gatilho de TÉDIO
        if (($stats['FUN'] ?? 100) < 40) {
            if ($this->tryNotify($userId, 'BORED', 'Que tédio... 🎾', 'O Slivi quer brincar!')) {
                $sentCount++;
            }
        }
        // 3. Gatilho de TÉDIO
        if (($stats['BRAVO'] ?? 100) < 30) {
            if ($this->tryNotify($userId, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!')) {
                $sentCount++;
            }
        }

        // 4. Soma as notificações de CLIMA
        $sentCount += $this->checkWeatherConditions($userId);

        return $sentCount;
    }

    /**
     * Agora retorna quantas notificações de clima foram enviadas
     */
    private function checkWeatherConditions(int $userId): int
    {
        $weatherSent = 0;
        $stmt = $this->db->prepare("SELECT latitude, longitude FROM user_locations WHERE user_id = ? LIMIT 1");
        $stmt->execute([$userId]);
        $loc = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$loc) return 0;

        $weather = $this->weatherService->getWeather((float)$loc['latitude'], (float)$loc['longitude']);

        // Frio
        if ($weather['temp'] < 15) {
            if ($this->tryNotify($userId, 'COLD', 'Brrr! Esfriou ❄️', 'Vista o Slivi adequadamente!')) {
                $weatherSent++;
            }
        }

        // Chuva
        if ($weather['condition'] === 'rain') {
            if ($this->tryNotify($userId, 'RAIN', 'Está chovendo! ☔', 'Não deixe o Slivi pegar chuva.')) {
                $weatherSent++;
            }
        }

        return $weatherSent;
    }

    /**
     * Registra a atividade em um arquivo .log
     */
    private function logActivity(int $userId, string $type, string $title): void
    {
        // Define o caminho da pasta de logs (na raiz do projeto ou dentro de services)
        $logDir = __DIR__ . '/logs';

        // Cria a pasta se não existir
        if (!is_dir($logDir)) {
            mkdir($logDir, 0777, true);
        }

        $logFile = $logDir . '/notifications.log';
        $timestamp = date('Y-m-d H:i:s');



        $logEntry = "[$timestamp] USER: $userId | TYPE: $type | TITLE: \"$title\" " . PHP_EOL;

        // Escreve no arquivo (FILE_APPEND evita sobrescrever o arquivo antigo)
        file_put_contents($logFile, $logEntry, FILE_APPEND);
    }

    /**
     * Agora retorna TRUE se a notificação foi enviada ou FALSE se caiu no cooldown
     */
    private function tryNotify(int $userId, string $type, string $title, string $message): bool
    {
        $lastTime = $this->getLastNotificationTime($userId, $type);
        $cooldownMinutes = $this->cooldowns[$type] ?? 60;

        if ($lastTime) {
            $minutesSince = (time() - strtotime($lastTime)) / 60;
            if ($minutesSince < $cooldownMinutes) {
                return false; // Bloqueado pelo cooldown
            }
        }

        $this->saveNotification($userId, $type, $title, $message);
        $this->sendExpoPush($userId, $title, $message, ['type' => $type]);

        $this->logActivity($userId, $type, $title);

        return true; // Enviado com sucesso
    }

    /**
     * Envia o POST para a API do Expo
     */
    private function sendExpoPush(int $userId, string $title, string $body, array $data = []): void
    {
        // Busca o token do usuário
        $stmt = $this->db->prepare("SELECT device_token FROM users WHERE id = ?");
        $stmt->execute([$userId]);
        $token = $stmt->fetchColumn();

        // Validação básica do token do Expo
        if (!$token || (strpos($token, 'ExponentPushToken') === false && strpos($token, 'ExpoPushToken') === false)) {
            // Token inválido ou não existe -> não faz nada
            return;
        }

        // Payload do Expo
        $payload = [
            'to' => $token,
            'title' => $title,
            'body' => $body,
            'sound' => 'default', // Toca som padrão do iOS/Android
            'data' => $data,      // Dados extras para deep linking se precisar
            'badge' => 1,         // Opcional: Adiciona bolinha vermelha no ícone
        ];

        // Configuração do cURL
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $this->expoApiUrl);
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'Content-Type: application/json',
            'Accept: application/json',
            'Accept-Encoding: gzip, deflate'
        ]);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($payload));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        // Executa
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);

        // Log de erro simples (opcional)
        if ($httpCode !== 200) {
            error_log("Erro ao enviar Expo Push User [$userId]: " . ($response ?: 'Sem resposta'));
        }

        curl_close($ch);
    }

    // --- Helpers de Banco de Dados ---

    private function getLastNotificationTime(int $userId, string $type): ?string
    {
        $stmt = $this->db->prepare("
            SELECT created_at FROM slivi_notifications 
            WHERE user_id = ? AND type = ? 
            ORDER BY created_at DESC LIMIT 1
        ");
        $stmt->execute([$userId, $type]);
        return $stmt->fetchColumn() ?: null;
    }

    private function saveNotification(int $userId, string $type, string $title, string $message): void
    {
        $stmt = $this->db->prepare("
            INSERT INTO slivi_notifications (user_id, type, title, message)
            VALUES (?, ?, ?, ?)
        ");
        $stmt->execute([$userId, $type, $title, $message]);
    }

    // Método para a API listar notificações no app
    public function getNotifications(int $userId): array
    {
        $stmt = $this->db->prepare("
            SELECT id, type, title, message, created_at, is_read 
            FROM slivi_notifications 
            WHERE user_id = ? 
            ORDER BY created_at DESC 
            LIMIT 20
        ");
        $stmt->execute([$userId]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
