<?php
declare(strict_types=1);

class FoodController
{
    private FoodService $foodService;

    public function __construct(PDO $db)
    {
        $this->foodService = new FoodService($db);
    }

    /**
     * GET /foods
     */
    public function index(): void
    {
        try {
            $foods = $this->foodService->getAll();

            Response::success($foods);
        } catch (Exception $e) {
            Response::error($e->getMessage(), 500);
        }
    }
}
