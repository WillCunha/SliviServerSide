<?php

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once __DIR__ . '/ExperienceService.php'; // Adicionamos a chamada para o novo serviço

class ObjectivesService
{
    private $db;
    private ExperienceService $xpService;

    public function __construct($db)
    {
        $this->db = $db;
        $this->xpService = new ExperienceService($db); // Instanciamos o serviço de XP
    }

    // Retorna os objetivos que o usuário está tentando completar agora
    public function getActiveObjectives(string $game)
    {
        $userId = AuthService::getUserIdFromHeader();

        // 🔄 Correção: Removido o "LIMIT 1" e adicionado filtro "u.status = 'active'"
        // 💰 Adicionado "t.reward_coins" para podermos pagar o usuário
        $stmt = $this->db->prepare("
        SELECT 
            u.id,
            u.user_id,
            u.current_value,
            u.status,
            u.last_reset_at,
            t.id AS template_id,
            t.game,
            t.description,
            t.type,
            t.category,
            t.logic_strategy,
            t.reset_period,
            t.target_value,
            t.conditions,
            t.reward_coins,
            t.reward_clothing_id
        FROM slivi_user_objectives u
        JOIN slivi_objectives_template t ON u.objective_id = t.id
        WHERE u.user_id = :user_id
          AND t.game = :game
          AND u.status = 'active'
          AND t.active = 1
        ");

        $stmt->execute(['user_id' => $userId, 'game' => $game]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Processa os dados da partida e atualiza o progresso
    public function checkProgress(string $game, int $score, array $stats)
    {
        $active = $this->getActiveObjectives($game);
        $unlockedClothes = [];

        foreach ($active as $obj) {

            if (!$this->checkConditions($obj['conditions'], $stats)) {
                continue;
            }

            // 🔄 RESET AUTOMÁTICO
            if ($this->shouldReset($obj)) {
                $this->db->prepare("
                UPDATE slivi_user_objectives
                SET current_value = 0,
                    status = 'active',
                    last_reset_at = NOW()
                WHERE id = :id
                ")->execute(['id' => $obj['id']]);

                $obj['current_value'] = 0;
                $obj['last_reset_at'] = date('Y-m-d H:i:s');
            }

            // Acessa o valor vindo do jogo (ex: max_combo, score, etc)
            $statKey = $obj['type'];

            // Se o statKey não existir no array $stats, assumimos o $score padrão
            $matchValue = $stats[$statKey] ?? $score ?? 0;

            $newValue = 0;

            // 🎯 REGRAS DE PERIOD
            if ($obj['reset_period'] === 'none') {
                // não persiste
                $newValue = $matchValue;
            } else {
                switch ($obj['logic_strategy']) {
                    case 'cumulative':
                        $newValue = $obj['current_value'] + $matchValue;
                        break;

                    case 'single_match':
                        $newValue = max($obj['current_value'], $matchValue);
                        break;

                    default:
                        $newValue = $matchValue;
                }
            }

            $status = ($newValue >= $obj['target_value']) ? 'completed' : 'active';

            // ❌ period = none e não completou → zera
            if ($obj['reset_period'] === 'none' && $status !== 'completed') {
                $newValue = 0;
            }

            // 🏆 RECOMPENSAS (NOVO)
            // Se o objetivo acabou de ser concluído
            if ($status === 'completed' && $obj['status'] !== 'completed') {

                // 1. Dar as moedas (você precisará ter o campo 'coins' na tabela 'users')
                if (isset($obj['reward_coins']) && $obj['reward_coins'] > 0) {
                    $this->db->prepare("UPDATE users SET coins = coins + :coins WHERE id = :user_id")
                        ->execute(['coins' => $obj['reward_coins'], 'user_id' => $obj['user_id']]);
                }

                // 2. Dar XP (Podemos usar um valor fixo por objetivo, ex: 50 XP, 
                // ou futuramente adicionar a coluna reward_xp na slivi_objectives_template)
                $this->xpService->addXP($obj['user_id'], 50);

                // 3. Roupa para o Guarda-Roupa (slivi_user_wardrobe)
                if (!empty($obj['reward_clothing_id'])) {
                    try {
                        $stmtWardrobe = $this->db->prepare("
                            INSERT IGNORE INTO slivi_user_wardrobe (user_id, cloth_id) 
                            VALUES (:u, :c)
                        ");
                        $stmtWardrobe->execute([
                            'u' => $obj['user_id'],
                            'c' => $obj['reward_clothing_id']
                        ]);

                        // Verificamos se a inserção realmente ocorreu
                        if ($stmtWardrobe->rowCount() > 0) {
                            $unlockedClothes[] = $obj['reward_clothing_id']; // 👈 Adiciona ao array de conquistas
                        }
                    } catch (PDOException $e) {
                        // Isso vai nos ajudar a debugar o problema 1 no log do servidor!
                        error_log("ERRO AO INSERIR ROUPA: " . $e->getMessage());
                    }
                }

                return $unlockedClothes; 
            }


            $lastReset = ($status === 'completed')
                ? $obj['last_reset_at']
                : date('Y-m-d H:i:s');

            $upd = $this->db->prepare("
                UPDATE slivi_user_objectives
                SET current_value = :val,
                    status = :status,
                    last_reset_at = :last_reset
                WHERE id = :id
            ");

            $upd->execute([
                'val' => $newValue,
                'status' => $status,
                'last_reset' => $lastReset,
                'id' => $obj['id']
            ]);
        }
    }

    private function shouldReset(array $obj): bool
    {
        if ($obj['reset_period'] === 'none') {
            return false;
        }

        if (!$obj['last_reset_at']) {
            return true;
        }

        $last = new DateTime($obj['last_reset_at']);
        $now  = new DateTime();

        if ($obj['reset_period'] === 'daily') {
            return $last->format('Y-m-d') !== $now->format('Y-m-d');
        }

        if ($obj['reset_period'] === 'weekly') {
            return $last->format('o-W') !== $now->format('o-W');
        }

        return false;
    }

    private function checkConditions(?string $conditionsJson, array $stats): bool
    {
        if (!$conditionsJson) {
            return true; // sem condição → sempre válido
        }

        $conditions = json_decode($conditionsJson, true);

        foreach ($conditions as $key => $expected) {

            if (!array_key_exists($key, $stats)) {
                return false;
            }

            // Comparação inteligente
            if (is_bool($expected)) {
                if ($stats[$key] !== $expected) {
                    return false;
                }
            }

            if (is_numeric($expected)) {
                if ($stats[$key] < $expected) {
                    return false;
                }
            }

            if (is_array($expected)) {
                // Ex: range
                if (isset($expected['min']) && $stats[$key] < $expected['min']) {
                    return false;
                }
                if (isset($expected['max']) && $stats[$key] > $expected['max']) {
                    return false;
                }
            }
        }

        return true;
    }
}
