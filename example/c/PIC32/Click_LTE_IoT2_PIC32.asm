Click_LTE_IoT2_PIC32_lteiot2_configTimer:
;click_lte_iot2_timer.h,14 :: 		static void lteiot2_configTimer()
;click_lte_iot2_timer.h,16 :: 		T1CON      = 0x8010;
ORI	R2, R0, 32784
SW	R2, Offset(T1CON+0)(GP)
;click_lte_iot2_timer.h,17 :: 		T1IP0_bit  = 1;
LUI	R2, BitMask(T1IP0_bit+0)
ORI	R2, R2, BitMask(T1IP0_bit+0)
_SX	
;click_lte_iot2_timer.h,18 :: 		T1IP1_bit  = 1;
LUI	R2, BitMask(T1IP1_bit+0)
ORI	R2, R2, BitMask(T1IP1_bit+0)
_SX	
;click_lte_iot2_timer.h,19 :: 		T1IP2_bit  = 1;
LUI	R2, BitMask(T1IP2_bit+0)
ORI	R2, R2, BitMask(T1IP2_bit+0)
_SX	
;click_lte_iot2_timer.h,20 :: 		T1IF_bit   = 0;
LUI	R2, BitMask(T1IF_bit+0)
ORI	R2, R2, BitMask(T1IF_bit+0)
_SX	
;click_lte_iot2_timer.h,21 :: 		T1IE_bit   = 1;
LUI	R2, BitMask(T1IE_bit+0)
ORI	R2, R2, BitMask(T1IE_bit+0)
_SX	
;click_lte_iot2_timer.h,22 :: 		PR1        = 10000;
ORI	R2, R0, 10000
SW	R2, Offset(PR1+0)(GP)
;click_lte_iot2_timer.h,23 :: 		TMR1       = 0;
SW	R0, Offset(TMR1+0)(GP)
;click_lte_iot2_timer.h,24 :: 		EnableInterrupts();
EI	R30
;click_lte_iot2_timer.h,25 :: 		}
L_end_lteiot2_configTimer:
JR	RA
NOP	
; end of Click_LTE_IoT2_PIC32_lteiot2_configTimer
_Timer_interrupt:
;click_lte_iot2_timer.h,27 :: 		void Timer_interrupt() iv IVT_TIMER_1 ilevel 7 ics ICS_SRS
RDPGPR	SP, SP
ADDIU	SP, SP, -12
MFC0	R30, 12, 2
SW	R30, 8(SP)
MFC0	R30, 14, 0
SW	R30, 4(SP)
MFC0	R30, 12, 0
SW	R30, 0(SP)
INS	R30, R0, 1, 15
ORI	R30, R0, 7168
MTC0	R30, 12, 0
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;click_lte_iot2_timer.h,29 :: 		lteiot2_tick();
JAL	_lteiot2_tick+0
NOP	
;click_lte_iot2_timer.h,30 :: 		T1IF_bit     = 0;
LUI	R2, BitMask(T1IF_bit+0)
ORI	R2, R2, BitMask(T1IF_bit+0)
_SX	
;click_lte_iot2_timer.h,31 :: 		}
L_end_Timer_interrupt:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
DI	
EHB	
LW	R30, 8(SP)
MTC0	R30, 12, 2
LW	R30, 4(SP)
MTC0	R30, 14, 0
LW	R30, 0(SP)
MTC0	R30, 12, 0
ADDIU	SP, SP, 12
WRPGPR	SP, SP
ERET	
; end of _Timer_interrupt
_lteiot2_default_handler:
;Click_LTE_IoT2_PIC32.c,50 :: 		void lteiot2_default_handler( uint8_t *rsp, uint8_t *evArgs )
ADDIU	SP, SP, -8
SW	RA, 0(SP)
;Click_LTE_IoT2_PIC32.c,52 :: 		mikrobus_logWrite( rsp, _LOG_TEXT );
SW	R26, 4(SP)
ORI	R26, R0, 1
JAL	_mikrobus_logWrite+0
NOP	
;Click_LTE_IoT2_PIC32.c,53 :: 		}
L_end_lteiot2_default_handler:
LW	R26, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 8
JR	RA
NOP	
; end of _lteiot2_default_handler
_systemInit:
;Click_LTE_IoT2_PIC32.c,55 :: 		void systemInit()
ADDIU	SP, SP, -16
SW	RA, 0(SP)
;Click_LTE_IoT2_PIC32.c,57 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_AN_PIN, _GPIO_INPUT );
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
ORI	R27, R0, 1
MOVZ	R26, R0, R0
MOVZ	R25, R0, R0
JAL	_mikrobus_gpioInit+0
NOP	
;Click_LTE_IoT2_PIC32.c,58 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_PWM_PIN, _GPIO_INPUT );
ORI	R27, R0, 1
ORI	R26, R0, 6
MOVZ	R25, R0, R0
JAL	_mikrobus_gpioInit+0
NOP	
;Click_LTE_IoT2_PIC32.c,59 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_INT_PIN, _GPIO_INPUT );
ORI	R27, R0, 1
ORI	R26, R0, 7
MOVZ	R25, R0, R0
JAL	_mikrobus_gpioInit+0
NOP	
;Click_LTE_IoT2_PIC32.c,60 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_RST_PIN, _GPIO_OUTPUT );
MOVZ	R27, R0, R0
ORI	R26, R0, 1
MOVZ	R25, R0, R0
JAL	_mikrobus_gpioInit+0
NOP	
;Click_LTE_IoT2_PIC32.c,61 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_CS_PIN, _GPIO_OUTPUT );
MOVZ	R27, R0, R0
ORI	R26, R0, 2
MOVZ	R25, R0, R0
JAL	_mikrobus_gpioInit+0
NOP	
;Click_LTE_IoT2_PIC32.c,62 :: 		mikrobus_uartInit( _MIKROBUS1, &_LTEIOT2_UART_CFG[0] );
LUI	R2, hi_addr(__LTEIOT2_UART_CFG+0)
ORI	R2, R2, lo_addr(__LTEIOT2_UART_CFG+0)
MOVZ	R26, R2, R0
MOVZ	R25, R0, R0
JAL	_mikrobus_uartInit+0
NOP	
;Click_LTE_IoT2_PIC32.c,63 :: 		mikrobus_logInit( _LOG_USBUART_B, 115200 );
LUI	R26, 1
ORI	R26, R26, 49664
ORI	R25, R0, 48
JAL	_mikrobus_logInit+0
NOP	
;Click_LTE_IoT2_PIC32.c,64 :: 		mikrobus_logWrite(" --- System init --- ", _LOG_LINE );
ORI	R26, R0, 2
LUI	R25, hi_addr(?lstr1_Click_LTE_IoT2_PIC32+0)
ORI	R25, R25, lo_addr(?lstr1_Click_LTE_IoT2_PIC32+0)
JAL	_mikrobus_logWrite+0
NOP	
;Click_LTE_IoT2_PIC32.c,65 :: 		}
L_end_systemInit:
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 16
JR	RA
NOP	
; end of _systemInit
_applicationInit:
;Click_LTE_IoT2_PIC32.c,67 :: 		void applicationInit()
ADDIU	SP, SP, -12
SW	RA, 0(SP)
;Click_LTE_IoT2_PIC32.c,70 :: 		lteiot2_configTimer();
SW	R25, 4(SP)
SW	R26, 8(SP)
JAL	Click_LTE_IoT2_PIC32_lteiot2_configTimer+0
NOP	
;Click_LTE_IoT2_PIC32.c,73 :: 		lteiot2_uartDriverInit((T_LTEIOT2_P)&_MIKROBUS1_GPIO, (T_LTEIOT2_P)&_MIKROBUS1_UART);
LUI	R26, hi_addr(__MIKROBUS1_UART+0)
ORI	R26, R26, lo_addr(__MIKROBUS1_UART+0)
LUI	R25, hi_addr(__MIKROBUS1_GPIO+0)
ORI	R25, R25, lo_addr(__MIKROBUS1_GPIO+0)
JAL	_lteiot2_uartDriverInit+0
NOP	
;Click_LTE_IoT2_PIC32.c,74 :: 		lteiot2_coreInit( lteiot2_default_handler, 1500 );
ORI	R26, R0, 1500
LUI	R25, hi_addr(_lteiot2_default_handler+0)
ORI	R25, R25, lo_addr(_lteiot2_default_handler+0)
JAL	_lteiot2_coreInit+0
NOP	
;Click_LTE_IoT2_PIC32.c,77 :: 		lteiot2_hfcEnable( true );
ORI	R25, R0, 1
JAL	_lteiot2_hfcEnable+0
NOP	
;Click_LTE_IoT2_PIC32.c,82 :: 		lteiot2_cmdSingle( &ATI[0] );
LUI	R25, hi_addr(_ATI+0)
ORI	R25, R25, lo_addr(_ATI+0)
JAL	_lteiot2_cmdSingle+0
NOP	
;Click_LTE_IoT2_PIC32.c,83 :: 		Delay_1sec();
JAL	_Delay_1sec+0
NOP	
;Click_LTE_IoT2_PIC32.c,85 :: 		lteiot2_cmdSingle( &AT_IPR[0] );
LUI	R25, hi_addr(_AT_IPR+0)
ORI	R25, R25, lo_addr(_AT_IPR+0)
JAL	_lteiot2_cmdSingle+0
NOP	
;Click_LTE_IoT2_PIC32.c,86 :: 		Delay_1sec();
JAL	_Delay_1sec+0
NOP	
;Click_LTE_IoT2_PIC32.c,88 :: 		lteiot2_cmdSingle( &AT_QCFG_1[0] );
LUI	R25, hi_addr(_AT_QCFG_1+0)
ORI	R25, R25, lo_addr(_AT_QCFG_1+0)
JAL	_lteiot2_cmdSingle+0
NOP	
;Click_LTE_IoT2_PIC32.c,89 :: 		Delay_1sec();
JAL	_Delay_1sec+0
NOP	
;Click_LTE_IoT2_PIC32.c,91 :: 		lteiot2_cmdSingle( &AT_QCFG_2[0] );
LUI	R25, hi_addr(_AT_QCFG_2+0)
ORI	R25, R25, lo_addr(_AT_QCFG_2+0)
JAL	_lteiot2_cmdSingle+0
NOP	
;Click_LTE_IoT2_PIC32.c,92 :: 		Delay_1sec();
JAL	_Delay_1sec+0
NOP	
;Click_LTE_IoT2_PIC32.c,94 :: 		lteiot2_cmdSingle( &AT_QCFG_3[0] );
LUI	R25, hi_addr(_AT_QCFG_3+0)
ORI	R25, R25, lo_addr(_AT_QCFG_3+0)
JAL	_lteiot2_cmdSingle+0
NOP	
;Click_LTE_IoT2_PIC32.c,95 :: 		Delay_1sec();
JAL	_Delay_1sec+0
NOP	
;Click_LTE_IoT2_PIC32.c,97 :: 		lteiot2_cmdSingle( &AT_QCFG_4[0] );
LUI	R25, hi_addr(_AT_QCFG_4+0)
ORI	R25, R25, lo_addr(_AT_QCFG_4+0)
JAL	_lteiot2_cmdSingle+0
NOP	
;Click_LTE_IoT2_PIC32.c,98 :: 		Delay_1sec();
JAL	_Delay_1sec+0
NOP	
;Click_LTE_IoT2_PIC32.c,100 :: 		lteiot2_cmdSingle( &AT_QCFG_5[0] );
LUI	R25, hi_addr(_AT_QCFG_5+0)
ORI	R25, R25, lo_addr(_AT_QCFG_5+0)
JAL	_lteiot2_cmdSingle+0
NOP	
;Click_LTE_IoT2_PIC32.c,101 :: 		Delay_1sec();
JAL	_Delay_1sec+0
NOP	
;Click_LTE_IoT2_PIC32.c,103 :: 		lteiot2_cmdSingle( &AT_QCFG_6[0] );
LUI	R25, hi_addr(_AT_QCFG_6+0)
ORI	R25, R25, lo_addr(_AT_QCFG_6+0)
JAL	_lteiot2_cmdSingle+0
NOP	
;Click_LTE_IoT2_PIC32.c,104 :: 		Delay_1sec();
JAL	_Delay_1sec+0
NOP	
;Click_LTE_IoT2_PIC32.c,106 :: 		lteiot2_cmdSingle( &AT_CGDCONT[0] );
LUI	R25, hi_addr(_AT_CGDCONT+0)
ORI	R25, R25, lo_addr(_AT_CGDCONT+0)
JAL	_lteiot2_cmdSingle+0
NOP	
;Click_LTE_IoT2_PIC32.c,107 :: 		Delay_1sec();
JAL	_Delay_1sec+0
NOP	
;Click_LTE_IoT2_PIC32.c,109 :: 		lteiot2_cmdSingle( &AT_CFUN[0] );
LUI	R25, hi_addr(_AT_CFUN+0)
ORI	R25, R25, lo_addr(_AT_CFUN+0)
JAL	_lteiot2_cmdSingle+0
NOP	
;Click_LTE_IoT2_PIC32.c,110 :: 		Delay_1sec();
JAL	_Delay_1sec+0
NOP	
;Click_LTE_IoT2_PIC32.c,112 :: 		lteiot2_cmdSingle( &AT_COPS[0] );
LUI	R25, hi_addr(_AT_COPS+0)
ORI	R25, R25, lo_addr(_AT_COPS+0)
JAL	_lteiot2_cmdSingle+0
NOP	
;Click_LTE_IoT2_PIC32.c,113 :: 		Delay_1sec();
JAL	_Delay_1sec+0
NOP	
;Click_LTE_IoT2_PIC32.c,114 :: 		lteiot2_cmdSingle( &AT_CGATT[0] );
LUI	R25, hi_addr(_AT_CGATT+0)
ORI	R25, R25, lo_addr(_AT_CGATT+0)
JAL	_lteiot2_cmdSingle+0
NOP	
;Click_LTE_IoT2_PIC32.c,115 :: 		Delay_1sec();
JAL	_Delay_1sec+0
NOP	
;Click_LTE_IoT2_PIC32.c,116 :: 		lteiot2_cmdSingle( &AT_CEREG[0] );
LUI	R25, hi_addr(_AT_CEREG+0)
ORI	R25, R25, lo_addr(_AT_CEREG+0)
JAL	_lteiot2_cmdSingle+0
NOP	
;Click_LTE_IoT2_PIC32.c,117 :: 		Delay_1sec();
JAL	_Delay_1sec+0
NOP	
;Click_LTE_IoT2_PIC32.c,119 :: 		lteiot2_cmdSingle( &AT_QIACT[0] );
LUI	R25, hi_addr(_AT_QIACT+0)
ORI	R25, R25, lo_addr(_AT_QIACT+0)
JAL	_lteiot2_cmdSingle+0
NOP	
;Click_LTE_IoT2_PIC32.c,120 :: 		Delay_1sec();
JAL	_Delay_1sec+0
NOP	
;Click_LTE_IoT2_PIC32.c,122 :: 		lteiot2_cmdSingle( &AT_QIOPEN[0] );
LUI	R25, hi_addr(_AT_QIOPEN+0)
ORI	R25, R25, lo_addr(_AT_QIOPEN+0)
JAL	_lteiot2_cmdSingle+0
NOP	
;Click_LTE_IoT2_PIC32.c,123 :: 		Delay_1sec();
JAL	_Delay_1sec+0
NOP	
;Click_LTE_IoT2_PIC32.c,125 :: 		lteiot2_cmdSingle( &AT_QISENDEX[0] );
LUI	R25, hi_addr(_AT_QISENDEX+0)
ORI	R25, R25, lo_addr(_AT_QISENDEX+0)
JAL	_lteiot2_cmdSingle+0
NOP	
;Click_LTE_IoT2_PIC32.c,126 :: 		Delay_1sec();
JAL	_Delay_1sec+0
NOP	
;Click_LTE_IoT2_PIC32.c,127 :: 		}
L_end_applicationInit:
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 12
JR	RA
NOP	
; end of _applicationInit
_applicationTask:
;Click_LTE_IoT2_PIC32.c,129 :: 		void applicationTask()
ADDIU	SP, SP, -8
SW	RA, 0(SP)
;Click_LTE_IoT2_PIC32.c,131 :: 		lteiot2_process();
SW	R25, 4(SP)
JAL	_lteiot2_process+0
NOP	
;Click_LTE_IoT2_PIC32.c,133 :: 		lteiot2_cmdSingle( "AT+QISENDEX=0,\"48656C6C6F\"" );
LUI	R25, hi_addr(?lstr2_Click_LTE_IoT2_PIC32+0)
ORI	R25, R25, lo_addr(?lstr2_Click_LTE_IoT2_PIC32+0)
JAL	_lteiot2_cmdSingle+0
NOP	
;Click_LTE_IoT2_PIC32.c,134 :: 		Delay_ms(5000);
LUI	R24, 2034
ORI	R24, R24, 33108
L_applicationTask0:
ADDIU	R24, R24, -1
BNE	R24, R0, L_applicationTask0
NOP	
NOP	
NOP	
;Click_LTE_IoT2_PIC32.c,135 :: 		}
L_end_applicationTask:
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 8
JR	RA
NOP	
; end of _applicationTask
_main:
;Click_LTE_IoT2_PIC32.c,137 :: 		void main()
;Click_LTE_IoT2_PIC32.c,139 :: 		systemInit();
JAL	_systemInit+0
NOP	
;Click_LTE_IoT2_PIC32.c,140 :: 		applicationInit();
JAL	_applicationInit+0
NOP	
;Click_LTE_IoT2_PIC32.c,142 :: 		while (1)
L_main2:
;Click_LTE_IoT2_PIC32.c,144 :: 		applicationTask();
JAL	_applicationTask+0
NOP	
;Click_LTE_IoT2_PIC32.c,145 :: 		}
J	L_main2
NOP	
;Click_LTE_IoT2_PIC32.c,146 :: 		}
L_end_main:
L__main_end_loop:
J	L__main_end_loop
NOP	
; end of _main
