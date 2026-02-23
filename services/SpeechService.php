<?php

declare(strict_types=1);

require_once __DIR__ . '/SliviService.php';

class SpeechService
{
    private PDO $db;
    private SliviService $sliviService;
    // private string $geminiApiKey = '';
    // private string $googleAuthPath = __DIR__ . '/../config/';

    public function __construct(PDO $db)
    {
        $this->db = $db;
        $this->sliviService = new SliviService($db);
    }

    public function createAndSaveSpeech(int $userId): array
    {
        $fullState = $this->sliviService->getFullState($userId); //
        $text = $this->callGemini($fullState);
        $filename = 'speech_' . $userId . '_' . time() . '.mp3';
        $audioUrl = $this->callGoogleTTS($text, $filename);

        $stmt = $this->db->prepare("INSERT INTO slivi_speeches (user_id, phrase, audio_url) VALUES (?, ?, ?)");
        $stmt->execute([$userId, $text, $audioUrl]);

        return ['id' => $this->db->lastInsertId(), 'phrase' => $text, 'audio_url' => $audioUrl];
    }

    public function getUnreadSpeech(int $userId): ?array
    {
        $stmt = $this->db->prepare("SELECT id, phrase, audio_url FROM slivi_speeches WHERE user_id = ? AND is_reproduced = 0 ORDER BY id ASC LIMIT 1");
        $stmt->execute([$userId]);
        return $stmt->fetch(PDO::FETCH_ASSOC) ?: null;
    }

    public function markAsRead(int $userId, int $speechId): bool
    {
        $stmt = $this->db->prepare("UPDATE slivi_speeches SET is_reproduced = 1 WHERE id = ? AND user_id = ?");
        return $stmt->execute([$speechId, $userId]);
    }

    private function classifySpeechContext(array $state): array
    {
        $hunger = $state['states']['HUNGER'];
        $energy = $state['states']['ENERGY'];
        $anger  = $state['states']['BRAVO']; 

        if ($energy < 15) {
            return [
                'topic' => 'sono_extremo',
                'description' => 'extremamente cansado e quase dormindo'
            ];
        }

        if ($hunger < 30) {
            return [
                'topic' => 'fome',
                'description' => 'com muita fome e desejando comer'
            ];
        }

        if ($anger > 60) {
            return [
                'topic' => 'raiva',
                'description' => 'irritado e de mau humor'
            ];
        }

        if ($energy < 30) {
            return [
                'topic' => 'sono',
                'description' => 'cansado e precisando descansar'
            ];
        }

        return [
            'topic' => 'neutro',
            'description' => 'calmo e estável'
        ];
    }

    private function callGemini(array $state): string
    {
        $url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key={$this->geminiApiKey}";

        $context = $this->classifySpeechContext($state);

        $prompt = "
Slivi é um pet virtual expressivo.

Neste momento, Slivi está {$context['description']}.

Ele fala como um personagem de jogo,
usando metáforas simples, desejos ou pensamentos,
em português, com apenas uma frase curta.

Tema da fala: {$context['topic']}.

Exemplos de estilo:
- Fome: \"Minha barriga está roncando, eu comeria qualquer coisa agora.\"
- Raiva: \"Hoje não estou num bom dia, melhor ficar quieto.\"
- Sono: \"Meus olhos estão pesados, preciso descansar um pouco.\"
- Sono extremo: \"Estou lutando para não dormir em pé.\"

A frase deve estar completa, sem cumprimentos,
sem perguntas e terminar com ponto final.

Frase:
";

        $logDir = __DIR__ . '/logs';

        $logFile = $logDir . '/speech.log';
        $timestamp = date('Y-m-d H:i:s');



        $logEntry = "[$timestamp]  PROMPT: $prompt " . PHP_EOL;

        // Escreve no arquivo (FILE_APPEND evita sobrescrever o arquivo antigo)
        file_put_contents($logFile, $logEntry, FILE_APPEND);

        $data = [
            "contents" => [
                [
                    "role" => "user",
                    "parts" => [
                        ["text" => $prompt]
                    ]
                ]
            ],
            "generationConfig" => [
                "temperature" => 0.7,
                "topP" => 0.9,
                "maxOutputTokens" => 5000
            ]
        ];

        $ch = curl_init($url);
        curl_setopt_array($ch, [
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_POST => true,
            CURLOPT_POSTFIELDS => json_encode($data),
            CURLOPT_HTTPHEADER => ['Content-Type: application/json'],
        ]);

        $response = curl_exec($ch);
        curl_close($ch);

        $res = json_decode($response, true);

        return trim($res['candidates'][0]['content']['parts'][0]['text'] ?? "Estou me sentindo estranho agora.");
    }

    private function callGoogleTTS(string $text, string $filename): string
    {
        $token = $this->getGoogleToken();
        $url = "https://texttospeech.googleapis.com/v1/text:synthesize";
        $payload = [
            'input' => ['text' => $text],
            'voice' => ['languageCode' => 'pt-BR', 'name' => 'pt-BR-Wavenet-B'],
            'audioConfig' => ['audioEncoding' => 'MP3', 'pitch' => 2.0]
        ];

        $ch = curl_init($url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, ["Authorization: Bearer $token", "Content-Type: application/json"]);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($payload));
        $res = json_decode(curl_exec($ch), true);
        curl_close($ch);

        $path = 'src/audios/' . $filename;
        file_put_contents(__DIR__ . '/../' . $path, base64_decode($res['audioContent']));
        return $path;
    }

    private function getGoogleToken(): string
    {
        $auth = json_decode(file_get_contents($this->googleAuthPath), true); //
        $header = base64_encode(json_encode(['alg' => 'RS256', 'typ' => 'JWT']));
        $payload = base64_encode(json_encode([
            'iss' => $auth['client_email'],
            'scope' => 'https://www.googleapis.com/auth/cloud-platform',
            'aud' => $auth['token_uri'],
            'iat' => time(),
            'exp' => time() + 3600
        ]));

        $sigInput = $header . "." . $payload;
        openssl_sign($sigInput, $sig, $auth['private_key'], "SHA256");
        $jwt = $sigInput . "." . base64_encode($sig);

        $ch = curl_init($auth['token_uri']);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query(['grant_type' => 'urn:ietf:params:oauth:grant-type:jwt-bearer', 'assertion' => $jwt]));
        $res = json_decode(curl_exec($ch), true);
        return $res['access_token'];
    }
}
