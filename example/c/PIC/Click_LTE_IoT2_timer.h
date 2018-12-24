/*

Use mikroE Timer Calculator to generate proper timer configuration
and timer ISR.

https://www.mikroe.com/timer-calculator

*/
#include "Click_LTE_IoT2_types.h"

#define __LTE_IoT2_TIMER__

static void lteiot2_configTimer()
{
   T1CON         = 0x01;
   TMR1IF_bit         = 0;
   TMR1H         = 0xC1;
   TMR1L         = 0x80;
   TMR1IE_bit         = 1;
   INTCON         = 0xC0;
}

void interrupt()
{
   if (TMR1IF_bit != 0)
   {
           lteiot2_tick();
           TMR1IF_bit = 0;
           TMR1H = 0xC1;
           TMR1L = 0x80;
   }
}