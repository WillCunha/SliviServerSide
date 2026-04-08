<?php

declare(strict_types=1);

require_once __DIR__ . '/../utils/Response.php';
require_once __DIR__ . '/../auth/AuthService.php';
require_once __DIR__ . '/../services/WalletService.php';

class WalletController
{
    private WalletService $walletService;

    public function __construct(PDO $db)
    {
        $this->walletService = new WalletService($db);
    }

    public function addMoney($amount)
    {
        try {
            $userId = AuthService::getUserIdFromHeader();
            $addMoney = $this->walletService->addCoins($userId, $amount);

            Response::success(['s_coins' => $addMoney]);
        } catch (Exception $e) {
            Response::error($e->getMessage(), 400);
        }
    }

    /**
     * GET /slivi/wallet/balance
     */
    public function balance(): void
    {
        try {
            $userId = AuthService::getUserIdFromHeader();
            $balance = $this->walletService->getBalance($userId);

            Response::success(['s_coins' => $balance]);
        } catch (Exception $e) {
            Response::error($e->getMessage(), 400);
        }
    }
}
