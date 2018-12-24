Click_LTE_IoT2_STM_lteiot2_configTimer:
;click_lte_iot2_timer.h,15 :: 		static void lteiot2_configTimer()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;click_lte_iot2_timer.h,17 :: 		RCC_APB1ENR.TIM2EN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
_SX	[R0, ByteOffset(RCC_APB1ENR+0)]
;click_lte_iot2_timer.h,18 :: 		TIM2_CR1.CEN = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
_SX	[R0, ByteOffset(TIM2_CR1+0)]
;click_lte_iot2_timer.h,19 :: 		TIM2_PSC = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;click_lte_iot2_timer.h,20 :: 		TIM2_ARR = 35999;
MOVW	R1, #35999
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;click_lte_iot2_timer.h,21 :: 		NVIC_IntEnable(IVT_INT_TIM2);
MOVW	R0, #44
BL	_NVIC_IntEnable+0
;click_lte_iot2_timer.h,22 :: 		TIM2_DIER.UIE = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
_SX	[R0, ByteOffset(TIM2_DIER+0)]
;click_lte_iot2_timer.h,23 :: 		TIM2_CR1.CEN = 1;
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
_SX	[R0, ByteOffset(TIM2_CR1+0)]
;click_lte_iot2_timer.h,24 :: 		EnableInterrupts();
BL	_EnableInterrupts+0
;click_lte_iot2_timer.h,25 :: 		}
L_end_lteiot2_configTimer:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of Click_LTE_IoT2_STM_lteiot2_configTimer
_Timer_interrupt:
;click_lte_iot2_timer.h,27 :: 		void Timer_interrupt() iv IVT_INT_TIM2
SUB	SP, SP, #4
STR	LR, [SP, #0]
;click_lte_iot2_timer.h,29 :: 		lteiot2_tick();
BL	_lteiot2_tick+0
;click_lte_iot2_timer.h,30 :: 		TIM2_SR.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
_SX	[R0, ByteOffset(TIM2_SR+0)]
;click_lte_iot2_timer.h,31 :: 		}
L_end_Timer_interrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Timer_interrupt
_lteiot2_default_handler:
;Click_LTE_IoT2_STM.c,51 :: 		void lteiot2_default_handler( uint8_t *rsp, uint8_t *evArgs )
; rsp start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; rsp end address is: 0 (R0)
; rsp start address is: 0 (R0)
;Click_LTE_IoT2_STM.c,53 :: 		mikrobus_logWrite( rsp, _LOG_TEXT );
MOVS	R1, #1
; rsp end address is: 0 (R0)
BL	_mikrobus_logWrite+0
;Click_LTE_IoT2_STM.c,54 :: 		}
L_end_lteiot2_default_handler:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _lteiot2_default_handler
_systemInit:
;Click_LTE_IoT2_STM.c,56 :: 		void systemInit()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Click_LTE_IoT2_STM.c,58 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_AN_PIN, _GPIO_INPUT );
MOVS	R2, #1
MOVS	R1, #0
MOVS	R0, #0
BL	_mikrobus_gpioInit+0
;Click_LTE_IoT2_STM.c,59 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_PWM_PIN, _GPIO_INPUT );
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #0
BL	_mikrobus_gpioInit+0
;Click_LTE_IoT2_STM.c,60 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_INT_PIN, _GPIO_INPUT );
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #0
BL	_mikrobus_gpioInit+0
;Click_LTE_IoT2_STM.c,61 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_RST_PIN, _GPIO_OUTPUT );
MOVS	R2, #0
MOVS	R1, #1
MOVS	R0, #0
BL	_mikrobus_gpioInit+0
;Click_LTE_IoT2_STM.c,62 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_CS_PIN, _GPIO_OUTPUT );
MOVS	R2, #0
MOVS	R1, #2
MOVS	R0, #0
BL	_mikrobus_gpioInit+0
;Click_LTE_IoT2_STM.c,63 :: 		mikrobus_uartInit( _MIKROBUS1, &_LTEIOT2_UART_CFG[0] );
MOVW	R0, #lo_addr(__LTEIOT2_UART_CFG+0)
MOVT	R0, #hi_addr(__LTEIOT2_UART_CFG+0)
MOV	R1, R0
MOVS	R0, #0
BL	_mikrobus_uartInit+0
;Click_LTE_IoT2_STM.c,64 :: 		mikrobus_logInit( _LOG_USBUART_B, 115200 );
MOV	R1, #115200
MOVS	R0, #48
BL	_mikrobus_logInit+0
;Click_LTE_IoT2_STM.c,65 :: 		mikrobus_logWrite(" --- System init --- ", _LOG_LINE );
MOVW	R0, #lo_addr(?lstr1_Click_LTE_IoT2_STM+0)
MOVT	R0, #hi_addr(?lstr1_Click_LTE_IoT2_STM+0)
MOVS	R1, #2
BL	_mikrobus_logWrite+0
;Click_LTE_IoT2_STM.c,66 :: 		}
L_end_systemInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _systemInit
_applicationInit:
;Click_LTE_IoT2_STM.c,68 :: 		void applicationInit()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Click_LTE_IoT2_STM.c,71 :: 		lteiot2_configTimer();
BL	Click_LTE_IoT2_STM_lteiot2_configTimer+0
;Click_LTE_IoT2_STM.c,74 :: 		lteiot2_uartDriverInit((T_LTEIOT2_P)&_MIKROBUS1_GPIO, (T_LTEIOT2_P)&_MIKROBUS1_UART);
MOVW	R1, #lo_addr(__MIKROBUS1_UART+0)
MOVT	R1, #hi_addr(__MIKROBUS1_UART+0)
MOVW	R0, #lo_addr(__MIKROBUS1_GPIO+0)
MOVT	R0, #hi_addr(__MIKROBUS1_GPIO+0)
BL	_lteiot2_uartDriverInit+0
;Click_LTE_IoT2_STM.c,75 :: 		lteiot2_coreInit( lteiot2_default_handler, 1500 );
MOVW	R0, #lo_addr(_lteiot2_default_handler+0)
MOVT	R0, #hi_addr(_lteiot2_default_handler+0)
MOVW	R1, #1500
BL	_lteiot2_coreInit+0
;Click_LTE_IoT2_STM.c,78 :: 		lteiot2_hfcEnable( true );
MOVS	R0, #1
BL	_lteiot2_hfcEnable+0
;Click_LTE_IoT2_STM.c,79 :: 		lteiot2_modulePower( true );
MOVS	R0, #1
BL	_lteiot2_modulePower+0
;Click_LTE_IoT2_STM.c,83 :: 		lteiot2_cmdSingle( &ATI[0] );
MOVW	R0, #lo_addr(_ATI+0)
MOVT	R0, #hi_addr(_ATI+0)
BL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_STM.c,84 :: 		Delay_1sec();
BL	_Delay_1sec+0
;Click_LTE_IoT2_STM.c,86 :: 		lteiot2_cmdSingle( &AT_IPR[0] );
MOVW	R0, #lo_addr(_AT_IPR+0)
MOVT	R0, #hi_addr(_AT_IPR+0)
BL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_STM.c,87 :: 		Delay_1sec();
BL	_Delay_1sec+0
;Click_LTE_IoT2_STM.c,89 :: 		lteiot2_cmdSingle( &AT_QCFG_1[0] );
MOVW	R0, #lo_addr(_AT_QCFG_1+0)
MOVT	R0, #hi_addr(_AT_QCFG_1+0)
BL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_STM.c,90 :: 		Delay_1sec();
BL	_Delay_1sec+0
;Click_LTE_IoT2_STM.c,92 :: 		lteiot2_cmdSingle( &AT_QCFG_2[0] );
MOVW	R0, #lo_addr(_AT_QCFG_2+0)
MOVT	R0, #hi_addr(_AT_QCFG_2+0)
BL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_STM.c,93 :: 		Delay_1sec();
BL	_Delay_1sec+0
;Click_LTE_IoT2_STM.c,95 :: 		lteiot2_cmdSingle( &AT_QCFG_3[0] );
MOVW	R0, #lo_addr(_AT_QCFG_3+0)
MOVT	R0, #hi_addr(_AT_QCFG_3+0)
BL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_STM.c,96 :: 		Delay_1sec();
BL	_Delay_1sec+0
;Click_LTE_IoT2_STM.c,98 :: 		lteiot2_cmdSingle( &AT_QCFG_4[0] );
MOVW	R0, #lo_addr(_AT_QCFG_4+0)
MOVT	R0, #hi_addr(_AT_QCFG_4+0)
BL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_STM.c,99 :: 		Delay_1sec();
BL	_Delay_1sec+0
;Click_LTE_IoT2_STM.c,101 :: 		lteiot2_cmdSingle( &AT_QCFG_5[0] );
MOVW	R0, #lo_addr(_AT_QCFG_5+0)
MOVT	R0, #hi_addr(_AT_QCFG_5+0)
BL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_STM.c,102 :: 		Delay_1sec();
BL	_Delay_1sec+0
;Click_LTE_IoT2_STM.c,104 :: 		lteiot2_cmdSingle( &AT_QCFG_6[0] );
MOVW	R0, #lo_addr(_AT_QCFG_6+0)
MOVT	R0, #hi_addr(_AT_QCFG_6+0)
BL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_STM.c,105 :: 		Delay_1sec();
BL	_Delay_1sec+0
;Click_LTE_IoT2_STM.c,107 :: 		lteiot2_cmdSingle( &AT_CGDCONT[0] );
MOVW	R0, #lo_addr(_AT_CGDCONT+0)
MOVT	R0, #hi_addr(_AT_CGDCONT+0)
BL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_STM.c,108 :: 		Delay_1sec();
BL	_Delay_1sec+0
;Click_LTE_IoT2_STM.c,110 :: 		lteiot2_cmdSingle( &AT_CFUN[0] );
MOVW	R0, #lo_addr(_AT_CFUN+0)
MOVT	R0, #hi_addr(_AT_CFUN+0)
BL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_STM.c,111 :: 		Delay_1sec();
BL	_Delay_1sec+0
;Click_LTE_IoT2_STM.c,113 :: 		lteiot2_cmdSingle( &AT_COPS[0] );
MOVW	R0, #lo_addr(_AT_COPS+0)
MOVT	R0, #hi_addr(_AT_COPS+0)
BL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_STM.c,114 :: 		Delay_1sec();
BL	_Delay_1sec+0
;Click_LTE_IoT2_STM.c,115 :: 		lteiot2_cmdSingle( &AT_CGATT[0] );
MOVW	R0, #lo_addr(_AT_CGATT+0)
MOVT	R0, #hi_addr(_AT_CGATT+0)
BL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_STM.c,116 :: 		Delay_1sec();
BL	_Delay_1sec+0
;Click_LTE_IoT2_STM.c,117 :: 		lteiot2_cmdSingle( &AT_CEREG[0] );
MOVW	R0, #lo_addr(_AT_CEREG+0)
MOVT	R0, #hi_addr(_AT_CEREG+0)
BL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_STM.c,118 :: 		Delay_1sec();
BL	_Delay_1sec+0
;Click_LTE_IoT2_STM.c,120 :: 		lteiot2_cmdSingle( &AT_QIACT[0] );
MOVW	R0, #lo_addr(_AT_QIACT+0)
MOVT	R0, #hi_addr(_AT_QIACT+0)
BL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_STM.c,121 :: 		Delay_1sec();
BL	_Delay_1sec+0
;Click_LTE_IoT2_STM.c,123 :: 		lteiot2_cmdSingle( &AT_QIOPEN[0] );
MOVW	R0, #lo_addr(_AT_QIOPEN+0)
MOVT	R0, #hi_addr(_AT_QIOPEN+0)
BL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_STM.c,124 :: 		Delay_1sec();
BL	_Delay_1sec+0
;Click_LTE_IoT2_STM.c,126 :: 		lteiot2_cmdSingle( &AT_QISENDEX[0] );
MOVW	R0, #lo_addr(_AT_QISENDEX+0)
MOVT	R0, #hi_addr(_AT_QISENDEX+0)
BL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_STM.c,127 :: 		Delay_1sec();
BL	_Delay_1sec+0
;Click_LTE_IoT2_STM.c,128 :: 		}
L_end_applicationInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _applicationInit
_applicationTask:
;Click_LTE_IoT2_STM.c,130 :: 		void applicationTask()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Click_LTE_IoT2_STM.c,132 :: 		lteiot2_process();
BL	_lteiot2_process+0
;Click_LTE_IoT2_STM.c,134 :: 		lteiot2_cmdSingle( &AT_QISENDEX[0] );
MOVW	R0, #lo_addr(_AT_QISENDEX+0)
MOVT	R0, #hi_addr(_AT_QISENDEX+0)
BL	_lteiot2_cmdSingle+0
;Click_LTE_IoT2_STM.c,135 :: 		Delay_ms(5000);
MOVW	R7, #34559
MOVT	R7, #915
NOP
NOP
L_applicationTask0:
SUBS	R7, R7, #1
BNE	L_applicationTask0
NOP
NOP
NOP
;Click_LTE_IoT2_STM.c,136 :: 		}
L_end_applicationTask:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _applicationTask
_main:
;Click_LTE_IoT2_STM.c,138 :: 		void main()
;Click_LTE_IoT2_STM.c,140 :: 		systemInit();
BL	_systemInit+0
;Click_LTE_IoT2_STM.c,141 :: 		applicationInit();
BL	_applicationInit+0
;Click_LTE_IoT2_STM.c,143 :: 		while (1)
L_main2:
;Click_LTE_IoT2_STM.c,145 :: 		applicationTask();
BL	_applicationTask+0
;Click_LTE_IoT2_STM.c,146 :: 		}
IT	AL
BAL	L_main2
;Click_LTE_IoT2_STM.c,147 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
