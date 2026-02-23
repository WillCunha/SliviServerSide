<?php
declare(strict_types=1);

class EmotionService
{
    public function calculate(array $s): string
    {
        // Estados críticos (prioridade máxima)
        if ($s['energy'] < 20 || $s['sleep'] < 20) {
            return 'CANSADO';
        }

        if ($s['hunger'] < 20) {
            return 'TRISTE';
        }

        if ($s['temperature'] < 20 || $s['temperature'] > 80) {
            return 'DESCONFORTAVEL';
        }

        if ($s['fun'] < 20) {
            return 'RAIVOSO';
        }

        if ($s['social'] < 20) {
            return 'TRISTE';
        }

        // Estado positivo
        if (
            $s['hunger'] > 70 &&
            $s['fun'] > 70 &&
            $s['energy'] > 60
        ) {
            return 'FELIZ';
        }

        // Estado padrão
        return 'NEUTRO';
    }
}
