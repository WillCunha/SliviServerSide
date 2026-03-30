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
        'STRESS' =>  0.10,
    ];

    // Taxas quando está dormindo
    private array $sleepRates = [
        'ENERGY' => +0.30,
        'FUN'    => -0.05,
        'HUNGER' => -0.15,
    ];


    public function apply(
        array $states,
        DateTime $lastUpdate,
        DateTime $now,
        bool $isSleeping = false
    ): array {
        $elapsed = $now->getTimestamp() - $lastUpdate->getTimestamp();

        if ($elapsed <= 0) {
            return $states;
        }

        $minutesPassed = (int) floor($elapsed / 60);

        if ($minutesPassed === 0) {
            return $states;
        }

        $rates = $isSleeping ? $this->sleepRates : $this->rates;

        foreach ($rates as $state => $rate) {
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


    public function calculateAffectionDecay(DateTime $lastUpdate, DateTime $now): int
    {
        $elapsedHours = ($now->getTimestamp() - $lastUpdate->getTimestamp()) / 3600;

        if ($elapsedHours < 6) {
            return 0;
        }

        // Calcula blocos de 6 horas
        $blocksOf6Hours = floor($elapsedHours / 6);
        $decayAmount = $blocksOf6Hours * 5; 

        // Regra do abandono: Após 24h sem entrar, penalidade extra de -30
        if ($elapsedHours >= 24) {
            $decayAmount += 30;
        }

        // Retorna o valor como negativo para ser subtraído
        return -(int)$decayAmount; 
    }
}
