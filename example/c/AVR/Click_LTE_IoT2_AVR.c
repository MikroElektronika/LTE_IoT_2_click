/*
Example for LTE_IoT2 Click

    Date          : maj 2018.
    Author        : Katarina Perendic

Test configuration AVR :
    
    MCU              : ATMEGA32
    Dev. Board       : EasyAVR v7 
    AVR Compiler ver : v7.0.1.0

---

Description :

The application is composed of three sections :

- System Initialization - Initializes all necessary GPIO pins, UART used for
the communcation with LTE IOT 2 module and UART used for infromation logging
- Application Initialization - Initializes driver, power on module and sends few
command for the default module configuration
- Application Task - Sends message to Quectel NB-IoT test server(bit.ly/quectel-udp-server) every 5 sec.

*/

#include "Click_LTE_IoT2_types.h"
#include "Click_LTE_IoT2_config.h"
#include "Click_LTE_IoT2_timer.h"

char ATI[5] = "ATI";
char AT_IPR[30] = "AT+IPR=115200;&W";
char AT_QCFG_1[30] = "AT+QCFG=\"nbsibscramble\",0";
char AT_QCFG_2[30] = "AT+QCFG=\"band\",0,0,80,1";
char AT_QCFG_3[30] = "AT+QCFG=\"nwscanmode\",3,1";
char AT_QCFG_4[30] = "AT+QCFG=\"nwscanseq\",030201,1";
char AT_QCFG_5[30] = "AT+QCFG=\"iotopmode\",1,1";
char AT_QCFG_6[30] = "AT+QCFG=\"servicedomain\",1,1";
char AT_CGDCONT[30] = "AT+CGDCONT=1,\"IP\",\"internet\"";
char AT_CFUN[10] = "AT+CFUN=1";
char AT_COPS[30] = "AT+COPS=1,2,\"22001\",0";
char AT_CGATT[10] = "AT+CGATT?";
char AT_CEREG[10] = "AT+CEREG?";
char AT_QIACT[20] = "AT+QIACT=1";
char AT_QIOPEN[50] = "AT+QIOPEN=1,0,\"UDP\",\"79.114.83.116\",16666";
char AT_QISENDEX[30] = "AT+QISENDEX=0,\"48656C6C6F\"";

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
    mikrobus_logInit( _LOG_USBUART, 115200 );
    mikrobus_logWrite(" --- System init --- ", _LOG_LINE );
}

void applicationInit()
{
// TIMER INIT
    lteiot2_configTimer();

// DRIVER INIT
    lteiot2_uartDriverInit((T_LTEIOT2_P)&_MIKROBUS1_GPIO, (T_LTEIOT2_P)&_MIKROBUS1_UART);
    lteiot2_coreInit( lteiot2_default_handler, 1500 );

// MODULE POWER ON
    lteiot2_hfcEnable( true );
    lteiot2_modulePower( true );

// MODULE INIT
    //Command: ATI, product information
    lteiot2_cmdSingle( &ATI[0] );
    Delay_1sec();
    //Command: AT+IPR=115200;&W, set baudrate
    lteiot2_cmdSingle( &AT_IPR[0] );
    Delay_1sec();
    //Command: AT+QCFG="nbsibscramble",0, Enable scrambling
    lteiot2_cmdSingle( &AT_QCFG_1[0] );
    Delay_1sec();
    //Command: AT+QCFG="band",0,0,80,1, set baud
    lteiot2_cmdSingle( &AT_QCFG_2[0] );
    Delay_1sec();
    //Command: AT+QCFG="nwscanmode",3,1, Set LTE mode
    lteiot2_cmdSingle( &AT_QCFG_3[0] );
    Delay_1sec();
    //Command: AT+QCFG="nwscanseq",030201,1, set priority  NB1 > M1 > 2G
    lteiot2_cmdSingle( &AT_QCFG_4[0] );
    Delay_1sec();
    //Command: AT+QCFG="iotopmode",1,1, select CAT-NB1
    lteiot2_cmdSingle( &AT_QCFG_5[0] );
    Delay_1sec();
    //Command: AT+QCFG="servicedomain",1,1, Set PS domain
    lteiot2_cmdSingle( &AT_QCFG_6[0] );
    Delay_1sec();
    //Command: AT+CGDCONT=1,"IP","internet", set APN provided
    lteiot2_cmdSingle( &AT_CGDCONT[0] );
    Delay_1sec();
    //Command: AT+CFUN=1, Full functionality
    lteiot2_cmdSingle( &AT_CFUN[0] );
    Delay_1sec();
    //Command: AT+COPS=1,2,"22001",0, set MCC and MNC provided
    lteiot2_cmdSingle( &AT_COPS[0] );
    Delay_1sec();
    lteiot2_cmdSingle( &AT_CGATT[0] );
    Delay_1sec();
    lteiot2_cmdSingle( &AT_CEREG[0] );
    Delay_1sec();
    //Command: AT+QIACT=1, activate PDP context
    lteiot2_cmdSingle( &AT_QIACT[0] );
    Delay_1sec();
    //Command: AT+QIOPEN=1,0,"UDP","79.114.83.116",16666, create an UDP socket
    lteiot2_cmdSingle( &AT_QIOPEN[0] );
    Delay_1sec();
    //Command: AT+QISENDEX=0,"48656C6C6F", Send message - Hello
    lteiot2_cmdSingle( &AT_QISENDEX[0] );
    Delay_1sec();
}

void applicationTask()
{
    lteiot2_process();
    // Send message - Hello
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

/* -------------------------------------------------------------------------- */