<?php

declare(strict_types=1);

require_once  __DIR__ . '/ClothingService.php';

class TemperatureService
{
    private PDO $db;
    private ClothingService $clothingService;

    public function __construct(PDO $db, ClothingService $clothingService)
    {
        $this->db = $db;
        // Recebemos o ClothingService já instanciado para não abrir duas conexões no banco
        $this->clothingService = $clothingService;
    }

    /**
     * Calcula a temperatura alvo ideal para o Slivi com base no clima real e nas roupas equipadas.
     * Retorna um float entre 0 e 100.
     */
    public function getTargetTemperature(int $userId): float
    {
        $realTempC = $this->getRealWeatherTemperature($userId);
        $averageClothingTemp = $this->getAverageClothingTemperature($userId);

        // Calcula o Alvo
        $baseTarget = ($realTempC - 25) * 2 + 50;
        $clothingModifier = ($averageClothingTemp - 50) / 1.5;

        return (float) max(0, min(100, $baseTarget + $clothingModifier));
    }

    private function getRealWeatherTemperature(int $userId): float
    {
        $stmt = $this->db->prepare("SELECT last_temperature FROM user_locations WHERE user_id = ? ORDER BY id DESC");
        $stmt->execute([$userId]);
        $weatherData = $stmt->fetch(PDO::FETCH_ASSOC);



        return (float) ($weatherData['last_temperature'] ?? 25);
    }

    private function getAverageClothingTemperature(int $userId): float
    {
        $temperatures = $this->clothingService->getEquippedTemperatures($userId);

        if (empty($temperatures)) {
            return 50.0;
        }

        $totalClothingTemp = array_sum($temperatures);
        $clothingCount = count($temperatures);

        return $totalClothingTemp / $clothingCount;
    }
}
