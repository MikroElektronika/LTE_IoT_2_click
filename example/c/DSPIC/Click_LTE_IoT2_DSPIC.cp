#line 1 "D:/Clicks_git/LTE_IoT_2_Click/SW/example/c/DSPIC/Click_LTE_IoT2_DSPIC.c"
#line 1 "d:/clicks_git/lte_iot_2_click/sw/example/c/dspic/click_lte_iot2_types.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for dspic/include/stdint.h"




typedef signed char int8_t;
typedef signed int int16_t;
typedef signed long int int32_t;


typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long int uint32_t;


typedef signed char int_least8_t;
typedef signed int int_least16_t;
typedef signed long int int_least32_t;


typedef unsigned char uint_least8_t;
typedef unsigned int uint_least16_t;
typedef unsigned long int uint_least32_t;



typedef signed int int_fast8_t;
typedef signed int int_fast16_t;
typedef signed long int int_fast32_t;


typedef unsigned int uint_fast8_t;
typedef unsigned int uint_fast16_t;
typedef unsigned long int uint_fast32_t;


typedef signed int intptr_t;
typedef unsigned int uintptr_t;


typedef signed long int intmax_t;
typedef unsigned long int uintmax_t;
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for dspic/include/stdbool.h"



 typedef char _Bool;
#line 1 "d:/clicks_git/lte_iot_2_click/sw/example/c/dspic/click_lte_iot2_config.h"
#line 1 "d:/clicks_git/lte_iot_2_click/sw/example/c/dspic/click_lte_iot2_types.h"
#line 3 "d:/clicks_git/lte_iot_2_click/sw/example/c/dspic/click_lte_iot2_config.h"
const uint32_t _LTEIOT2_TIMER_LIMIT = 5;
const uint16_t _LTEIOT2_BUF_WARNING = 192;
const uint8_t _LTEIOT2_POLL_ENABLE = 1;
const uint8_t _LTEIOT2_CALLBACK_ENABLE = 0;

const uint32_t _LTEIOT2_UART_CFG[ 1 ] =
{
 115200
};
#line 1 "d:/clicks_git/lte_iot_2_click/sw/example/c/dspic/click_lte_iot2_timer.h"
#line 1 "d:/clicks_git/lte_iot_2_click/sw/example/c/dspic/click_lte_iot2_types.h"
#line 1 "d:/clicks_git/lte_iot_2_click/sw/library/__lteiot2_driver.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for dspic/include/stdint.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for dspic/include/stdbool.h"
#line 53 "d:/clicks_git/lte_iot_2_click/sw/library/__lteiot2_driver.h"
extern const uint8_t _LTEIOT2_UNKNOWN ;
extern const uint8_t _LTEIOT2_TEST ;
extern const uint8_t _LTEIOT2_SET ;
extern const uint8_t _LTEIOT2_GET ;
extern const uint8_t _LTEIOT2_URC ;
extern const uint8_t _LTEIOT2_EXEC ;



extern const uint8_t _LTEIOT2_EVARG_START_T ;
extern const uint8_t _LTEIOT2_EVARG_END_T ;
extern const uint8_t _LTEIOT2_EVARG_EVENT_T ;

extern const uint8_t _LTEIOT2_EVENT_RESPONSE ;
extern const uint8_t _LTEIOT2_EVENT_TIMEOUT ;
extern const uint8_t _LTEIOT2_EVENT_BUFFER_OUT ;
extern const uint8_t _LTEIOT2_EVENT_CALLBACK ;
#line 75 "d:/clicks_git/lte_iot_2_click/sw/library/__lteiot2_driver.h"
typedef void ( *T_lteiot2_handler )( char *buffer, uint8_t *evArgs );
#line 91 "d:/clicks_git/lte_iot_2_click/sw/library/__lteiot2_driver.h"
void lteiot2_uartDriverInit( const uint8_t*  gpioObj,  const uint8_t*  uartObj);
#line 103 "d:/clicks_git/lte_iot_2_click/sw/library/__lteiot2_driver.h"
void lteiot2_coreInit( T_lteiot2_handler defaultHdl, uint32_t defaultWdog );
#line 115 "d:/clicks_git/lte_iot_2_click/sw/library/__lteiot2_driver.h"
void lteiot2_hfcEnable(  _Bool  hfcState );
#line 124 "d:/clicks_git/lte_iot_2_click/sw/library/__lteiot2_driver.h"
void lteiot2_modulePower(  _Bool  powerState );
#line 135 "d:/clicks_git/lte_iot_2_click/sw/library/__lteiot2_driver.h"
void lteiot2_putc( char rxInput );
#line 143 "d:/clicks_git/lte_iot_2_click/sw/library/__lteiot2_driver.h"
void lteiot2_tick();
#line 154 "d:/clicks_git/lte_iot_2_click/sw/library/__lteiot2_driver.h"
uint16_t lteiot2_setHandler( char *pCmd, uint32_t timeout, T_lteiot2_handler pHandler );
#line 164 "d:/clicks_git/lte_iot_2_click/sw/library/__lteiot2_driver.h"
void lteiot2_cmdSingle( char *pCmd );
#line 176 "d:/clicks_git/lte_iot_2_click/sw/library/__lteiot2_driver.h"
void lteiot2_cmdDouble( char *pCmd, char *pArg1 );
#line 189 "d:/clicks_git/lte_iot_2_click/sw/library/__lteiot2_driver.h"
void lteiot2_cmdTriple( char *pCmd, char *pArg1, char *pArg2 );
#line 196 "d:/clicks_git/lte_iot_2_click/sw/library/__lteiot2_driver.h"
void lteiot2_process();
#line 15 "d:/clicks_git/lte_iot_2_click/sw/example/c/dspic/click_lte_iot2_timer.h"
static void lteiot2_configTimer()
{
 T1CON = 0x8000;
 T1IE_bit = 1;
 T1IF_bit = 0;
 IPC0 = IPC0 | 0x1000;
 PR1 = 4000;
}

void Timer_interrupt() iv IVT_ADDR_T1INTERRUPT
{
 T1IF_bit = 0;
 lteiot2_tick();
}
#line 1 "d:/clicks_git/lte_iot_2_click/sw/library/__lteiot2_driver.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for dspic/include/stdint.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for dspic/include/stdbool.h"
#line 33 "D:/Clicks_git/LTE_IoT_2_Click/SW/example/c/DSPIC/Click_LTE_IoT2_DSPIC.c"
void lteiot2_default_handler( uint8_t *rsp, uint8_t *evArgs )
{
 mikrobus_logWrite( rsp, _LOG_TEXT );
}

void systemInit()
{
 mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_AN_PIN, _GPIO_INPUT );
 mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_PWM_PIN, _GPIO_INPUT );
 mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_INT_PIN, _GPIO_INPUT );
 mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_RST_PIN, _GPIO_OUTPUT );
 mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_CS_PIN, _GPIO_OUTPUT );
 mikrobus_uartInit( _MIKROBUS1, &_LTEIOT2_UART_CFG[0] );
 mikrobus_logInit( _LOG_USBUART_B, 115200 );
 mikrobus_logWrite(" --- System init --- ", _LOG_LINE );
}

void applicationInit()
{

 lteiot2_configTimer();


 lteiot2_uartDriverInit(( const uint8_t* )&_MIKROBUS1_GPIO, ( const uint8_t* )&_MIKROBUS1_UART);
 lteiot2_coreInit( lteiot2_default_handler, 1500 );


 lteiot2_hfcEnable(  1  );
 lteiot2_modulePower(  1  );



 lteiot2_cmdSingle( "ATI" );
 Delay_1sec();

 lteiot2_cmdSingle( "AT+IPR=115200;&W" );
 Delay_1sec();

 lteiot2_cmdSingle( "AT+QCFG=\"nbsibscramble\",0" );
 Delay_1sec();

 lteiot2_cmdSingle( "AT+QCFG=\"band\",0,0,80,1" );
 Delay_1sec();

 lteiot2_cmdSingle( "AT+QCFG=\"nwscanmode\",3,1" );
 Delay_1sec();

 lteiot2_cmdSingle( "AT+QCFG=\"nwscanseq\",030201,1" );
 Delay_1sec();

 lteiot2_cmdSingle( "AT+QCFG=\"iotopmode\",1,1" );
 Delay_1sec();

 lteiot2_cmdSingle( "AT+QCFG=\"servicedomain\",1,1" );
 Delay_1sec();

 lteiot2_cmdSingle( "AT+CGDCONT=1,\"IP\",\"internet\"" );
 Delay_1sec();

 lteiot2_cmdSingle( "AT+CFUN=1" );
 Delay_1sec();

 lteiot2_cmdSingle( "AT+COPS=1,2,\"22001\",0" );
 Delay_1sec();
 lteiot2_cmdSingle( "AT+CGATT?" );
 Delay_1sec();
 lteiot2_cmdSingle( "AT+CEREG?" );
 Delay_1sec();

 lteiot2_cmdSingle( "AT+QIACT=1" );
 Delay_1sec();

 lteiot2_cmdSingle( "AT+QIOPEN=1,0,\"UDP\",\"79.114.83.116\",16666" );
 Delay_1sec();

 lteiot2_cmdSingle( "AT+QISENDEX=0,\"48656C6C6F\"" );
 Delay_1sec();
}

void applicationTask()
{
 lteiot2_process();

 lteiot2_cmdSingle( "AT+QISENDEX=0,\"48656C6C6F\"" );
 Delay_ms(5000);
}

void main()
{
 systemInit();
 applicationInit();

 while (1)
 {
 applicationTask();
 }
}
