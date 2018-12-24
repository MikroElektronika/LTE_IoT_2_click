/*

Use mikroE Timer Calculator to generate proper timer configuration
and timer ISR.

https://www.mikroe.com/timer-calculator

*/
#include "Click_LTE_IoT2_types.h"

#define __LTE_IoT2_TIMER__

static void lteiot2_configTimer()
{
    TIMER32_T32CONTROL1 &= 0xFFFFFFFE;
    TIMER32_T32CONTROL1 |= 0x02;
    TIMER32_T32CONTROL1 |= 0;
    TIMER32_T32CONTROL1 |= 0x20;
    TIMER32_T32CONTROL1 |= 0x40;
    TIMER32_T32LOAD1 = 0x0000BB80;
    NVIC_IntEnable(IVT_INT_T32_INT1);
//    IVT_INT_T32_INT1TIMER32_T32CONTROL1 |= 0x80;
    EnableInterrupts();
}

void Timer_interrupt() iv IVT_INT_T32_INT1
{
    lteiot2_tick();
    TIMER32_T32INTCLR1 = 1;
}
