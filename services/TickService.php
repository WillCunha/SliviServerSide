<?php
declare(strict_types=1);

class TickService
{
    private const MAX = 100;
    private const MIN = 0;

    // Taxas por minuto
    private array $rates = [
        'HUNGER' => -0.25,
        'ENERGY' => -0.20,
        'SLEEP'  => -0.15,
        'STRESS' =>  0.10,
    ];

    public function apply(
        array $states,
        DateTime $lastUpdate,
        DateTime $now
    ): array {
        $elapsed = $now->getTimestamp() - $lastUpdate->getTimestamp();

        if ($elapsed <= 0) {
            return $states;
        }

        $minutesPassed = (int) floor($elapsed / 60);

        if ($minutesPassed === 0) {
            return $states;
        }

        foreach ($this->rates as $state => $rate) {
            if (!array_key_exists($state, $states)) {
                continue;
            }

            $states[$state] += $rate * $minutesPassed;
            $states[$state] = $this->clamp($states[$state]);
        }

        return $states;
    }

    private function clamp(float $value): float
    {
        return max(self::MIN, min(self::MAX, $value));
    }
}
