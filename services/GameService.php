<?php

declare(strict_types=1);

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../utils/Response.php';

class GameService
{

    public function getLastScore(int $userId, string $game): ?int
    {
        $db = Database::getConnection();
        $stmt = $db->prepare(
            "SELECT score
             FROM slivi_game_scores
             WHERE user_id = :user_id AND game = :game
             ORDER BY created_at DESC
             LIMIT 1"
        );

        $stmt->execute([
            'user_id' => $userId,
            'game' => $game
        ]);

        $score = $stmt->fetchColumn();

        return $score !== false ? (int)$score : null;
    }

    public function save(
        int $userId,
        string $game,
        int $score,
        int $duration
    ): void {
        $db = Database::getConnection();
        $stmt = $db->prepare(
            "INSERT INTO slivi_game_scores (user_id, game, score, duration)
             VALUES (:user_id, :game, :score, :duration)"
        );

        $stmt->execute([
            'user_id' => $userId,
            'game' => $game,
            'score' => $score,
            'duration' => $duration
        ]);
    }
}
