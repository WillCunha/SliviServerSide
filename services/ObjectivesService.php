<?php

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

class ObjectivesService
{
    private $db;

    public function __construct($db)
    {
        $this->db = $db;
    }

    // Retorna os objetivos que o usuário está tentando completar agora
    public function getActiveObjectives(string $game)
    {
        $userId = AuthService::getUserIdFromHeader();
        $stmt = $this->db->prepare("
        SELECT 
            u.id,
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
            t.conditions
        FROM slivi_user_objectives u
        JOIN slivi_objectives_template t ON u.objective_id = t.id
        WHERE u.user_id = :user_id
          AND t.game = :game
          AND t.active = 1 ORDER BY id LIMIT 1");
        $stmt->execute(['user_id' => $userId, 'game' => $game]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Processa os dados da partida e atualiza o progresso
    public function checkProgress(string $game, int $score, array $stats)
    {
        $active = $this->getActiveObjectives($game);

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

            $statKey = $obj['type'];
            $matchValue = $score ?? 0;
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
