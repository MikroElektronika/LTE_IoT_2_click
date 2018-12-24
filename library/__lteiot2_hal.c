/*
    __lteiot2_hal.c

-----------------------------------------------------------------------------

  This file is part of mikroSDK.

  Copyright (c) 2017, MikroElektonika - http://www.mikroe.com

  All rights reserved.

----------------------------------------------------------------------------- */

/**  
@file  __lteiot2_hal.c
@brief   LTEIOT2 HAL Interface
*/
/**
@defgroup   LTEIOT2_HAL
@brief      LTE_IoT2 HAL Interface
@{

| Global Library Prefix | **HAL**            |
|:---------------------:|:------------------:|
| Version               | **3.2.1**          |
| Date                  | **Sep 2017**       |
| Developer             | **MikroE FW Team** |

*/
/* -------------------------------------------------------------------------- */

#include "stdint.h"

/** 
 * @macro T_HAL_P
 * @brief HAL Global Abstract Type
 */
#define T_HAL_P         const uint8_t*      

#define T_HAL_UART_OBJ  const T_hal_uartObj*
#define T_HAL_GPIO_OBJ  const T_hal_gpioObj*
                                       
/** @defgroup LTEIOT2_HAL_COMPILE HAL Cofiguration */            /** @{ */

#define __HAL_UART__   

// #define   __AN_PIN_INPUT__          0
// #define   __RST_PIN_INPUT__         1
// #define   __CS_PIN_INPUT__          2
// #define   __SCK_PIN_INPUT__         3
// #define   __MISO_PIN_INPUT__        4                                   
// #define   __MOSI_PIN_INPUT__        5
// #define   __PWM_PIN_INPUT__         6                                  
 #define   __INT_PIN_INPUT__         7
// #define   __RX_PIN_INPUT__          8                              
// #define   __TX_PIN_INPUT__          9
// #define   __SCL_PIN_INPUT__         10                                  
// #define   __SDA_PIN_INPUT__         11  

// #define   __AN_PIN_OUTPUT__         0
  #define   __RST_PIN_OUTPUT__        1                                   
  #define   __CS_PIN_OUTPUT__         2                              
// #define   __SCK_PIN_OUTPUT__        3
// #define   __MISO_PIN_OUTPUT__       4                                    
// #define   __MOSI_PIN_OUTPUT__       5
// #define   __PWM_PIN_OUTPUT__        6                                    
// #define   __INT_PIN_OUTPUT__        7
// #define   __RX_PIN_OUTPUT__         8                                
// #define   __TX_PIN_OUTPUT__         9
// #define   __SCL_PIN_OUTPUT__        10                                    
// #define   __SDA_PIN_OUTPUT__        11    
                                                                       /** @} */
#ifdef __HAL_UART__   

/** @defgroup LTEIOT2_HAL_UART HAL UART Interface */             /** @{ */

/**
 * @brief Map UART Function Pointers
 */
static void hal_uartMap(T_HAL_P uartObj);

/**
 * @brief hal_uartWrite
 *
 * @param[in] input tx data byte
 *
 * Function writes one byte on UART.
 */
static void hal_uartWrite(uint8_t input);

/**
 * @brief hal_uartRead
 *
 * @return rx data byte
 *
 * Function reads one byte.
 */
static uint8_t hal_uartRead();

/**
 * @brief hal_uartReady
 *
 * @return rx buffer state
 *
 * Function should return 1 if rx buffer have received new data.
 */
static uint8_t hal_uartReady();
                                                                       /** @} */
#endif

/** @defgroup LTEIOT2_HAL_GPIO HAL GPIO Interface */             /** @{ */

/**
 * @typedef T_hal_gpioSetFp
 * @brief Default GPIO Set function pointer 
 */
typedef void    (*T_hal_gpioSetFp)(uint8_t); 

/**
 * @typedef T_hal_gpioGetFp
 * @brief Default GPIO Get function pointer 
 */                        
typedef uint8_t (*T_hal_gpioGetFp)();

/**
 * @struct T_hal_gpioObj
 * @brief Common GPIO HAL structure 
 * 
 * Structure carries pointer to all GPIO functions found on 
 * mikrobus.
 */
typedef struct
{
    T_hal_gpioSetFp      gpioSet[ 12 ]; /**< Set pointers */
    T_hal_gpioGetFp      gpioGet[ 12 ]; /**< Get pointers */
  
}T_hal_gpioObj;

#ifdef __AN_PIN_INPUT__
static T_hal_gpioGetFp          hal_gpio_anGet; 
#endif
#ifdef __CS_PIN_INPUT__
static T_hal_gpioGetFp          hal_gpio_csGet; 
#endif
#ifdef __RST_PIN_INPUT__
static T_hal_gpioGetFp          hal_gpio_rstGet; 
#endif
#ifdef __SCK_PIN_INPUT__
static T_hal_gpioGetFp          hal_gpio_sckGet; 
#endif
#ifdef __MISO_PIN_INPUT__
static T_hal_gpioGetFp          hal_gpio_misoGet; 
#endif
#ifdef __MOSI_PIN_INPUT__
static T_hal_gpioGetFp          hal_gpio_mosiGet; 
#endif
#ifdef __PWM_PIN_INPUT__
static T_hal_gpioGetFp          hal_gpio_pwmGet; 
#endif
#ifdef __INT_PIN_INPUT__
static T_hal_gpioGetFp          hal_gpio_intGet; 
#endif
#ifdef __RX_PIN_INPUT__   
static T_hal_gpioGetFp          hal_gpio_rxGet; 
#endif
#ifdef __TX_PIN_INPUT__   
static T_hal_gpioGetFp          hal_gpio_txGet; 
#endif
#ifdef __SCL_PIN_INPUT__  
static T_hal_gpioGetFp          hal_gpio_sclGet; 
#endif
#ifdef __SDA_PIN_INPUT__  
static T_hal_gpioGetFp          hal_gpio_sdaGet; 
#endif
#ifdef __AN_PIN_OUTPUT__  
static T_hal_gpioSetFp          hal_gpio_anSet;  
#endif
#ifdef __CS_PIN_OUTPUT__
static T_hal_gpioSetFp          hal_gpio_csSet;  
#endif
#ifdef __RST_PIN_OUTPUT__ 
static T_hal_gpioSetFp          hal_gpio_rstSet;  
#endif
#ifdef __SCK_PIN_OUTPUT__ 
static T_hal_gpioSetFp          hal_gpio_sckSet;  
#endif
#ifdef __MISO_PIN_OUTPUT__
static T_hal_gpioSetFp          hal_gpio_misoSet;  
#endif
#ifdef __MOSI_PIN_OUTPUT__
static T_hal_gpioSetFp          hal_gpio_mosiSet;  
#endif
#ifdef __PWM_PIN_OUTPUT__ 
static T_hal_gpioSetFp          hal_gpio_pwmSet;  
#endif
#ifdef __INT_PIN_OUTPUT__ 
static T_hal_gpioSetFp          hal_gpio_intSet;  
#endif
#ifdef __RX_PIN_OUTPUT__  
static T_hal_gpioSetFp          hal_gpio_rxSet;  
#endif
#ifdef __TX_PIN_OUTPUT__  
static T_hal_gpioSetFp          hal_gpio_txSet;  
#endif
#ifdef __SCL_PIN_OUTPUT__ 
static T_hal_gpioSetFp          hal_gpio_sclSet;  
#endif
#ifdef __SDA_PIN_OUTPUT__ 
static T_hal_gpioSetFp          hal_gpio_sdaSet;  
#endif                              

/**
 * @brief Map GPIO Function pointers
 */
static void hal_gpioMap(T_HAL_P gpioObj)
{
    T_HAL_GPIO_OBJ tmp = (T_HAL_GPIO_OBJ)gpioObj;

#ifdef __AN_PIN_INPUT__
    hal_gpio_anGet = tmp->gpioGet[ __AN_PIN_INPUT__ ];
#endif
#ifdef __CS_PIN_INPUT
    hal_gpio_csGet = tmp->gpioGet[ __CS_PIN_INPUT__ ];
#endif
#ifdef __RST_PIN_INPUT__
    hal_gpio_rstGet = tmp->gpioGet[ __RST_PIN_INPUT__ ];
#endif
#ifdef __SCK_PIN_INPUT__  
    hal_gpio_sckGet = tmp->gpioGet[ __SCK_PIN_INPUT__ ];
#endif
#ifdef __MISO_PIN_INPUT__ 
    hal_gpio_misoGet = tmp->gpioGet[ __MISO_PIN_INPUT__ ];
#endif
#ifdef __MOSI_PIN_INPUT__ 
    hal_gpio_mosiGet = tmp->gpioGet[ __MOSI_PIN_INPUT__ ];
#endif
#ifdef __PWM_PIN_INPUT__  
    hal_gpio_pwmGet = tmp->gpioGet[ __PWM_PIN_INPUT__ ];
#endif
#ifdef __INT_PIN_INPUT__ 
    hal_gpio_intGet = tmp->gpioGet[ __INT_PIN_INPUT__ ];
#endif
#ifdef __RX_PIN_INPUT__   
    hal_gpio_rxGet = tmp->gpioGet[ __RX_PIN_INPUT__ ];
#endif
#ifdef __TX_PIN_INPUT__   
    hal_gpio_txGet = tmp->gpioGet[ __TX_PIN_INPUT__ ];
#endif
#ifdef __SCL_PIN_INPUT__  
    hal_gpio_sclGet = tmp->gpioGet[ __SCL_PIN_INPUT__ ];
#endif
#ifdef __SDA_PIN_INPUT__  
    hal_gpio_sdaGet = tmp->gpioGet[ __SDA_PIN_INPUT__ ];
#endif
#ifdef __AN_PIN_OUTPUT__  
    hal_gpio_anSet = tmp->gpioSet[ __AN_PIN_OUTPUT__ ];
#endif
#ifdef __CS_PIN_OUTPUT__
    hal_gpio_csSet = tmp->gpioSet[ __CS_PIN_OUTPUT__ ];
#endif
#ifdef __RST_PIN_OUTPUT__ 
    hal_gpio_rstSet = tmp->gpioSet[ __RST_PIN_OUTPUT__ ];
#endif
#ifdef __SCK_PIN_OUTPUT__ 
    hal_gpio_sckSet = tmp->gpioSet[ __SCK_PIN_OUTPUT ];
#endif
#ifdef __MISO_PIN_OUTPUT__
    hal_gpio_misoSet = tmp->gpioSet[ __MISO_PIN_OUTPUT__ ];
#endif
#ifdef __MOSI_PIN_OUTPUT__
    hal_gpio_mosiSet = tmp->gpioSet[ __MOSI_PIN_OUTPUT__ ];
#endif
#ifdef __PWM_PIN_OUTPUT__ 
    hal_gpio_pwmSet = tmp->gpioSet[ __PWM_PIN_OUTPUT__ ];
#endif
#ifdef __INT_PIN_OUTPUT__ 
    hal_gpio_intSet = tmp->gpioSet[ __INT_PIN_OUTPUT__ ];
#endif
#ifdef __RX_PIN_OUTPUT__  
    hal_gpio_rxSet = tmp->gpioSet[ __RX_PIN_OUTPUT__ ];
#endif
#ifdef __TX_PIN_OUTPUT__  
    hal_gpio_txSet = tmp->gpioSet[ __TX_PIN_OUTPUT__ ];
#endif
#ifdef __SCL_PIN_OUTPUT__ 
    hal_gpio_sclSet = tmp->gpioSet[ __SCL_PIN_OUTPUT__ ];
#endif
#ifdef __SDA_PIN_OUTPUT__ 
    hal_gpio_sdaSet = tmp->gpioSet[ __SDA_PIN_OUTPUT__ ];
#endif
}
                                                                       /** @} */
#ifdef __MIKROC_PRO_FOR_PIC__
#include "__HAL_PIC.c"
#endif

#ifdef __MIKROC_PRO_FOR_PIC32__
#include "__HAL_PIC32.c"
#endif

#ifdef __MIKROC_PRO_FOR_DSPIC__
#include "__HAL_DSPIC.c"
#endif

#ifdef __MIKROC_PRO_FOR_AVR__
#include "__HAL_AVR.c"
#endif

#ifdef __MIKROC_PRO_FOR_FT90x__
#include "__HAL_FT90x.c"
#endif

#ifdef __MIKROC_PRO_FOR_ARM__
#ifdef __STM32__
#include "__HAL_STM32.c"
#endif
#endif

#ifdef __MIKROC_PRO_FOR_ARM__
#ifdef __TI__
#ifndef MSP432P401R
#include "__HAL_TIVA.c"
#endif
#endif
#endif

#ifdef __MIKROC_PRO_FOR_ARM__
#ifdef MSP432P401R
#include "__HAL_MSP432.c"
#endif
#endif

#ifdef __MIKROC_PRO_FOR_ARM__
#ifdef __KINETIS__
#include "__HAL_KINETIS.c"
#endif
#endif

#ifdef __MIKROC_PRO_FOR_ARM__
#ifdef __MCHP__
#include "__HAL_CEC.c"
#endif
#endif

/* -------------------------------------------------------------------------- */
/*
  __lteiot2_hal.c

  Copyright (c) 2017, MikroElektonika - http://www.mikroe.com

  All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

3. All advertising materials mentioning features or use of this software
   must display the following acknowledgement:
   This product includes software developed by the MikroElektonika.

4. Neither the name of the MikroElektonika nor the
   names of its contributors may be used to endorse or promote products
   derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY MIKROELEKTRONIKA ''AS IS'' AND ANY
EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL MIKROELEKTRONIKA BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

----------------------------------------------------------------------------- */