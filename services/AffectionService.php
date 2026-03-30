<?php

declare(strict_types=1);

class AffectionService
{
    private PDO $db;

    // Definição dos níveis de relação
    private const LEVELS = [
        1 => ['name' => 'Desconhecido', 'min' => 0],
        2 => ['name' => 'Conhecido', 'min' => 300],
        3 => ['name' => 'Companheiro', 'min' => 700],
        4 => ['name' => 'Amigo', 'min' => 1200],
        5 => ['name' => 'Melhores Amigos ⭐', 'min' => 2000]
    ];

    public function __construct(PDO $db)
    {
        $this->db = $db;
    }

    public function getRelationship(int $userId): array
    {
        $stmt = $this->db->prepare("SELECT affection_points, relation_level FROM users WHERE id = ? LIMIT 1");
        $stmt->execute([$userId]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);

        $currentPoints = (int)($result['affection_points'] ?? 0);
        $currentLevel = (int)($result['relation_level'] ?? 1);

        $data = [
            'affection_points' => $currentPoints,
            'relation_level' => $currentLevel,
            'level_name' => self::LEVELS[$currentLevel]['name'],
        ];
        return $data;
    }

    /**
     * Adiciona ou remove pontos de afeto e atualiza o nível.
     */
    public function modifyAffection(int $userId, int $amount): array
    {
        $stmt = $this->db->prepare("SELECT affection_points, relation_level FROM users WHERE id = :id");
        $stmt->execute(['id' => $userId]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$user) {
            throw new Exception('Usuário não encontrado!');
        }

        $currentPoints = (int)($user['affection_points'] ?? 0);
        $currentLevel = (int)($user['relation_level'] ?? 1);

        // REGRA: Se o vínculo < 100 e for um ganho de pontos, reduz 30%
        if ($currentPoints < 100 && $amount > 0) {
            $amount = (int) ceil($amount * 0.7);
        }

        // Garante que a pontuação não fique negativa
        $newPoints = max(0, $currentPoints + $amount);
        $newLevel = $this->calculateLevel($newPoints);

        $update = $this->db->prepare("UPDATE users SET affection_points = :pts, relation_level = :lvl WHERE id = :id");
        $update->execute([
            'pts' => $newPoints,
            'lvl' => $newLevel,
            'id' => $userId
        ]);

        return [
            'affection_points' => $newPoints,
            'relation_level' => $newLevel,
            'level_name' => self::LEVELS[$newLevel]['name'],
            'points_added' => $amount,
            'leveled_up' => $newLevel > $currentLevel
        ];
    }

    public function processDailyLogin(int $userId): array
    {
        $stmt = $this->db->prepare("SELECT last_login_date, login_streak FROM users WHERE id = :id");
        $stmt->execute(['id' => $userId]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        $today = date('Y-m-d');
        $lastLogin = $user['last_login_date'] ?? null;
        $streak = (int)($user['login_streak'] ?? 0);

        // Se já logou hoje, não faz nada
        if ($lastLogin === $today) {
            return ['status' => 'already_logged'];
        }

        $yesterday = date('Y-m-d', strtotime('-1 day'));

        if ($lastLogin === $yesterday) {
            $streak++;
        } else {
            $streak = 1;
        }

        $streakBonus = min(25, ($streak - 1) * 5);
        $totalPoints = 10 + $streakBonus;

        $this->modifyAffection($userId, $totalPoints);

        $update = $this->db->prepare("UPDATE users SET last_login_date = :today, login_streak = :streak WHERE id = :id");
        $update->execute([
            'today' => $today,
            'streak' => $streak,
            'id' => $userId
        ]);

        return [
            'status' => 'success',
            'points_earned' => $totalPoints,
            'current_streak' => $streak
        ];
    }

    private function calculateLevel(int $points): int
    {
        $assignedLevel = 1;
        foreach (self::LEVELS as $level => $data) {
            if ($points >= $data['min']) {
                $assignedLevel = $level;
            } else {
                break;
            }
        }
        return $assignedLevel;
    }
}
