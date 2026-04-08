<?php
declare(strict_types=1);

require_once __DIR__ . '/WeatherServices.php';

class LocalizationServices
{
    private PDO $db;
    private WeatherServices $weatherService;

    public function __construct(PDO $db)
    {
        $this->db = $db;
        $this->weatherService = new WeatherServices();
    }

    public function processLocation(int $userId, float $lat, float $lon): array
    {
        $weatherData = $this->weatherService->getWeather($lat, $lon);
        $this->saveUserLocation($userId, $lat, $lon, $weatherData['temp'], $weatherData['condition']);

        // 3. (Futuro) Verificar se é a "Casa" do usuário
        // $isHome = $this->checkIfHome($userId, $lat, $lon);
        
        return [
            'weather' => $weatherData,
            'location_saved' => true,
            // 'is_home' => $isHome // Exemplo futuro
        ];
    }

    private function saveUserLocation(int $userId, float $lat, float $lon, int $temp, string $condition): void
    {
        $stmt = $this->db->prepare("
            INSERT INTO user_locations (user_id, latitude, longitude, last_temperature, last_condition) 
            VALUES (:uid, :lat, :lon, :temp, :condition)
        ");
        
        $stmt->execute([
            ':uid' => $userId,
            ':lat' => $lat,
            ':lon' => $lon,
            ':temp' => $temp,
            ':condition' => $condition,
        ]);
    }
}