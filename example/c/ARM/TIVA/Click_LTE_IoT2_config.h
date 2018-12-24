#include "Click_LTE_IoT2_types.h"

const uint32_t _LTEIOT2_TIMER_LIMIT      = 5;	    // 5 ticks
const uint16_t _LTEIOT2_BUF_WARNING      = 192;	// 192 bytes activate warning
const uint8_t  _LTEIOT2_POLL_ENABLE      = 1; 	// poll enabled
const uint8_t  _LTEIOT2_CALLBACK_ENABLE  = 0;	    // calback disabled

const uint32_t _LTEIOT2_UART_CFG[ 6 ] = 
{
	115200, 
	0,                        // CPU FQ Parameter will be replaced during init call
	_UART_8_BIT_DATA, 
	_UART_NOPARITY,
    _UART_ONE_STOPBIT, 
    _UART_HIGH_SPEED
};
