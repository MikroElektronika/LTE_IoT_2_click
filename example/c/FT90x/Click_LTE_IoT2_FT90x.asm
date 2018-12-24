Click_LTE_IoT2_FT90x_lteiot2_configTimer:
;click_lte_iot2_timer.h,16 :: 		static void lteiot2_configTimer()
;click_lte_iot2_timer.h,18 :: 		TIMER_CONTROL_0 = 2;
LDK.L	R0, #2
STA.B	TIMER_CONTROL_0+0, R0
;click_lte_iot2_timer.h,19 :: 		TIMER_SELECT = 0;
LDK.L	R1, #0
STA.B	TIMER_SELECT+0, R1
;click_lte_iot2_timer.h,20 :: 		TIMER_PRESC_LS = 80;
LDK.L	R0, #80
STA.B	TIMER_PRESC_LS+0, R0
;click_lte_iot2_timer.h,21 :: 		TIMER_PRESC_MS = 195;
LDK.L	R0, #195
STA.B	TIMER_PRESC_MS+0, R0
;click_lte_iot2_timer.h,22 :: 		TIMER_WRITE_LS = 1;
LDK.L	R0, #1
STA.B	TIMER_WRITE_LS+0, R0
;click_lte_iot2_timer.h,23 :: 		TIMER_WRITE_MS = 0;
STA.B	TIMER_WRITE_MS+0, R1
;click_lte_iot2_timer.h,24 :: 		TIMER_CONTROL_3 = 0;
STA.B	TIMER_CONTROL_3+0, R1
;click_lte_iot2_timer.h,25 :: 		TIMER_CONTROL_4 |= 17;
LDA.B	R0, TIMER_CONTROL_4+0
OR.L	R0, R0, #17
STA.B	TIMER_CONTROL_4+0, R0
;click_lte_iot2_timer.h,26 :: 		TIMER_CONTROL_2 |= 16;
LDA.B	R0, TIMER_CONTROL_2+0
OR.L	R0, R0, #16
STA.B	TIMER_CONTROL_2+0, R0
;click_lte_iot2_timer.h,27 :: 		TIMER_INT |= 2;
LDA.B	R0, TIMER_INT+0
OR.L	R0, R0, #2
STA.B	TIMER_INT+0, R0
;click_lte_iot2_timer.h,28 :: 		TIMER_CONTROL_1 |= 1;
LDA.B	R0, TIMER_CONTROL_1+0
OR.L	R0, R0, #1
STA.B	TIMER_CONTROL_1+0, R0
;click_lte_iot2_timer.h,29 :: 		IRQ_CTRL &= ~((uint32_t)1 << GLOBAL_INTERRUPT_MASK );
LDA.L	R1, IRQ_CTRL+0
LDK.L	R0, #2147483647
LDL.L	R0, R0, #2147483647
AND.L	R0, R1, R0
STA.L	IRQ_CTRL+0, R0
;click_lte_iot2_timer.h,30 :: 		}
L_end_lteiot2_configTimer:
RETURN	
; end of Click_LTE_IoT2_FT90x_lteiot2_configTimer
_Timer_interrupt:
;click_lte_iot2_timer.h,32 :: 		void Timer_interrupt() iv IVT_TIMERS_IRQ
;click_lte_iot2_timer.h,34 :: 		if (TIMER_INT_A_bit)
LDA.x	R0, #AlignedAddress(TIMER_INT_A_bit+0)
BEXTU.L	R0, R0, #BitPos(TIMER_INT_A_bit+0)
CMP.L	R0, #0
JMPC	R30, Z, #1, L_Timer_interrupt0
;click_lte_iot2_timer.h,36 :: 		TIMER_INT = (TIMER_INT & 0xAA) | (1 << 0);
LDA.B	R0, TIMER_INT+0
AND.L	R0, R0, #170
BEXTU.L	R0, R0, #256
OR.L	R0, R0, #1
STA.B	TIMER_INT+0, R0
;click_lte_iot2_timer.h,37 :: 		}
L_Timer_interrupt0:
;click_lte_iot2_timer.h,38 :: 		lteiot2_tick();
CALL	_lteiot2_tick+0
;click_lte_iot2_timer.h,39 :: 		}
L_end_Timer_interrupt:
RETI	
; end of _Timer_interrupt
_lteiot2_default_handler:
;Click_LTE_IoT2_FT90x.c,33 :: 		void lteiot2_default_handler( uint8_t *rsp, uint8_t *evArgs )
; rsp start address is: 0 (R0)
; rsp end address is: 0 (R0)
; rsp start address is: 0 (R0)
;Click_LTE_IoT2_FT90x.c,35 :: 		mikrobus_logWrite( rsp, _LOG_TEXT );
LDK.L	R1, #1
; rsp end address is: 0 (R0)
CALL	_mikrobus_logWrite+0
;Click_LTE_IoT2_FT90x.c,36 :: 		}
L_end_lteiot2_default_handler:
RETURN	
; end of _lteiot2_default_handler
_systemInit:
;Click_LTE_IoT2_FT90x.c,38 :: 		void systemInit()
;Click_LTE_IoT2_FT90x.c,40 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_AN_PIN, _GPIO_INPUT );
LDK.L	R2, #1
LDK.L	R1, #0
LDK.L	R0, #0
CALL	_mikrobus_gpioInit+0
;Click_LTE_IoT2_FT90x.c,41 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_PWM_PIN, _GPIO_INPUT );
LDK.L	R2, #1
LDK.L	R1, #6
LDK.L	R0, #0
CALL	_mikrobus_gpioInit+0
;Click_LTE_IoT2_FT90x.c,42 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_INT_PIN, _GPIO_INPUT );
LDK.L	R2, #1
LDK.L	R1, #7
LDK.L	R0, #0
CALL	_mikrobus_gpioInit+0
;Click_LTE_IoT2_FT90x.c,43 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_RST_PIN, _GPIO_OUTPUT );
LDK.L	R2, #0
LDK.L	R1, #1
LDK.L	R0, #0
CALL	_mikrobus_gpioInit+0
;Click_LTE_IoT2_FT90x.c,44 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_CS_PIN, _GPIO_OUTPUT );
LDK.L	R2, #0
LDK.L	R1, #2
LDK.L	R0, #0
CALL	_mikrobus_gpioInit+0
;Click_LTE_IoT2_FT90x.c,45 :: 		mikrobus_uartInit( _MIKROBUS1, &_LTEIOT2_UART_CFG[0] );
LDK.L	R0, #__LTEIOT2_UART_CFG+0
MOVE.L	R1, R0
LDK.L	R0, #0
CALL	_mikrobus_uartInit+0
;Click_LTE_IoT2_FT90x.c,46 :: 		mikrobus_logInit( _LOG_USBUART, 115200 );
LDK.L	R1, #115200
LDK.L	R0, #16
CALL	_mikrobus_logInit+0
;Click_LTE_IoT2_FT90x.c,47 :: 		mikrobus_logWrite(" --- System init --- ", _LOG_LINE );
LDK.L	R0, #?lstr1_Click_LTE_IoT2_FT90x+0
LDK.L	R1, #2
CALL	_mikrobus_logWrite+0
;Click_LTE_IoT2_FT90x.c,48 :: 		}
L_end_systemInit:
RETURN	
; end of _systemInit
_applicationInit:
;Click_LTE_IoT2_FT90x.c,50 :: 		void applicationInit()
;Click_LTE_IoT2_FT90x.c,53 :: 		lteiot2_configTimer();
CALL	Click_LTE_IoT2_FT90x_lteiot2_configTimer+0
;Click_LTE_IoT2_FT90x.c,56 :: 		lteiot2_uartDriverInit((T_LTEIOT2_P)&_MIKROBUS1_GPIO, (T_LTEIOT2_P)&_MIKROBUS1_UART);
LDK.L	R1, #__MIKROBUS1_UART+0
LDK.L	R0, #__MIKROBUS1_GPIO+0
CALL	_lteiot2_uartDriverInit+0
;Click_LTE_IoT2_FT90x.c,57 :: 		lteiot2_coreInit( lteiot2_default_handler, 1500 );
LDK.L	R0, #_lteiot2_default_handler+0
LDK.L	R1, #1500
CALL	_lteiot2_coreInit+0
;Click_LTE_IoT2_FT90x.c,60 :: 		lteiot2_hfcEnable( true );
LDK.L	R0, #1
CALL	_lteiot2_hfcEnable+0
;Click_LTE_IoT2_FT90x.c,61 :: 		lteiot2_modulePower( true );
LDK.L	R0, #1
CALL	_lteiot2_modulePower+0
;Click_LTE_IoT2_FT90x.c,65 :: 		lteiot2_cmdSingle( "ATI" );
LDK.L	R0, #?lstr2_Click_LTE_IoT2_FT90x+0
CALL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_FT90x.c,66 :: 		Delay_1sec();
CALL	_Delay_1sec+0
;Click_LTE_IoT2_FT90x.c,68 :: 		lteiot2_cmdSingle( "AT+IPR=115200;&W" );
LDK.L	R0, #?lstr3_Click_LTE_IoT2_FT90x+0
CALL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_FT90x.c,69 :: 		Delay_1sec();
CALL	_Delay_1sec+0
;Click_LTE_IoT2_FT90x.c,71 :: 		lteiot2_cmdSingle( "AT+QCFG=\"nbsibscramble\",0" );
LDK.L	R0, #?lstr4_Click_LTE_IoT2_FT90x+0
CALL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_FT90x.c,72 :: 		Delay_1sec();
CALL	_Delay_1sec+0
;Click_LTE_IoT2_FT90x.c,74 :: 		lteiot2_cmdSingle( "AT+QCFG=\"band\",0,0,80,1" );
LDK.L	R0, #?lstr5_Click_LTE_IoT2_FT90x+0
CALL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_FT90x.c,75 :: 		Delay_1sec();
CALL	_Delay_1sec+0
;Click_LTE_IoT2_FT90x.c,77 :: 		lteiot2_cmdSingle( "AT+QCFG=\"nwscanmode\",3,1" );
LDK.L	R0, #?lstr6_Click_LTE_IoT2_FT90x+0
CALL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_FT90x.c,78 :: 		Delay_1sec();
CALL	_Delay_1sec+0
;Click_LTE_IoT2_FT90x.c,80 :: 		lteiot2_cmdSingle( "AT+QCFG=\"nwscanseq\",030201,1" );
LDK.L	R0, #?lstr7_Click_LTE_IoT2_FT90x+0
CALL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_FT90x.c,81 :: 		Delay_1sec();
CALL	_Delay_1sec+0
;Click_LTE_IoT2_FT90x.c,83 :: 		lteiot2_cmdSingle( "AT+QCFG=\"iotopmode\",1,1" );
LDK.L	R0, #?lstr8_Click_LTE_IoT2_FT90x+0
CALL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_FT90x.c,84 :: 		Delay_1sec();
CALL	_Delay_1sec+0
;Click_LTE_IoT2_FT90x.c,86 :: 		lteiot2_cmdSingle( "AT+QCFG=\"servicedomain\",1,1" );
LDK.L	R0, #?lstr9_Click_LTE_IoT2_FT90x+0
CALL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_FT90x.c,87 :: 		Delay_1sec();
CALL	_Delay_1sec+0
;Click_LTE_IoT2_FT90x.c,89 :: 		lteiot2_cmdSingle( "AT+CGDCONT=1,\"IP\",\"internet\"" );
LDK.L	R0, #?lstr10_Click_LTE_IoT2_FT90x+0
CALL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_FT90x.c,90 :: 		Delay_1sec();
CALL	_Delay_1sec+0
;Click_LTE_IoT2_FT90x.c,92 :: 		lteiot2_cmdSingle( "AT+CFUN=1" );
LDK.L	R0, #?lstr11_Click_LTE_IoT2_FT90x+0
CALL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_FT90x.c,93 :: 		Delay_1sec();
CALL	_Delay_1sec+0
;Click_LTE_IoT2_FT90x.c,95 :: 		lteiot2_cmdSingle( "AT+COPS=1,2,\"22001\",0" );
LDK.L	R0, #?lstr12_Click_LTE_IoT2_FT90x+0
CALL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_FT90x.c,96 :: 		Delay_1sec();
CALL	_Delay_1sec+0
;Click_LTE_IoT2_FT90x.c,97 :: 		lteiot2_cmdSingle( "AT+CGATT?" );
LDK.L	R0, #?lstr13_Click_LTE_IoT2_FT90x+0
CALL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_FT90x.c,98 :: 		Delay_1sec();
CALL	_Delay_1sec+0
;Click_LTE_IoT2_FT90x.c,99 :: 		lteiot2_cmdSingle( "AT+CEREG?" );
LDK.L	R0, #?lstr14_Click_LTE_IoT2_FT90x+0
CALL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_FT90x.c,100 :: 		Delay_1sec();
CALL	_Delay_1sec+0
;Click_LTE_IoT2_FT90x.c,102 :: 		lteiot2_cmdSingle( "AT+QIACT=1" );
LDK.L	R0, #?lstr15_Click_LTE_IoT2_FT90x+0
CALL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_FT90x.c,103 :: 		Delay_1sec();
CALL	_Delay_1sec+0
;Click_LTE_IoT2_FT90x.c,105 :: 		lteiot2_cmdSingle( "AT+QIOPEN=1,0,\"UDP\",\"79.114.83.116\",16666" );
LDK.L	R0, #?lstr16_Click_LTE_IoT2_FT90x+0
CALL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_FT90x.c,106 :: 		Delay_1sec();
CALL	_Delay_1sec+0
;Click_LTE_IoT2_FT90x.c,108 :: 		lteiot2_cmdSingle( "AT+QISENDEX=0,\"48656C6C6F\"" );
LDK.L	R0, #?lstr17_Click_LTE_IoT2_FT90x+0
CALL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_FT90x.c,109 :: 		Delay_1sec();
CALL	_Delay_1sec+0
;Click_LTE_IoT2_FT90x.c,110 :: 		}
L_end_applicationInit:
RETURN	
; end of _applicationInit
_applicationTask:
;Click_LTE_IoT2_FT90x.c,112 :: 		void applicationTask()
;Click_LTE_IoT2_FT90x.c,114 :: 		lteiot2_process();
CALL	_lteiot2_process+0
;Click_LTE_IoT2_FT90x.c,116 :: 		lteiot2_cmdSingle( "AT+QISENDEX=0,\"48656C6C6F\"" );
LDK.L	R0, #?lstr18_Click_LTE_IoT2_FT90x+0
CALL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_FT90x.c,117 :: 		Delay_ms(5000);
LPM.L	R28, #166666665
NOP	
L_applicationTask1:
SUB.L	R28, R28, #1
CMP.L	R28, #0
JMPC	R30, Z, #0, L_applicationTask1
JMP	$+8
	#166666665
;Click_LTE_IoT2_FT90x.c,118 :: 		}
L_end_applicationTask:
RETURN	
; end of _applicationTask
_main:
;Click_LTE_IoT2_FT90x.c,120 :: 		void main()
LDK.L	SP, #43605
;Click_LTE_IoT2_FT90x.c,122 :: 		systemInit();
CALL	_systemInit+0
;Click_LTE_IoT2_FT90x.c,123 :: 		applicationInit();
CALL	_applicationInit+0
;Click_LTE_IoT2_FT90x.c,125 :: 		while (1)
L_main3:
;Click_LTE_IoT2_FT90x.c,127 :: 		applicationTask();
CALL	_applicationTask+0
;Click_LTE_IoT2_FT90x.c,128 :: 		}
JMP	L_main3
;Click_LTE_IoT2_FT90x.c,129 :: 		}
L_end_main:
L__main_end_loop:
JMP	L__main_end_loop
; end of _main
