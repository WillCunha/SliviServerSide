<?php

declare(strict_types=1);

class WalletService
{
    private PDO $db;

    public function __construct(PDO $db)
    {
        $this->db = $db;
    }

    public function getBalance(int $userId): int
    {
        $stmt = $this->db->prepare("SELECT s_coins FROM users WHERE id = ? LIMIT 1");
        $stmt->execute([$userId]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);

        return $result ? (int) $result['s_coins'] : 0;
    }

    public function addCoins(int $userId, int $amount): int
    {
        if ($amount <= 0) return 0;

        $stmt = $this->db->prepare("UPDATE users SET s_coins = s_coins + ? WHERE id = ?");
        $stmt->execute([$amount, $userId]);

        $balance = $this->getBalance($userId);

        return $balance;
    }

    public function spendCoins(int $userId, int $amount): bool
    {
        if ($amount <= 0) return true;

        $currentBalance = $this->getBalance($userId);

        if ($currentBalance < $amount) {
            throw new Exception("Saldo insuficiente de S-Coins.");
        }

        // Atualiza garantindo que não vai ficar negativo por concorrência
        $stmt = $this->db->prepare("
            UPDATE users 
            SET s_coins = s_coins - ? 
            WHERE id = ? AND s_coins >= ?
        ");
        $stmt->execute([$amount, $userId, $amount]);

        if ($stmt->rowCount() === 0) {
            throw new Exception("Erro ao processar o pagamento. Verifique seu saldo - total: " . $amount);
        }

        return true;
    }
}