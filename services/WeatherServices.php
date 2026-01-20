<?php
declare(strict_types=1);

class WeatherServices
{
    private string $apiKey = '793d17c2b555411d93f165721262001';
    private string $baseUrl = 'http://api.weatherapi.com/v1/current.json';

    public function getWeather(float $lat, float $lon): array
    {
        $url = "{$this->baseUrl}?key={$this->apiKey}&q={$lat},{$lon}&aqi=no";

        // Inicializa CURL
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);

        if ($httpCode !== 200 || !$response) {
            // Fallback (padrão) caso a API falhe: Sol e 25 graus
            return [
                'temp' => 25,
                'condition' => 'sun',
                'is_day' => 1
            ];
        }

        $data = json_decode($response, true);
        return $this->formatData($data);
    }

    // Traduz a resposta da WeatherAPI para o "Dialeto do Slivi"
    private function formatData(array $data): array
    {
        $conditionCode = $data['current']['condition']['code'];
        $isDay = $data['current']['is_day']; // 1 = dia, 0 = noite
        
        // Mapeamento simplificado (WeatherAPI Codes)
        $gameCondition = 'sun';

        // Códigos de chuva/garoa/tempestade
        if (in_array($conditionCode, [1063, 1150, 1153, 1180, 1183, 1186, 1189, 1192, 1195, 1240, 1243, 1273, 1276])) {
            $gameCondition = 'rain';
        }
        // Códigos de nublado
        elseif (in_array($conditionCode, [1003, 1006, 1009])) {
            $gameCondition = 'cloudy';
        }
        
        // Se for noite e não estiver chovendo, forçamos 'night' para o background
        if ($isDay === 0 && $gameCondition !== 'rain') {
            $gameCondition = 'night';
        }

        return [
            'temp' => (int) $data['current']['temp_c'],
            'condition' => $gameCondition, // 'rain', 'sun', 'cloudy', 'night'
            'is_day' => (bool) $isDay
        ];
    }
}