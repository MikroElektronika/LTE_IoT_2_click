/*
    __lteiot2_driver.c

-----------------------------------------------------------------------------

  This file is part of mikroSDK.

  Copyright (c) 2017, MikroElektonika - http://www.mikroe.com

  All rights reserved.

----------------------------------------------------------------------------- */

#include "__lteiot2_driver.h"
#include "__lteiot2_hal.c"

/* ------------------------------------------------------------------- MACROS */

/*
 * Termintation characters 
 */
#define TERMINATION_CHAR        0x0D
#define TERMINATION_CHAR_ADD    0x1A

/*
 * @macro LUTS_WIDTH
 * @brief LUT width - common for both tables
 */
#define LUTS_WIDTH              3

/*
 * @macro LUT_START_MARK_SIZE
 * @brief Start Mark LUT size
 */
#define LUT_START_MARK_SIZE     7

/*
 * @macro LUT_END_MARK_SIZE
 * @brief End Mark LUT size
 */
#define LUT_END_MARK_SIZE       6

/* Core Macros */
#define CORE_SEQUENCE()                                                        \
{ while( f_sequence_active ) lteiot2_process(); }
#define CORE_BLOCK()                                                           \
{ f_wdog_timeout = false; f_response_ready = false; f_sequence_active = true; }
#define CORE_UNBLOCK()                                                         \
{ f_wdog_timeout = false; f_response_ready = false; f_sequence_active = false; }
#define CORE_CLEAN_RX()                                                        \
{ rxBuff.idx = 0; rxBuff.storage[0] = 0; }

/* HFC Macros */
#define MODULE_BUSY()                                                          \
( DCE_getState() ? 0 : 1 )
#define CORE_SET_BUSY()                                                        \
{ if (0!= f_hfc_active) DTE_setState(false); }
#define CORE_SET_FREE()                                                        \
{ if (0!= f_hfc_active) DTE_setState(true); }

/* Watchdog Macros */ 
#define WATCHDOG_START()                                                       \
{ c_watchdog_timer = 0; f_watchdog_active = true; }
#define WATCHDOG_STOP()                                                        \
{ f_watchdog_active = false; }

/* Timer Macros */
#define TIMER_START()                                                          \
{ c_timer = 0; f_timer_active = true; }
#define TIMER_STOP()                                                           \
{ f_timer_active = false; }

/* Event Macros */
#define EXEC_EVENT(x)                                                          \
{ currentEv.evArg[_LTEIOT2_EVARG_EVENT_T] = x; currentEv.fpHdl(rxBuff.storage, currentEv.evArg); }
#define EXEC_CALLBACK()                                                        \
if (0 != _LTEIOT2_CALLBACK_ENABLE)                                       \
{ currentEv.evArg[_LTEIOT2_EVARG_EVENT_T] = _LTEIOT2_EVENT_CALLBACK; currentEv.fpHdl(txBuff, currentEv.evArg); }

/* ---------------------------------------------------------- EXTERNAL CONFIG */

/** End of response time between characters in ms */
extern const uint32_t           _LTEIOT2_TIMER_LIMIT;

/** Response buffer warning limit */
extern const uint16_t           _LTEIOT2_BUF_WARNING;

/** Enables UART polling */
extern const uint8_t            _LTEIOT2_POLL_ENABLE;

/** Enables event call after transmision */
extern const uint8_t            _LTEIOT2_CALLBACK_ENABLE;

/* ------------------------------------------------------------ BUFFER CONFIG */

/** Max command size excluding command args */
const uint8_t                   _LTEIOT2_CMD_MAXSIZE  = 16;

/** Response buffer size */
const uint16_t                  _LTEIOT2_BUF_SIZE     = 256;

/** Handlers storage size */
const uint16_t                  _LTEIOT2_STORAGE_SIZE = 32;

/* ------------------------------------------------------------ PARSER CONFIG */

const uint8_t _LTEIOT2_EVARG_START_T    = 0;
const uint8_t _LTEIOT2_EVARG_END_T      = 1;
const uint8_t _LTEIOT2_EVARG_EVENT_T    = 2;

const uint8_t _LTEIOT2_EVENT_RESPONSE   = 0x00;
const uint8_t _LTEIOT2_EVENT_TIMEOUT    = 0x01;
const uint8_t _LTEIOT2_EVENT_BUFFER_OUT = 0x02;
const uint8_t _LTEIOT2_EVENT_CALLBACK   = 0x04;

/* 
 * Look up table for START MARK string, must have "" as first member 
 */
static char LUT_START_MARK[LUT_START_MARK_SIZE][LUTS_WIDTH] =
{
    "",            // Default - skipped by search
    "+",           // AT+...
    "#",           // AT#...
    "$",           // AT$...
    "%"            // AT%...
    "\\",          // AT\...
    "&"            // AT&...
};

/* 
 * Look up table for END MARK string, must have "" as 0 member
 */
static char LUT_END_MARK[LUT_END_MARK_SIZE][LUTS_WIDTH] =
{
    "",             // Default - skipped by search
    "=?",           // Test
    "?",            // Get
    "=",            // Set
    ":",            // URC 100%
    "\r"            // Exec
};

const uint8_t _LTEIOT2_UNKNOWN  = 0;
const uint8_t _LTEIOT2_TEST     = 1;
const uint8_t _LTEIOT2_GET      = 2;
const uint8_t _LTEIOT2_SET      = 3;
const uint8_t _LTEIOT2_URC      = 4;
const uint8_t _LTEIOT2_EXEC     = 5;

/* --------------------------------------------------------------- HFC CONFIG */

static void DTE_setState(bool state)
{
// True = DTE free / False = DTE busy
    if (true == state)
    {
        hal_gpio_csSet( 0 );
    }
    else
    {
        hal_gpio_csSet( 1 );
    }

}

static bool DCE_getState()
{
// True = DCE free / False = DCE busy
    if (0 != hal_gpio_intGet())
    {
        return false;
    }
    else
    {
        return true;
    }

}

void lteiot2_modulePower( bool powerState )
{
    if (0 != powerState)
    {
      hal_gpio_rstSet(0);
      Delay_100ms();
      hal_gpio_rstSet(1);
      Delay_1sec();
      hal_gpio_rstSet(0);
      Delay_1sec();
      Delay_1sec();
      Delay_1sec();
    }
    else
    {
//  POWER OFF SEQUENCE


    }
}

/* -------------------------------------------------------------------- TYPES */

/**
 * @struct T_CORE_event
 * @brief Event Structure
 *
 * Structure is provided to ```createEvent function which will populate 
 * structure fields depend on parsing.
 */
typedef struct
{
    /** Pointer to handler for the particular command */
    T_lteiot2_handler   fpHdl;
    /** Watchdog timer for particular command */
    uint32_t                    wDogLimit;
    /** Event arguments */
    uint8_t                     evArg[3];
    
}T_CORE_event;

/**
 * @struct T_CORE_obj
 * @brief Parser Structure
 *
 * Struct is used for storing the command with timeout and callbacks.
 * Command strings are converted to the hash code for easiest comparision.
 */
typedef struct
{
    /** Command Length */
    uint16_t                    len;
    /** Command Hash Value */
    uint32_t                    hash;
    /** Command Timeout */
    uint32_t                    timeout;
    /** Callback/Handler */
    T_lteiot2_handler   handler;

}T_CORE_obj;

typedef struct
{
    uint16_t                    idx;
    uint8_t                     storage[_LTEIOT2_BUF_SIZE];
  
}T_rx_buffer;
    
typedef struct
{
    uint16_t                    idx;
    T_CORE_obj                  storage[_LTEIOT2_STORAGE_SIZE];

}T_handler_storage;

/* ---------------------------------------------------------------- VARIABLES */

static volatile T_CORE_event        currentEv;
static volatile T_rx_buffer         rxBuff;
static volatile T_handler_storage   hdlBuff;

/* Engine flags and calls*/
static volatile bool                f_hfc_active;
static volatile bool                f_sequence_active;
static volatile bool                f_buffer_warning;
static volatile bool                f_response_ready;
static volatile bool                f_wdog_timeout;

/* Watchdog vars */
static volatile bool                f_watchdog_active;
static volatile uint32_t            c_watchdog_timer;

/* Timer vars */
static volatile bool                f_timer_active;
static volatile uint32_t            c_timer;

static uint8_t                      txBuff[_LTEIOT2_BUF_SIZE];

/* --------------------------------------------------------- HELPER FUNCTIONS */

static int8_t _strncmp(uint8_t *cs, uint8_t *ct, uint16_t count)
{
    char c1;
    char c2;
    uint16_t i = 0;
    uint16_t j = 0;

    while (0 != count) 
    {
        c1 = cs[i++];
        c2 = ct[j++];

        if (c1 != c2)
        {
            return c1 < c2 ? -1 : 1;
        }
        if (0 == c1)
        {
            break;
        }
        count--;
    }
    return 0;
}

static void _strncpy(uint8_t *dest, uint8_t *src, uint16_t count)
{
    char *tmp  = dest;

    uint16_t i = 0;

    while (0 != count) 
    {
        if (0 != (*tmp = src[i]))
        {
            i++;
        }
        tmp++;
        count--;
    }
}

static void _strcpy(uint8_t *dest, uint8_t *src)
{
    char *tmp = dest;

    uint16_t i = 0;
    uint16_t j = 0;

    while ((dest[i++] = src[j++]) != '\0')
        ;
}

static void _strcat(uint8_t *dest, uint8_t *src)
{
    char *tmp  = dest;
    uint16_t i = 0;
    uint16_t j = 0;

    while (0 != dest[i])
    {
        i++;
    }

    while ((dest[i++] = src[j++]) != '\0')
        ;
}

static uint16_t _strlen(uint8_t *s)
{
    uint16_t i = 0;
    uint16_t c = 0;

    while (0 != s[i])
    {
        i++;
        c++;
    }

    return c;
}

/* -------------------------------------------- PRIVATE FUNCTION DECLARATIONS */

/*
 * Transmission
 *
 * Transmission uses function pointer provided by the user as an argument
 * to the initialization of the engine.
 */
static void transmitCommand( uint8_t *pInput, uint8_t delimiter );

/*
 * Simple Hash code generation
 *
 * Hash code is used to save the command to the storage in aim to have fixed
 * storage space for all functions.
 */
static uint32_t generateHash( char *pCmd );

/*
 * Search handler storage for provided command
 *
 * Function search the storage based on sting length and hash code.
 * If function returns zero command does not exists in storage area.
 */
static uint16_t locateHandler( char* pCmd );

/*
 * Search input for strings from LUT table.
 * LUT table must be 2 dimensional char array.
 *
 * Depend of flag returned value is :
 * - index of found string at LUT
 * - found string offset inside input
 * - (-1) no match
 */
static int searchLut( char* pInput, char (*pLut)[ LUTS_WIDTH ], int lutSize, int flag );

/*
 * Parsing and Event Creation
 *
 * @param[in] char* input - AT Command
 * @param[out] at_cmd_cb* cb - handler pointer for the particular command
 * @param[out] uint32_t* timeout - timeout for the particular command
 *
 * Function parses provided raw command string and returns previously saved
 * handler and timeout for the particular command. If command is not found
 * the default handler and default timeout will be returned.
 */
static void createEvent( char *pInput, T_CORE_event *pEvent );


/* --------------------------------------------- PRIVATE FUNCTION DEFINITIONS */

static void transmitCommand( uint8_t *pInput, uint8_t delimiter )
{
    while (0 != *pInput)
    {
        if (0!= f_hfc_active)
        {
            while (MODULE_BUSY()) 
            { 
                asm nop; 
            }
        }
        hal_uartWrite(*pInput++);
    }
    hal_uartWrite(delimiter);
    hal_uartWrite('\n');
}

static uint32_t generateHash( char *pCmd )
{
    uint8_t  cnt  = 0;
    uint16_t ch   = 0;
    uint32_t hash = 5;

    while ( ch = *pCmd++ )
    {
        hash += (ch << (cnt % 8));
        cnt++;
    }
    return hash;
}

static uint16_t locateHandler( char* pCmd )
{
    uint8_t     len;
    uint16_t    idx;
    uint32_t    hash;

    idx = 0;
    len = _strlen(pCmd);
    hash = generateHash(pCmd);

    for (idx = 1; idx < hdlBuff.idx; idx++)
    {
        if (hdlBuff.storage[idx].len == len)
        {
            if (hdlBuff.storage[idx].hash == hash)
            {
                return idx;
            }
        }
    }
    
    return 0;
}

const uint8_t SEARCH_IDX         = 0;
const uint8_t SEARCH_OFFSET      = 1;

static uint8_t searchLut( char* pInput, char (*pLut)[ LUTS_WIDTH ], uint8_t lutSize, uint8_t flag )
{
    uint8_t     inLen    = 0;
    uint8_t     inOff    = 0;
    uint8_t     lutLen   = 0;
    uint8_t     lutIdx   = 0;

    if (_LTEIOT2_CMD_MAXSIZE < (inLen = _strlen(pInput)))
    {
        inLen = _LTEIOT2_CMD_MAXSIZE;
    }

    for (lutIdx = 1; lutIdx < lutSize; lutIdx++)
    {
        lutLen = _strlen(pLut[lutIdx]);

        for (inOff = 0; inOff < inLen; inOff++)
        {
            if (!_strncmp(pLut[lutIdx], pInput + inOff, lutLen))
            {
                if (SEARCH_IDX == flag)
                {
                    return lutIdx;
                }
                else if (SEARCH_OFFSET == flag)
                {
                    return inOff;
                }
            }
        }
    }
    return 0;
}

static void createEvent( char *pInput, T_CORE_event *pEvent )
{
    uint8_t hIdx     = 0;
    uint8_t startIdx = 0;
    uint8_t startOff = 0;
    uint8_t endIdx   = 0;
    uint8_t endOff   = 0;

    char tmp[_LTEIOT2_CMD_MAXSIZE + 1] = { 0 };

//  SEARCH LUTS
    startIdx = searchLut(pInput, LUT_START_MARK, LUT_START_MARK_SIZE, SEARCH_IDX);
    startOff = searchLut(pInput, LUT_START_MARK, LUT_START_MARK_SIZE, SEARCH_OFFSET);
    endIdx = searchLut(pInput, LUT_END_MARK, LUT_END_MARK_SIZE, SEARCH_IDX);
    endOff = searchLut(pInput, LUT_END_MARK, LUT_END_MARK_SIZE, SEARCH_OFFSET);
    
    if (0 == endOff)
    {
        endOff = _LTEIOT2_CMD_MAXSIZE;
    }

//  SEARCH STORAGE
    _strncpy(tmp, pInput + startOff, endOff - startOff);
    hIdx                         = locateHandler(tmp);
    pEvent->fpHdl                = hdlBuff.storage[hIdx].handler;
    pEvent->wDogLimit            = hdlBuff.storage[hIdx].timeout;
    pEvent->evArg[_LTEIOT2_EVARG_START_T]  = startIdx;
    pEvent->evArg[_LTEIOT2_EVARG_END_T]    = endIdx;
}

/* --------------------------------------------------------- PUBLIC FUNCTIONS */

void lteiot2_uartDriverInit(T_LTEIOT2_P gpioObj, T_LTEIOT2_P uartObj)
{
    hal_uartMap( (T_HAL_P)uartObj );
    hal_gpioMap( (T_HAL_P)gpioObj );
}

/* ----------------------------------------------------------- IMPLEMENTATION */


void lteiot2_coreInit(T_lteiot2_handler defaultHdl, uint32_t defaultWdog)
{
    f_sequence_active          = false;
    f_buffer_warning           = false;
    f_response_ready           = false;
    f_wdog_timeout             = false;

//  HANDLER STORAGE INIT - 0 POSITION = DEFAULT HANDLER
    hdlBuff.storage[0].handler = defaultHdl;
    hdlBuff.storage[0].timeout = defaultWdog;
    hdlBuff.storage[0].hash    = generateHash("");
    hdlBuff.storage[0].len     = 0;
    hdlBuff.idx                = 1;

//  CORE INTIALIZATION
    CORE_CLEAN_RX();
    CORE_BLOCK();
    CORE_UNBLOCK();
    WATCHDOG_START();
    WATCHDOG_STOP();
    TIMER_START();
    TIMER_STOP();
    CORE_SET_FREE();
}

void lteiot2_hfcEnable( bool hfcState )
{
    f_hfc_active = hfcState;
}

void lteiot2_putc( uint8_t rxInput )
{
    CORE_BLOCK();
    TIMER_START();
    rxBuff.storage[rxBuff.idx++] = rxInput;

    if (_LTEIOT2_BUF_WARNING <= rxBuff.idx)
    {
        f_buffer_warning = true;
    }

    if((_LTEIOT2_BUF_SIZE - 1) == rxBuff.idx)
    {
        rxBuff.idx--;
    }
}

void lteiot2_tick()
{
    if (f_watchdog_active)
    {
        if (c_watchdog_timer++ > currentEv.wDogLimit)
        {
            f_watchdog_active = false;
            c_watchdog_timer = 0;
            rxBuff.storage[rxBuff.idx] = 0;
            f_wdog_timeout = true;
        }
    }
    if (f_timer_active)
    {
        if (c_timer++ > _LTEIOT2_TIMER_LIMIT)
        {
            f_timer_active = false;
            c_timer = 0;
            rxBuff.storage[rxBuff.idx] = 0;
            f_response_ready = true;
        }
    }
}

uint16_t lteiot2_setHandler( uint8_t *pCmd, uint32_t timeout, T_lteiot2_handler pHandler )
{
//  SANITY CHECK
    if (_LTEIOT2_CMD_MAXSIZE < _strlen(pCmd))
    {
        return 0;
    }
    if (_LTEIOT2_STORAGE_SIZE <= hdlBuff.idx)
    {
        return 0;
    }
    if (locateHandler(pCmd))
    {
        return 0;
    }

//  STORE NEW HANDLER
    if (0 == pHandler)
    {
        hdlBuff.storage[hdlBuff.idx].handler = hdlBuff.storage[0].handler;
    }
    else
    {
        hdlBuff.storage[hdlBuff.idx].handler = pHandler;   
    }
    if (0 == timeout)
    {
        hdlBuff.storage[hdlBuff.idx].timeout = hdlBuff.storage[0].timeout;
    }
    else
    {
        hdlBuff.storage[hdlBuff.idx].timeout = timeout;   
    }

    hdlBuff.storage[hdlBuff.idx].len  = _strlen(pCmd);
    hdlBuff.storage[hdlBuff.idx].hash = generateHash(pCmd);
    hdlBuff.idx++;

    return (_LTEIOT2_STORAGE_SIZE - rxBuff.idx);
}

void lteiot2_cmdSingle( uint8_t *pCmd )
{
    _strcpy( txBuff, pCmd );

    CORE_SEQUENCE();
    createEvent(pCmd, &currentEv);

    transmitCommand(pCmd, TERMINATION_CHAR);
    EXEC_CALLBACK();

    CORE_BLOCK();
    WATCHDOG_START();
    CORE_SEQUENCE();
}

void lteiot2_cmdDouble( uint8_t *pCmd, uint8_t *pCmdArg1 )
{
    _strcpy( txBuff, pCmd );
    _strcat( txBuff, pCmdArg1 );

    CORE_SEQUENCE();
    createEvent(pCmd, &currentEv);

    transmitCommand(pCmd, TERMINATION_CHAR);

    CORE_BLOCK();
    WATCHDOG_START();
    CORE_SEQUENCE();

    transmitCommand(pCmdArg1, TERMINATION_CHAR_ADD);
    EXEC_CALLBACK();

    CORE_BLOCK();
    WATCHDOG_START();
    CORE_SEQUENCE();
}

void lteiot2_cmdTriple( uint8_t *pCmd, uint8_t *pCmdArg1, uint8_t *pCmdArg2 )
{
    _strcpy( txBuff, pCmd );
    _strcat( txBuff, pCmdArg1 );
    _strcat( txBuff, pCmdArg2 );

    CORE_SEQUENCE();
    createEvent(pCmd, &currentEv);

    transmitCommand(pCmd, TERMINATION_CHAR );

    CORE_BLOCK();
    WATCHDOG_START();
    CORE_SEQUENCE();

    transmitCommand(pCmdArg1, TERMINATION_CHAR_ADD);

    CORE_BLOCK();
    WATCHDOG_START();
    CORE_SEQUENCE();

    transmitCommand(pCmdArg2, TERMINATION_CHAR_ADD);
    EXEC_CALLBACK();

    CORE_BLOCK();
    WATCHDOG_START();
    CORE_SEQUENCE();
}

void lteiot2_process()
{
//  POLL SEQUENCE
    if (0 != _LTEIOT2_POLL_ENABLE)
    {
        if (0 != hal_uartReady())
        {
            char tmp = hal_uartRead();
            lteiot2_putc( tmp );
        }
    }

//  BUFFER WARNING STATE
    if (f_buffer_warning)
    {
        CORE_SET_BUSY();
        TIMER_STOP();
        WATCHDOG_STOP();

//  CHECK FOR PREVIOUS WARNING STATE
        if (_LTEIOT2_EVENT_BUFFER_OUT == currentEv.evArg[_LTEIOT2_EVARG_EVENT_T])
        {
//  PREVIUOS WARNING STATE DETECTED = CONTINUOUS MESSAGE
            currentEv.fpHdl(rxBuff.storage, currentEv.evArg);
        }
        else
        {
//  SET WARNING STATE AS LAST OCCURED END EXECUTE HANDLER
            createEvent(rxBuff.storage, &currentEv);
            EXEC_EVENT(_LTEIOT2_EVENT_BUFFER_OUT);
        }
        f_buffer_warning = false;

        CORE_CLEAN_RX();
        CORE_UNBLOCK();
        CORE_SET_FREE();
    }

//  RESPONSE READY STATE
    if (f_response_ready)
    {
        CORE_SET_BUSY();
        TIMER_STOP();
        WATCHDOG_STOP();

        createEvent(rxBuff.storage, &currentEv);
        EXEC_EVENT(_LTEIOT2_EVENT_RESPONSE);

        CORE_CLEAN_RX();
        CORE_UNBLOCK();
        CORE_SET_FREE();
    }

//  WATCHDOG TIMEOUT STATE
    if (f_wdog_timeout)
    {
        CORE_SET_BUSY();
        TIMER_STOP();
        WATCHDOG_STOP();

        createEvent(rxBuff.storage, &currentEv);
        EXEC_EVENT(_LTEIOT2_EVENT_TIMEOUT);

        CORE_CLEAN_RX();
        CORE_UNBLOCK();
        CORE_SET_FREE();
    }
}

/* -------------------------------------------------------------------------- */
/*
  __lteiot2_driver.c

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