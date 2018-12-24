![MikroE](http://www.mikroe.com/img/designs/beta/logo_small.png)

---

# LTE_IoT2 Click

- **CIC Prefix**  : LTEIOT2
- **Author**      : Katarina Perendic
- **Verison**     : 1.0.0
- **Date**        : maj 2018.

---

### Software Support

We provide a library for the LTE_IoT2 Click on our [LibStock](https://libstock.mikroe.com/projects/view/2482/lte-iot-2-click) 
page, as well as a demo application (example), developed using MikroElektronika 
[compilers](http://shop.mikroe.com/compilers). The demo can run on all the main 
MikroElektronika [development boards](http://shop.mikroe.com/development-boards).

**Library Description**

Library carries generic command parser adopted for AT command based modules. 
Generic parser 

Key functions :

- ``` lteiot2_cmdSingle ``` - Sends provided command to the module
- ``` lteiot2_setHandler ``` - Handler assignation to the provied command
- ``` lteiot2_modulePower ``` - Turn on module

**Examples Description**

The application is composed of three sections :

- System Initialization - Initializes all necessary GPIO pins, UART used for
the communcation with LTE IOT 2 module and UART used for infromation logging
- Application Initialization - Initializes driver, power on module and sends few
command for the default module configuration
- Application Task - Sends message to Quectel NB-IoT test server(bit.ly/quectel-udp-server) every 5 sec.


This code snippet shows how generic parser should be properly initialized. 
Before intialization module must be turned on and additionaly to that hardware 
flow control should be also 

Commands :
- Command: ATI, product information
- Command: AT+IPR=115200;&W, set baudrate 
- Command: AT+QCFG="nbsibscramble",0, Enable scrambling
- Command: AT+QCFG="band",0,0,80,1, set baud
- Command: AT+QCFG="nwscanmode",3,1, Set LTE mode
- Command: AT+QCFG="nwscanseq",030201,1, set priority  NB1 > M1 > 2G
- Command: AT+QCFG="iotopmode",1,1, select CAT-NB1
- Command: AT+QCFG="servicedomain",1,1, Set PS domain
- Command: AT+CGDCONT=1,"IP","internet", set APN provided
- Command: AT+CFUN=1, Full functionality
- Command: AT+COPS=1,2,"22001",0, set MCC and MNC provided
- Command: AT+QIACT=1, activate PDP context
- Command: AT+QIOPEN=1,0,"UDP","79.114.83.116",16666, create an UDP socket
- Command: AT+QISENDEX=0,"48656C6C6F", Send message - Hello


```.c

// MODULE POWER ON
    lteiot2_hfcEnable( true );
    lteiot2_modulePower( true );

// MODULE INIT
    lteiot2_cmdSingle( &ATI[0] );
    lteiot2_cmdSingle( &AT_IPR[0] );
    lteiot2_cmdSingle( &AT_QCFG_1[0] );
    lteiot2_cmdSingle( &AT_QCFG_2[0] );
    lteiot2_cmdSingle( &AT_QCFG_3[0] );
    lteiot2_cmdSingle( &AT_QCFG_4[0] );
    lteiot2_cmdSingle( &AT_QCFG_5[0] );
    lteiot2_cmdSingle( &AT_QCFG_6[0] );
    lteiot2_cmdSingle( &AT_CGDCONT[0] );
    lteiot2_cmdSingle( &AT_CFUN[0] );
    lteiot2_cmdSingle( &AT_COPS[0] );
    lteiot2_cmdSingle( &AT_CGATT[0] );
    lteiot2_cmdSingle( &AT_CEREG[0] );
    lteiot2_cmdSingle( &AT_QIACT[0] );
    lteiot2_cmdSingle( &AT_QIOPEN[0] );
    lteiot2_cmdSingle( &AT_QISENDEX[0] );

```

Alongside with the demo application timer initialization functions are provided.
Note that timer is configured acording to default develoment system and 
MCUs, changing the system or MCU may require update of timer init and timer ISR 
functions.

The full application code, and ready to use projects can be found on our 
[LibStock](https://libstock.mikroe.com/projects/view/2482/lte-iot-2-click) page.

Other mikroE Libraries used in the example:

- String
- Conversion

**Additional notes and informations**

Depending on the development board you are using, you may need 
[USB UART click](http://shop.mikroe.com/usb-uart-click), 
[USB UART 2 Click](http://shop.mikroe.com/usb-uart-2-click) or 
[RS232 Click](http://shop.mikroe.com/rs232-click) to connect to your PC, for 
development systems with no UART to USB interface available on the board. The 
terminal available in all Mikroelektronika 
[compilers](http://shop.mikroe.com/compilers), or any other terminal application 
of your choice, can be used to read the message.

---

| **Supported** | STM | KIN | CEC | MSP | TI  | PIC | P32 | DSP | AVR | FT90x |
|--------------:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:-----:|
| **mikroC**    |  x  |  x  |     |     |  x  |  x  |  x  |  x  |  x  |   x   |
| **mikroB**    |  x  |  x  |     |     |  x  |  x  |  x  |  x  |  x  |   x   |
| **mikroP**    |  x  |  x  |     |     |  x  |  x  |  x  |  x  |  x  |   x   |

---
---
