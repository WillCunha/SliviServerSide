<?php

declare(strict_types=1);

class ExperienceService
{
    private $db;

    // Configuração de progressão: Nível * 500 (Ex: Level 1 precisa de 500, Level 2 de 1000...)
    private $xpMultiplier = 500;

    public function __construct($db)
    {
        $this->db = $db;
    }

    /**
     * Adiciona XP ao usuário e gerencia o Level Up
     */
    public function addXP(int $userId, int $amount): array
    {
        // 1. Busca dados atuais do usuário
        $stmt = $this->db->prepare("SELECT experience, level FROM users WHERE id = :id");
        $stmt->execute(['id' => $userId]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$user) {
            throw new Exception('Usuário não encontrado no sistema de Experiência!');
        }
        $currentXP = (int)$user['experience'];
        $currentLevel = (int)$user['level'];
        $newXP = $currentXP + $amount;

        $leveledUp = false;

        // 2. Lógica de Level Up
        // Enquanto o XP atual for maior ou igual ao necessário para o próximo nível
        while ($newXP >= $this->getXPForNextLevel($currentLevel)) {
            $newXP -= $this->getXPForNextLevel($currentLevel);
            $currentLevel++;
            $leveledUp = true;
        }

        // 3. Atualiza o banco
        $update = $this->db->prepare("UPDATE users SET experience = :xp, level = :lvl WHERE id = :id");
        $update->execute([
            'xp' => $newXP,
            'lvl' => $currentLevel,
            'id' => $userId
        ]);

        return [
            'success' => true,
            'xp_added' => $amount,
            'current_xp' => $newXP,
            'current_level' => $currentLevel,
            'next_level_xp' => $this->getXPForNextLevel($currentLevel),
            'leveled_up' => $leveledUp
        ];
    }

    /**
     * Define quanto de XP é necessário para passar do nível atual para o próximo
     */
    public function getXPForNextLevel(int $currentLevel): int
    {
        return $currentLevel * $this->xpMultiplier;
    }
}
