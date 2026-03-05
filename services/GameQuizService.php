<?php

declare(strict_types=1);

class GameQuizService
{
    private PDO $db;
    private string $firebaseUrl = "https://sliviproject-default-rtdb.firebaseio.com/rooms"; // Sua URL

    public function __construct(PDO $db)
    {
        $this->db = $db;
    }

    // ----- MÉTODOS DE BANCO DE DADOS (MySQL) -----

    public function getRandomQuestions(int $limit = 30): array
    {
        $stmt = $this->db->prepare("
            SELECT id, tema, nivel, pontos, enunciado, 
                   alternativa_a, alternativa_b, alternativa_c, resposta_correta 
            FROM slivi_questions_game 
            WHERE status = 1 
            ORDER BY RAND() 
            LIMIT ?
        ");
        $stmt->bindValue(1, $limit, PDO::PARAM_INT);
        $stmt->execute();
        return $this->formatQuestions($stmt->fetchAll(PDO::FETCH_ASSOC));
    }

    public function getQuestionsByIds(array $ids): array
    {
        if (empty($ids)) return [];
        $placeholders = implode(',', array_fill(0, count($ids), '?'));
        $stmt = $this->db->prepare("
            SELECT id, tema, nivel, pontos, enunciado, 
                   alternativa_a, alternativa_b, alternativa_c, resposta_correta 
            FROM slivi_questions_game 
            WHERE id IN ($placeholders)
        ");
        $stmt->execute($ids);
        return $this->formatQuestions($stmt->fetchAll(PDO::FETCH_ASSOC));
    }

    private function formatQuestions(array $rows): array
    {
        $deck = [];
        foreach ($rows as $row) {
            $deck[] = [
                'id' => $row['id'],
                'tema' => $row['tema'],
                'nivel' => $row['nivel'],
                'pontos' => $row['pontos'],
                'enunciado' => $row['enunciado'],
                'alternativas' => [
                    ['label' => 'A', 'texto' => $row['alternativa_a']],
                    ['label' => 'B', 'texto' => $row['alternativa_b']],
                    ['label' => 'C', 'texto' => $row['alternativa_c']]
                ],
                'resposta_correta' => $row['resposta_correta']
            ];
        }
        return $deck;
    }

    // ----- MÉTODOS DE INTEGRAÇÃO COM FIREBASE -----

    /**
     * Gera um código alfanumérico aleatório de 6 caracteres
     */
    private function generateRoomCode(int $length = 6): string
    {
        $chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        $code = '';
        for ($i = 0; $i < $length; $i++) {
            $code .= $chars[rand(0, strlen($chars) - 1)];
        }
        return $code;
    }

    public function createFirebaseRoom(string $hostId, bool $isPublic, array $questions): string
    {
        $allIds = array_column($questions, 'id');
        $handP1 = array_slice($allIds, 0, 7);
        $deck = array_slice($allIds, 7); // Guarda o resto (23) no deck

        $stmt = $this->db->prepare('SELECT * FROM users  WHERE id = :id');

        $stmt->execute(['id' => $hostId]);
        $user = $stmt->fetch();
        $userName = $user['username'];

        $roomId = $this->generateRoomCode(6);

        $roomData = [
            'status' => 'waiting',
            'is_public' => $isPublic,
            'timer' => 300,
            'current_turn' => $hostId,
            'last_action' => 'room_created',
            'deck' => $deck,
            'players' => [
                $hostId => [
                    'name' => $userName, // Puxe do banco de dados se quiser
                    'score' => 0,
                    'hand_count' => 7,
                    'hand' => $handP1
                ]
            ],
            'table' => ['active_question' => null, 'waiting_answer_from' => null]
        ];

        $ch = curl_init("{$this->firebaseUrl}/{$roomId}.json");
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'PUT'); // PUT força o nome do nó
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($roomData));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        $response = json_decode(curl_exec($ch), true);
        curl_close($ch);

        return $roomId; // ID da sala gerado pelo Firebase
    }

    public function findWaitingPublicRoom(): ?string
    {
        // Busca todas as salas (ideal em produção é usar regras de indexação no Firebase, mas assim funciona bem pro início)
        $ch = curl_init("{$this->firebaseUrl}.json");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        $rooms = json_decode(curl_exec($ch), true);
        curl_close($ch);

        if (!$rooms) return null;

        $logDir = __DIR__ . '/logs';

        $logFile = $logDir . '/firebase.log';
        $timestamp = date('Y-m-d H:i:s');


        // Escreve no arquivo (FILE_APPEND evita sobrescrever o arquivo antigo)
        foreach ($rooms as $roomId => $data) {
            if (($data['status'] ?? '') === 'waiting' && ($data['is_public'] ?? false) === true) {
                $dados = $data['status'];
                $logEntry = "$dados" . PHP_EOL;
                file_put_contents($logFile, $logEntry, FILE_APPEND);
                return $roomId;
            }
        }
        return null;
    }

    public function getFirebaseRoom(string $roomId): ?array
    {
        $ch = curl_init("{$this->firebaseUrl}/{$roomId}.json");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        $roomData = json_decode(curl_exec($ch), true);
        curl_close($ch);
        return $roomData;
    }

    public function joinFirebaseRoom(string $roomId, string $guestId, array $currentDeck): void
    {
        $handP2 = array_slice($currentDeck, 0, 7);
        $newDeck = array_slice($currentDeck, 7); // Restam 16 no baralho da mesa

        $stmt = $this->db->prepare('SELECT * FROM users  WHERE id = :id');

        $stmt->execute(['id' => $guestId]);
        $user = $stmt->fetch();
        $userName = $user['username'];

        $updates = [
            "status" => "playing",
            "deck" => $newDeck,
            "players/{$guestId}" => [
                'name' => $userName,
                'score' => 0,
                'hand_count' => 7,
                'hand' => $handP2
            ]
        ];

        $ch = curl_init("{$this->firebaseUrl}/{$roomId}.json");
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'PATCH'); // PATCH atualiza apenas os nós informados
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($updates));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_exec($ch);
        curl_close($ch);
    }

    /**
     * Processa o resultado da partida e atualiza os status do Slivi
     */
    public function processMatchResult(int $userId, array $matchData): void
    {
        // Exemplo de extração dos dados enviados pelo app
        $isWinner = $matchData['winnerId'] === $userId;
        $score = $matchData['score'] ?? 0;
        $durationMinutes = floor(($matchData['durationSeconds'] ?? 0) / 60);

        // Lógica de Status (Ajuste os nomes das colunas conforme sua tabela de status do Slivi)
        $humorBoost = $isWinner ? 15 : -5;
        $energyCost = $durationMinutes * 5; // Cansa 5 pontos por minuto jogado
        $xpGained = floor($score * 0.1);

        // Exemplo de UPDATE (Ajuste a tabela e os campos para a sua realidade)
        $stmt = $this->db->prepare("
            UPDATE slivi_user_status 
            SET 
                humor = LEAST(humor + ?, 100), 
                energy = GREATEST(energy - ?, 0),
                xp = xp + ?
            WHERE user_id = ?
        ");

        $stmt->execute([$humorBoost, $energyCost, $xpGained, $userId]);
    }
}
