/*

Use mikroE Timer Calculator to generate proper timer configuration
and timer ISR.

https://www.mikroe.com/timer-calculator

*/
#include "Click_LTE_IoT2_types.h"

#define __LTE_IoT2_TIMER__

static void lteiot2_configTimer()
{


    // Configure Timer
}

void Timer_interrupt()
{
    lteiot2_tick();
    // Reset Flag
}