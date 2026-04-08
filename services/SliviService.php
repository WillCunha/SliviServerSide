<?php

declare(strict_types=1);


require_once __DIR__ . '/AffectionService.php';
require_once __DIR__ . '/ClothingService.php';
require_once __DIR__ . '/ExperienceService.php';
require_once __DIR__ . '/GameService.php';
require_once __DIR__ . '/TemperatureService.php';
require_once __DIR__ . '/TickService.php';
require_once __DIR__ . '/WalletService.php';


class SliviService
{
    private AffectionService $affectionService;
    private ClothingService $clothingService;
    private ExperienceService $experienceService;
    private GameService $gameService;
    private TemperatureService $temperatureService;
    private WalletService $walletService;
    private PDO $db;


    public function __construct(PDO $db)
    {
        $this->db = $db;
        $this->affectionService = new AffectionService($db);
        $this->clothingService = new ClothingService($db);
        $this->experienceService = new ExperienceService($db);
        $this->gameService = new GameService();
        $this->temperatureService = new TemperatureService($db, $this->clothingService);
        $this->walletService = new WalletService($db);
    }

    /* =========================
       ESTADO DO SLIVI
       ========================= */

    public function getFullState(int $userId): array
    {
        // Antes de tudo, informa o sistema de login diário para beneficiar o jogador. 
        $this->affectionService->processDailyLogin($userId);

        // Busca estados atuais
        $states = $this->getCharacterStates($userId);

        // Busca o XP atual e o nível que o usuario está
        $experienceLevel = $this->experienceService->getXPLevel($userId);

        // Busca o relacionamento com o usuario
        $relationLevel = $this->affectionService->getRelationship($userId);

        // Busca a carteira
        $walletData = $this->walletService->getBalance($userId);

        // Verifica se está dormindo
        $isSleeping = $this->isSleeping($userId);

        // Verifica a roupa que está sendo utilizada
        $equippedClothing = $this->clothingService->getEquipped($userId);
       
        // Verifica a temperatura do Slivi
        $targetTemperature = $this->temperatureService->getTargetTemperature($userId);

        // Aplica Tick
        $lastUpdate = $this->getLastUpdate($userId);
        $now = new DateTime();
        $tickService = new TickService();
        $updatedStates = $tickService->apply($states, $lastUpdate, $now, $isSleeping, $targetTemperature);

        if (($updatedStates['HUNGER'] ?? 0) === 0 && ($states['HUNGER'] ?? 0) > 0) {
            $this->affectionService->modifyAffection($userId, -10);
        }

        $affectionDecay = $tickService->calculateAffectionDecay($lastUpdate, $now);

        if ($affectionDecay < 0) {
            $this->affectionService->modifyAffection($userId, $affectionDecay);
        }

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
            'wallet' => $walletData,
            'states'  => $updatedStates,
            'relationship' => $relationLevel,
            'xpLevel' => $experienceLevel,
            'clothing'   => $equippedClothing,
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

        // Estados iniciais
        $stmt = $this->db->prepare("
            INSERT INTO character_states (user_id, state, value) VALUES
            (?, 'HUNGER', 100),
            (?, 'ENERGY', 100),
            (?, 'TEMPERATURE', 50),
            (?, 'FUN', 50),
            (?, 'BRAVO', 0)
        ");
        $stmt->execute([$userId, $userId, $userId, $userId, $userId, $userId]);
    }

    /* =========================
       ACTIONS (GAMEPLAY)
       ========================= */

    public function performAction(int $userId, string $action, ?array $foodId = null): array
    {
        switch ($action) {
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

        $experience = random_int(10, 100);
        $this->experienceService->addXP($userId, $experience);

        return $this->getFullState($userId);
    }


    public function playGame(
        int $userId,
        string $game,
        int $score,
        int $duration
    ): array {

        switch ($game) {
            case 'PULSE':
                $this->handleMiniGame($userId, $game, $score, $duration);
                break;
            case 'MAESTRO':
                $this->handleMiniGame($userId, $game, $score, $duration);
                break;

            default:
                throw new Exception('Jogo inválido');
        }

        // 🔄 Reavalia emoção + retorna estado completo
        return $this->getFullState($userId);
    }



    private function evaluateEmotion(array $states, array $recentEvents = []): array
    {
        $energy = $states['ENERGY'] ?? 100;
        $hunger = $states['HUNGER'] ?? 100;
        $bravo  = $states['BRAVO'] ?? 0;

        $scores = [
            'NEUTRO'    => 5,
            'FELIZ'     => 0,
            'TRISTE'    => 0,
            'BRAVO'     => 0,
            'NERVOSO'   => 0,
            'ASSUSTADO' => 0,
            'CANSADO'   => 0
        ];


        if ($hunger < 20) {
            $scores['BRAVO'] += 15;
        } elseif ($hunger < 45) {
            $scores['BRAVO'] += 8;
        } else {
            $scores['FELIZ'] += 5;
        }

        if ($energy < 20) {
            $scores['CANSADO'] += 20;
        } elseif ($energy < 40) {
            $scores['TRISTE'] += 10;
        } elseif ($energy > 80) {
            $scores['FELIZ'] += 5;
        }

        if ($bravo > 80) {
            $scores['NERVOSO'] += 12;
        }

        foreach ($recentEvents as $event => $weight) {
            if ($event === 'COMIDA_DELICIOSA') {
                $scores['FELIZ'] += $weight;
            }
            if ($event === 'SUSTO') {
                $scores['ASSUSTADO'] += $weight;
            }
        }

        arsort($scores);
        $winningEmotion = array_key_first($scores);
        return $this->getEmotionData($winningEmotion);
    }

    private function getEmotionData(string $emotion): array
    {
        $map = [
            'FELIZ'     => ['FELIZ', '#FFA500', 'body_laranja_feliz.png'],
            'NEUTRO'    => ['NEUTRO', '#FFD700', 'body_amarelo_neutro.png'],
            'TRISTE'    => ['TRISTE', '#0000FF', 'body_azul_triste.png'],
            'BRAVO'     => ['BRAVO', '#00FF00', 'body_verde_bravo.png'],
            'NERVOSO'   => ['NERVOSO', '#FF0000', 'body_vermelho_nervoso.png'],
            'ASSUSTADO' => ['ASSUSTADO', '#800080', 'body_roxo_assustado.png'],
            'CANSADO'   => ['CANSADO', '#808080', 'body_cinza_cansado.png']
        ];

        return $map[$emotion] ?? $map['NEUTRO'];
    }


    /* =========================
       HELPERS
       ========================= */

    public function changeState(int $userId, string $state, int $delta): void
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

        $states = $this->getCharacterStates($userId);
        $energy = $states['ENERGY'] ?? 0;

        if ($energy > 0 && $energy <= 30) {
            // Colocou pra dormir antes de zerar (estava cansado, mas não desmaiou)
            $this->affectionService->modifyAffection($userId, 12);
        } elseif ($energy === 0) {
            // Ignorou necessidade crítica (deixou o Slivi desmaiar de sono)
            $this->affectionService->modifyAffection($userId, -15);
        }

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

        // Pega o estado no momento de acordar
        $states = $this->getCharacterStates($userId);
        $energy = $states['ENERGY'] ?? 0;

        // Timing ideal: Acordou o Slivi quando ele já descansou bem (ex: >= 90)
        if ($energy >= 90) {
            $this->affectionService->modifyAffection($userId, 8);
        }

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



    private function handleMiniGame(
        int $userId,
        string $game,
        int $score,
        int $duration
    ): void {

        // Anti-abuso
        if ($duration < 5) {
            return;
        }

        // Busca score anterior
        $previousScore = $this->gameService->getLastScore(
            $userId,
            $game
        );

        // Salva score atual
        $this->gameService->save(
            $userId,
            $game,
            $score,
            $duration
        );

        // Custo base do jogo
        $this->changeState($userId, 'ENERGY', -15);
        $this->changeState($userId, 'FUN', +25);

        $affectionGained = 10;

        // Primeira partida → sem comparação
        if ($previousScore === null) {
            return;
        }

        // 📉 Jogou pior
        if ($score < $previousScore) {
            $this->changeState($userId, 'BRAVO', +10);
            $this->changeState($userId, 'FUN', -10);
            $affectionGained = 5;
        }

        // 📈 Jogou melhor
        if ($score > $previousScore) {
            $this->changeState($userId, 'BRAVO', -10);
            $this->changeState($userId, 'FUN', +10);
            $affectionGained += 15;
        }

        $this->affectionService->modifyAffection($userId, $affectionGained);
    }
}
