<?php

declare(strict_types=1);

require_once __DIR__ . '/ExperienceService.php';

class SealService
{
    private PDO $db;
    private ExperienceService $xpService;

    // Mapeia quais tipos de selos são cumulativos (somam valor a cada ação)
    // Os que não estiverem aqui, assumiremos que são de "Maior valor atingido" (ex: max_score)
    private array $cumulativeTypes = [
        'total_jumps', 'air_time', 'dodges', 'total_dodges', 'matches_played', 
        'feed_count', 'clean_count', 'happy_time', 'pet_count', 'total_actions'
    ];

    public function __construct(PDO $db)
    {
        $this->db = $db;
        $this->xpService = new ExperienceService($db);
    }

    /**
     * Retorna todos os selos do usuário (para mostrar na tela de Perfil/Conquistas)
     */
    public function getUserSeals(int $userId, string $game = null): array
    {
        $query = "
            SELECT t.id, t.name, t.description, t.tier, t.image_url, t.game, 
                   us.status, us.unlocked_at, us.current_value, t.target_value
            FROM slivi_seals_template t
            LEFT JOIN slivi_user_seals us ON t.id = us.seal_id AND us.user_id = :user_id
            WHERE t.active = 1
        ";

        $params = ['user_id' => $userId];

        if ($game) {
            $query .= " AND t.game = :game";
            $params['game'] = $game;
        }

        $query .= " ORDER BY FIELD(t.tier, 'inicial', 'intermediario', 'avancado', 'epico', 'secreto')";

        $stmt = $this->db->prepare($query);
        $stmt->execute($params);
        
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    /**
     * Verifica e atualiza o progresso dos selos baseado nos stats enviados
     */
    public function checkSealsProgress(int $userId, string $game, array $stats): array
    {
        // 1. Busca todos os selos ativos deste jogo que o usuário AINDA NÃO completou
        $stmt = $this->db->prepare("
            SELECT t.*, us.id AS user_seal_id, us.current_value, us.status 
            FROM slivi_seals_template t
            LEFT JOIN slivi_user_seals us ON t.id = us.seal_id AND us.user_id = :user_id
            WHERE t.game = :game 
              AND (us.status IS NULL OR us.status = 'active') 
              AND t.active = 1
        ");
        $stmt->execute(['user_id' => $userId, 'game' => $game]);
        $pendingSeals = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $newlyUnlocked = [];

        foreach ($pendingSeals as $seal) {
            $type = $seal['type'];

            // Se o stat necessário para esse selo não foi enviado nesta jogada/ação, ignora
            if (!isset($stats[$type])) {
                continue;
            }

            // Verifica condições extras (ex: não usar ímã)
            if (!$this->checkConditions($seal['conditions'], $stats)) {
                continue;
            }

            $currentValue = (int)($seal['current_value'] ?? 0);
            $matchValue = (int)$stats[$type];
            $newValue = $currentValue;

            // Define se vamos SOMAR ou pegar o MAIOR valor
            if (in_array($type, $this->cumulativeTypes)) {
                $newValue = $currentValue + $matchValue;
            } else {
                $newValue = max($currentValue, $matchValue);
            }

            $status = ($newValue >= $seal['target_value']) ? 'completed' : 'active';

            // Salva no banco (Insert ou Update)
            if (empty($seal['user_seal_id'])) {
                // Primeira vez que está progredindo neste selo
                $insert = $this->db->prepare("
                    INSERT INTO slivi_user_seals (user_id, seal_id, current_value, status, unlocked_at)
                    VALUES (:uid, :sid, :val, :status, :unlocked)
                ");
                $insert->execute([
                    'uid' => $userId,
                    'sid' => $seal['id'],
                    'val' => $newValue,
                    'status' => $status,
                    'unlocked' => ($status === 'completed') ? date('Y-m-d H:i:s') : null
                ]);
            } else {
                // Atualiza progresso existente
                $update = $this->db->prepare("
                    UPDATE slivi_user_seals 
                    SET current_value = :val, status = :status, 
                        unlocked_at = :unlocked
                    WHERE id = :id
                ");
                $update->execute([
                    'val' => $newValue,
                    'status' => $status,
                    'unlocked' => ($status === 'completed') ? date('Y-m-d H:i:s') : null,
                    'id' => $seal['user_seal_id']
                ]);
            }

            // 🏆 PREMIAÇÃO! Se acabou de desbloquear o selo
            if ($status === 'completed' && $seal['status'] !== 'completed') {
                
                // Dá o XP gigante da conquista
                if ($seal['reward_xp'] > 0) {
                    $this->xpService->addXP($userId, (int)$seal['reward_xp']);
                }

                // Adiciona na lista de desbloqueios para avisar o Front-end
                $newlyUnlocked[] = [
                    'id' => $seal['id'],
                    'name' => $seal['name'],
                    'tier' => $seal['tier'],
                    'image_url' => $seal['image_url'],
                    'reward_xp' => $seal['reward_xp']
                ];
            }
        }

        return $newlyUnlocked;
    }

    /**
     * Valida as condições extras do JSON (idêntico ao ObjectivesService)
     */
    private function checkConditions(?string $conditionsJson, array $stats): bool
    {
        if (!$conditionsJson) return true;

        $conditions = json_decode($conditionsJson, true);
        foreach ($conditions as $key => $expected) {
            if (!array_key_exists($key, $stats)) return false;
            
            if (is_bool($expected) && $stats[$key] !== $expected) return false;
            if (is_numeric($expected) && $stats[$key] < $expected) return false;
        }

        return true;
    }
}