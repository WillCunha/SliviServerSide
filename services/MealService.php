<?php

declare(strict_types=1);

require_once __DIR__ . '/FoodService.php';
require_once __DIR__ . '/ExperienceService.php';
require_once __DIR__ . '/SliviService.php';
require_once __DIR__ . '/AffectionService.php';

class MealService
{
    private PDO $db;
    private FoodService $foodService;
    private ExperienceService $experienceService;
    private SliviService $sliviService;
    private AffectionService $affectionService;

    public function __construct(PDO $db)
    {
        $this->db = $db;
        $this->foodService = new FoodService($db);
        $this->experienceService = new ExperienceService($db);
        $this->sliviService = new SliviService($db);
        $this->affectionService = new AffectionService($db);
    }

    /**
     * Avalia os alimentos e retorna o combo alcançado.
     */
    private function evaluateCombo(array $foods): array
    {
        $count = count($foods);
        if ($count < 2) {
            return ['word' => null, 'multiplier' => 1.0];
        }

        $meatCount = 0;
        $vegCount = 0;
        $sweetCount = 0;
        $saltCount = 0;

        foreach ($foods as $food) {
            $type = strtoupper($food['type'] ?? '');
            $tasty = strtoupper($food['tasty'] ?? '');

            if ($type === 'MEAT') $meatCount++;
            if (in_array($type, ['VEGETABLE', 'LEGUME'])) $vegCount++;

            if ($tasty === 'SWEET') $sweetCount++;
            if ($tasty === 'SALT') $saltCount++;
        }

        // 🏆 DIVINO: 3 Salgados (tem que ter carne e mato)
        if ($count === 3 && $saltCount === 3 && $meatCount > 0 && $vegCount > 0) {
            return ['word' => 'DIVINE', 'multiplier' => 2.0];
        }

        // 🤤 DELICIOSO: 2 Salgados (com carne) + 1 Doce OU 3 Salgados Veganos
        if ($count === 3) {
            if (($saltCount === 2 && $sweetCount === 1 && $meatCount >= 1) ||
                ($saltCount === 3 && $meatCount === 0)
            ) {
                return ['word' => 'DELICIOUS', 'multiplier' => 1.5];
            }
        }

        // 😋 GOSTOSO: Todos doces OU todos carnes (min 2)
        if ($sweetCount === $count || $meatCount === $count) {
            return ['word' => 'TASTY', 'multiplier' => 1.2];
        }

        return ['word' => null, 'multiplier' => 1.0];
    }

    /**
     * Processa a refeição, checa enjoo, combos, afeto e salva no histórico.
     */
    public function processMeal(int $userId, array $foodIds): array
    {
        $foods = [];
        $totalHunger = 0;
        $totalBaseXp = 0;

        // 1. Busca os alimentos e calcula a base
        foreach ($foodIds as $id) {
            $food = $this->foodService->getById((int)$id);
            $this->foodService->consumeFood($userId, $id);
            $foods[] = $food;
            $totalHunger += (int)$food['hunger'];
            $totalBaseXp += ((int)$food['hunger'] * 2);
        }

        // 2. Busca histórico recente
        $stmt = $this->db->prepare("
            SELECT food_ids, combo_word 
            FROM slivi_feed_historic 
            WHERE user_id = ? 
            ORDER BY created_at DESC 
            LIMIT 3
        ");
        $stmt->execute([$userId]);
        $recentMeals = $stmt->fetchAll(PDO::FETCH_ASSOC);

        // 3. Checagem de Enjoo (Comida repetida)
        $sickFoodName = null;
        foreach ($foodIds as $currentFoodId) {
            $timesEatenRecently = 0;
            foreach ($recentMeals as $meal) {
                $pastFoodIds = json_decode($meal['food_ids'], true);
                if (is_array($pastFoodIds) && in_array($currentFoodId, $pastFoodIds)) {
                    $timesEatenRecently++;
                }
            }
            if ($timesEatenRecently >= 2) {
                $sickFoodName = array_filter($foods, fn($f) => $f['id'] == $currentFoodId)[0]['name'] ?? 'isso';
                break;
            }
        }

        // 4. Avaliação de Combos e Spam
        $comboResult = $this->evaluateCombo($foods);
        $sortedFoodIds = $foodIds;
        sort($sortedFoodIds);
        $currentCombinationJson = json_encode($sortedFoodIds);

        $comboSpammed = false;
        if ($comboResult['word']) {
            foreach ($recentMeals as $meal) {
                if ($meal['food_ids'] === $currentCombinationJson && $meal['combo_word'] !== null) {
                    $comboSpammed = true;
                    break;
                }
            }
        }

        if ($comboSpammed) {
            $comboResult = ['word' => null, 'multiplier' => 1.0];
        }

        // 5. Cálculo final de XP
        $finalXp = (int)($totalBaseXp * $comboResult['multiplier']);
        if ($sickFoodName) {
            $finalXp = (int)($finalXp / 2);
        }

        // 6. Cálculo de Pontos de Afeto (NOVO)
        $affectionPoints = 15; // Base: Comida correta (+15)
        
        if (in_array($comboResult['word'], ['DIVINE', 'DELICIOUS'])) {
            $affectionPoints = 25; // Comida perfeita (+25)
        }

        // Lógica extra: se ele está enjoado da comida, ganha bem menos afeto (ou até perde, se preferir)
        if ($sickFoodName) {
            $affectionPoints = 5; 
        }

        // 7. Salva histórico e aplica as mudanças
        $insertStmt = $this->db->prepare("
            INSERT INTO slivi_feed_historic (user_id, food_ids, combo_word) 
            VALUES (?, ?, ?)
        ");
        $insertStmt->execute([$userId, $currentCombinationJson, $comboResult['word']]);

        $this->experienceService->addXP($userId, $finalXp);
        $this->sliviService->changeState($userId, 'HUNGER', $totalHunger);
        
        // Aplica o afeto e pega o resultado (para saber se subiu de nível)
        $affectionResult = $this->affectionService->modifyAffection($userId, $affectionPoints);

        // 8. Retorno atualizado
        return [
            'success' => true,
            'total_hunger_restored' => $totalHunger,
            'total_xp_gained' => $finalXp,
            'combo_word' => $comboResult['word'],
            'sick_message' => $sickFoodName ? 200 : 404,
            'affection_gained' => $affectionPoints,
            'new_relation_level' => $affectionResult['level_name']
        ];
    }
}