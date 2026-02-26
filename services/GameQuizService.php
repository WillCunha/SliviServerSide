<?php

declare(strict_types=1);

class GameQuizService
{
    private PDO $db;

    public function __construct(PDO $db)
    {
        $this->db = $db;
    }

    /**
     * Busca um deck aleatório de perguntas ativas.
     * O limite padrão é 30 (15 cartas para cada jogador, considerando um jogo rápido).
     */
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
        
        // PDO precisa que o LIMIT seja int, PDO::PARAM_INT é necessário se não estiver emulado
        $stmt->bindValue(1, $limit, PDO::PARAM_INT);
        $stmt->execute();

        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $deck = [];

        foreach ($rows as $row) {
            // Formata no padrão que o React Native precisa
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