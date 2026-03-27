<?php
declare(strict_types=1);

require_once __DIR__ . '/../services/MealService.php';

class MealController
{
    private MealService $mealService;

    public function __construct(PDO $db)
    {
        $this->mealService = new MealService($db);
    }

    /**
     * POST /slivi/action (com action: FEED)
     * Ou você pode criar uma rota própria POST /meal/process
     */
    public function feed(int $userId, array $foodIds): void
    {
        try {
            $result = $this->mealService->processMeal($userId, $foodIds);
            Response::success($result);
        } catch (Exception $e) {
            Response::error($e->getMessage(), 400);
        }
    }
}