<?php

declare(strict_types=1);

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
    public function checkAndNotify(int $userId): void
    {
        // 1. Atualiza estado para ter dados frescos
        $state = $this->sliviService->getFullState($userId);
        
        // Se estiver dormindo, não notificamos (modo "Não Perturbe" natural)
        if ($state['isSleeping']) {
            return; 
        }

        $stats = $state['states']; // [HUNGER => 80, ENERGY => 90...]

        // --- REGRAS DE GATILHO ---

        // 1. FOME (< 30)
        if (($stats['HUNGER'] ?? 100) < 30) {
            $this->tryNotify($userId, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer para não ficar doente.');
        }

        // 2. SONO (< 20)
        if (($stats['ENERGY'] ?? 100) < 20) {
            $this->tryNotify($userId, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto. Coloque-o para dormir!');
        }

        // 3. DIVERSÃO/TÉDIO (< 30)
        if (($stats['FUN'] ?? 100) < 30) { // Assumindo que FUN existe no states
            $this->tryNotify($userId, 'BORED', 'Que tédio... 🎾', 'O Slivi quer brincar com você!');
        }

        // 4. CLIMA (Verifica externamente)
        $this->checkWeatherConditions($userId);
    }

    private function checkWeatherConditions(int $userId): void
    {
        // Busca Lat/Lon do usuário na tabela user_locations (ou users se estiver lá)
        // Ajuste a query conforme onde você guarda a geolocalização
        $stmt = $this->db->prepare("SELECT lat, lon FROM user_locations WHERE user_id = ? LIMIT 1");
        $stmt->execute([$userId]);
        $loc = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$loc) return; // Sem localização, ignoramos clima

        // Chama seu WeatherService existente
        $weather = $this->weatherService->getWeather((float)$loc['lat'], (float)$loc['lon']);

        // Frio (< 15°C)
        if ($weather['temp'] < 15) {
            $this->tryNotify($userId, 'COLD', 'Brrr! Esfriou ❄️', 'Vista o Slivi adequadamente!');
        }

        // Chuva
        if ($weather['condition'] === 'rain') {
            $this->tryNotify($userId, 'RAIN', 'Está chovendo! ☔', 'Não deixe o Slivi pegar chuva.');
        }
    }

    /**
     * Verifica cooldown, salva no banco e envia PUSH
     */
    private function tryNotify(int $userId, string $type, string $title, string $message): void
    {
        // 1. Verifica Cooldown (Anti-Spam)
        $lastTime = $this->getLastNotificationTime($userId, $type);
        $cooldownMinutes = $this->cooldowns[$type] ?? 60; // Default 1h

        if ($lastTime) {
            $minutesSince = (time() - strtotime($lastTime)) / 60;
            if ($minutesSince < $cooldownMinutes) {
                return; // Ainda está no tempo de espera, abortar.
            }
        }

        // 2. Salva no Histórico (Sininho do App)
        $this->saveNotification($userId, $type, $title, $message);

        // 3. Envia Push Notification (Expo)
        $this->sendExpoPush($userId, $title, $message, ['type' => $type]);
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