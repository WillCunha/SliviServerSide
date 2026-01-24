<?php

declare(strict_types=1);

require_once __DIR__ . '/TickService.php';
require_once __DIR__ . '/FoodService.php';

class SliviService
{
    private PDO $db;
    private FoodService $foodService;

    public function __construct(PDO $db)
    {
        $this->db = $db;
        $this->foodService = new FoodService($db);
    }

    /* =========================
       ESTADO DO SLIVI
       ========================= */

    public function getFullState(int $userId): array
    {
        // 1️⃣ Busca estados atuais
        $states = $this->getCharacterStates($userId);

        // 2️⃣Verifica se está dormindo
        $isSleeping = $this->isSleeping($userId);

        // 3️⃣ Aplica Tick
        $lastUpdate = $this->getLastUpdate($userId);
        $now = new DateTime();

        $tickService = new TickService();
        $updatedStates = $tickService->apply($states, $lastUpdate, $now, $isSleeping);

        // 3️⃣ Salva se mudou
        if ($updatedStates !== $states) {
            foreach ($updatedStates as $state => $value) {
                $stmt = $this->db->prepare("
                UPDATE character_states
                SET value = ?
                WHERE user_id = ? AND state = ?
            ");
                $stmt->execute([$value, $userId, $state]);
            }
        }

        // 4️⃣ Reavalia emoção
        [$emotionName, $color, $image] = $this->evaluateEmotion($updatedStates);

        $currentEmotion = $this->getCurrentEmotion($userId);
        if (!$currentEmotion || $currentEmotion['emotion'] !== $emotionName) {
            $this->addEmotion($userId, $emotionName, $color, $image);
        }

        // 5️⃣ Retorno IGUAL ao atual
        return [
            'emotion' => $emotionName,
            'color'   => $color,
            'image'   => $image,
            'isSleeping' => $isSleeping,
            'states'  => $updatedStates
        ];
    }


    private function getCurrentEmotion(int $userId): ?array
    {
        $stmt = $this->db->prepare("
            SELECT emotion, color, face_expression
            FROM emotions
            WHERE user_id = ?
            ORDER BY created_at DESC
            LIMIT 1
        ");
        $stmt->execute([$userId]);

        return $stmt->fetch(PDO::FETCH_ASSOC) ?: null;
    }

    private function getCharacterStates(int $userId): array
    {
        $stmt = $this->db->prepare("
            SELECT state, value
            FROM character_states
            WHERE user_id = ?
        ");
        $stmt->execute([$userId]);

        $states = [];

        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $states[$row['state']] = (int) $row['value'];
        }

        return $states;
    }

    /* =========================
       ESTADO INICIAL
       ========================= */

    public function createInitialState(int $userId): void
    {
        // Emoção inicial
        $stmt = $this->db->prepare("
            INSERT INTO emotions (user_id, emotion, color, face_expression)
            VALUES (?, 'FELIZ', '#FFA500', 'body_laranja_feliz.png')
        ");
        $stmt->execute([$userId]);

        // Estados iniciais
        $stmt = $this->db->prepare("
            INSERT INTO character_states (user_id, state, value) VALUES
            (?, 'HUNGER', 80),
            (?, 'ENERGY', 90),
            (?, 'SLEEP', 70),
            (?, 'TEMPERATURE', 50)
        ");
        $stmt->execute([$userId, $userId, $userId, $userId]);
    }

    /* =========================
       ACTIONS (GAMEPLAY)
       ========================= */

    public function performAction(int $userId, string $action, ?int $foodId = null): array
    {
        switch ($action) {
            case 'FEED':
                if (!$foodId) {
                    throw new Exception('Food ID é obrigatório');
                }

                $food = $this->foodService->getById($foodId);

                $this->changeState($userId, 'HUNGER', (int) $food['hunger']);
                $this->changeState($userId, 'ENERGY', (int) $food['energy']);
                break;

            case 'PLAY':
                $this->changeState($userId, 'ENERGY', -10);
                $this->changeState($userId, 'FUN', +20);
                break;

            case 'REST':
                $this->changeState($userId, 'ENERGY', +20);
                break;

            case 'SLEEP':
                $this->startSleep($userId);
                break;

            case 'WAKE':
                $this->stopSleep($userId);
                break;

            default:
                throw new Exception('Ação inválida');
        }

        // 🔄 Reavalia emoção APÓS alterar estados
        $states = $this->getCharacterStates($userId);
        [$emotion, $color, $image] = $this->evaluateEmotion($states);

        // 🔐 Registra emoção apenas se mudou (opcional, mas recomendado)
        $current = $this->getCurrentEmotion($userId);

        if (!$current || $current['emotion'] !== $emotion) {
            $this->addEmotion($userId, $emotion, $color, $image);
        }

        return $this->getFullState($userId);
    }


    public function playGame(
        int $userId,
        string $game,
        int $score,
        int $duration
    ): array {

        switch ($game) {
            case 'FLAPPY':
                $this->handleFlappyGame($userId, $score, $duration);
                break;

            default:
                throw new Exception('Jogo inválido');
        }

        // 🔄 Reavalia emoção + retorna estado completo
        return $this->getFullState($userId);
    }



    private function evaluateEmotion(array $states): array
    {
        $energy = $states['ENERGY'] ?? 100;
        $hunger = $states['HUNGER'] ?? 100;
        $sleep  = $states['SLEEP'] ?? 100;
        $stress = $states['STRESS'] ?? 100;

        if ($energy < 30) {
            return ['ASSUSTADO', '#800080', 'body_roxo_assustado.png'];
        }

        if ($hunger < 45) {
            return ['BRAVO', '#00FF00', 'body_verde_bravo.png'];
        }

        if ($stress > 80) {
            return ['NERVOSO', '#FF0000', 'body_vermelho_nervoso.png'];
        }

        if ($sleep < 25) {
            return ['CANSADO', '#808080', 'body_cinza_cansado.png'];
        }

        if ($energy < 40) {
            return ['TRISTE', '#0000FF', 'body_azul_triste.png'];
        }

        if ($energy <= 70) {
            return ['NEUTRO', '#FFD700', 'body_amarelo_neutro.png'];
        }

        return ['FELIZ', '#FFA500', 'body_laranja_feliz.png'];
    }



    /* =========================
       HELPERS
       ========================= */

    private function changeState(int $userId, string $state, int $delta): void
    {
        $stmt = $this->db->prepare("
            UPDATE character_states
            SET value = LEAST(100, GREATEST(0, value + ?))
            WHERE user_id = ? AND state = ?
        ");
        $stmt->execute([$delta, $userId, $state]);
    }

    private function addEmotion(
        int $userId,
        string $emotion,
        string $color,
        string $image
    ): void {
        $stmt = $this->db->prepare("
            INSERT INTO emotions (user_id, emotion, color, face_expression)
            VALUES (?, ?, ?, ?)
        ");
        $stmt->execute([$userId, $emotion, $color, $image]);
    }

    private function getLastUpdate(int $userId): DateTime
    {
        $stmt = $this->db->prepare("
        SELECT MAX(updated_at) as last_update
        FROM character_states
        WHERE user_id = ?
    ");
        $stmt->execute([$userId]);

        $row = $stmt->fetch(PDO::FETCH_ASSOC);

        return new DateTime($row['last_update'] ?? 'now');
    }

    //ADICIONA O "DORMIR"
    public function startSleep(int $userId): void
    {
        // Se já existir registro, atualiza
        $stmt = $this->db->prepare("
        INSERT INTO slivi_status (user_id, is_sleeping, started_at)
        VALUES (?, 1, NOW())
        ON DUPLICATE KEY UPDATE
            is_sleeping = 1,
            started_at = NOW(),
            ended_at = NULL
    ");
        $stmt->execute([$userId]);
    }

    //PARA O "DORMIR"
    public function stopSleep(int $userId): void
    {
        $stmt = $this->db->prepare("
        UPDATE slivi_status
        SET is_sleeping = 0,
            ended_at = NOW()
        WHERE user_id = ?
    ");
        $stmt->execute([$userId]);
    }

    //SE TIVER DORMINDO
    public function isSleeping(int $userId): bool
    {
        $stmt = $this->db->prepare("
        SELECT is_sleeping
        FROM slivi_status
        WHERE user_id = ?
        LIMIT 1
    ");
        $stmt->execute([$userId]);
        $row = $stmt->fetch(PDO::FETCH_ASSOC);

        return $row && (int)$row['is_sleeping'] === 1;
    }



    private function handleFlappyGame(
        int $userId,
        int $score,
        int $duration
    ): void {


        // Evento inválido (possível abuso)
        if ($duration < 5) {
            return; // não altera estado algum
        }

        // Custo de jogar
        $this->changeState($userId, 'ENERGY', -15);
        $this->changeState($userId, 'FUN', +25);

        // Regras por performance
        if ($score >= 1000) {
            $this->changeState($userId, 'STRESS', -10);
        }

        if ($score < 300) {
            $this->changeState($userId, 'STRESS', +10);
        }
    }
}
