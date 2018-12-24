
Click_LTE_IoT2_DSPIC_lteiot2_configTimer:

;click_lte_iot2_timer.h,15 :: 		static void lteiot2_configTimer()
;click_lte_iot2_timer.h,17 :: 		T1CON	 = 0x8000;
	MOV	#32768, W0
	MOV	WREG, T1CON
;click_lte_iot2_timer.h,18 :: 		T1IE_bit = 1;
	BSET	T1IE_bit, BitPos(T1IE_bit+0)
;click_lte_iot2_timer.h,19 :: 		T1IF_bit = 0;
	BCLR	T1IF_bit, BitPos(T1IF_bit+0)
;click_lte_iot2_timer.h,20 :: 		IPC0	 = IPC0 | 0x1000;
	MOV	#4096, W1
	MOV	#lo_addr(IPC0), W0
	IOR	W1, [W0], [W0]
;click_lte_iot2_timer.h,21 :: 		PR1		 = 4000;
	MOV	#4000, W0
	MOV	WREG, PR1
;click_lte_iot2_timer.h,22 :: 		}
L_end_lteiot2_configTimer:
	RETURN
; end of Click_LTE_IoT2_DSPIC_lteiot2_configTimer

_Timer_interrupt:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;click_lte_iot2_timer.h,24 :: 		void Timer_interrupt() iv IVT_ADDR_T1INTERRUPT
;click_lte_iot2_timer.h,26 :: 		T1IF_bit = 0;
	BCLR	T1IF_bit, BitPos(T1IF_bit+0)
;click_lte_iot2_timer.h,27 :: 		lteiot2_tick();
	CALL	_lteiot2_tick
;click_lte_iot2_timer.h,28 :: 		}
L_end_Timer_interrupt:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _Timer_interrupt

_lteiot2_default_handler:

;Click_LTE_IoT2_DSPIC.c,33 :: 		void lteiot2_default_handler( uint8_t *rsp, uint8_t *evArgs )
;Click_LTE_IoT2_DSPIC.c,35 :: 		mikrobus_logWrite( rsp, _LOG_TEXT );
	PUSH	W11
	MOV.B	#1, W11
	CALL	_mikrobus_logWrite
;Click_LTE_IoT2_DSPIC.c,36 :: 		}
L_end_lteiot2_default_handler:
	POP	W11
	RETURN
; end of _lteiot2_default_handler

_systemInit:

;Click_LTE_IoT2_DSPIC.c,38 :: 		void systemInit()
;Click_LTE_IoT2_DSPIC.c,40 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_AN_PIN, _GPIO_INPUT );
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV.B	#1, W12
	CLR	W11
	CLR	W10
	CALL	_mikrobus_gpioInit
;Click_LTE_IoT2_DSPIC.c,41 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_PWM_PIN, _GPIO_INPUT );
	MOV.B	#1, W12
	MOV.B	#6, W11
	CLR	W10
	CALL	_mikrobus_gpioInit
;Click_LTE_IoT2_DSPIC.c,42 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_INT_PIN, _GPIO_INPUT );
	MOV.B	#1, W12
	MOV.B	#7, W11
	CLR	W10
	CALL	_mikrobus_gpioInit
;Click_LTE_IoT2_DSPIC.c,43 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_RST_PIN, _GPIO_OUTPUT );
	CLR	W12
	MOV.B	#1, W11
	CLR	W10
	CALL	_mikrobus_gpioInit
;Click_LTE_IoT2_DSPIC.c,44 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_CS_PIN, _GPIO_OUTPUT );
	CLR	W12
	MOV.B	#2, W11
	CLR	W10
	CALL	_mikrobus_gpioInit
;Click_LTE_IoT2_DSPIC.c,45 :: 		mikrobus_uartInit( _MIKROBUS1, &_LTEIOT2_UART_CFG[0] );
	MOV	#lo_addr(__LTEIOT2_UART_CFG), W0
	MOV	W0, W11
	CLR	W10
	CALL	_mikrobus_uartInit
;Click_LTE_IoT2_DSPIC.c,46 :: 		mikrobus_logInit( _LOG_USBUART_B, 115200 );
	MOV	#49664, W11
	MOV	#1, W12
	MOV.B	#48, W10
	CALL	_mikrobus_logInit
;Click_LTE_IoT2_DSPIC.c,47 :: 		mikrobus_logWrite(" --- System init --- ", _LOG_LINE );
	MOV.B	#2, W11
	MOV	#lo_addr(?lstr1_Click_LTE_IoT2_DSPIC), W10
	CALL	_mikrobus_logWrite
;Click_LTE_IoT2_DSPIC.c,48 :: 		}
L_end_systemInit:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _systemInit

_applicationInit:

;Click_LTE_IoT2_DSPIC.c,50 :: 		void applicationInit()
;Click_LTE_IoT2_DSPIC.c,53 :: 		lteiot2_configTimer();
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CALL	Click_LTE_IoT2_DSPIC_lteiot2_configTimer
;Click_LTE_IoT2_DSPIC.c,56 :: 		lteiot2_uartDriverInit((T_LTEIOT2_P)&_MIKROBUS1_GPIO, (T_LTEIOT2_P)&_MIKROBUS1_UART);
	MOV	#lo_addr(__MIKROBUS1_UART), W11
	MOV	#lo_addr(__MIKROBUS1_GPIO), W10
	CALL	_lteiot2_uartDriverInit
;Click_LTE_IoT2_DSPIC.c,57 :: 		lteiot2_coreInit( lteiot2_default_handler, 1500 );
	MOV	#1500, W11
	MOV	#0, W12
	MOV	#lo_addr(_lteiot2_default_handler), W10
	CALL	_lteiot2_coreInit
;Click_LTE_IoT2_DSPIC.c,60 :: 		lteiot2_hfcEnable( true );
	MOV.B	#1, W10
	CALL	_lteiot2_hfcEnable
;Click_LTE_IoT2_DSPIC.c,61 :: 		lteiot2_modulePower( true );
	MOV.B	#1, W10
	CALL	_lteiot2_modulePower
;Click_LTE_IoT2_DSPIC.c,65 :: 		lteiot2_cmdSingle( "ATI" );
	MOV	#lo_addr(?lstr2_Click_LTE_IoT2_DSPIC), W10
	CALL	_lteiot2_cmdSingle
;Click_LTE_IoT2_DSPIC.c,66 :: 		Delay_1sec();
	CALL	_Delay_1sec
;Click_LTE_IoT2_DSPIC.c,68 :: 		lteiot2_cmdSingle( "AT+IPR=115200;&W" );
	MOV	#lo_addr(?lstr3_Click_LTE_IoT2_DSPIC), W10
	CALL	_lteiot2_cmdSingle
;Click_LTE_IoT2_DSPIC.c,69 :: 		Delay_1sec();
	CALL	_Delay_1sec
;Click_LTE_IoT2_DSPIC.c,71 :: 		lteiot2_cmdSingle( "AT+QCFG=\"nbsibscramble\",0" );
	MOV	#lo_addr(?lstr4_Click_LTE_IoT2_DSPIC), W10
	CALL	_lteiot2_cmdSingle
;Click_LTE_IoT2_DSPIC.c,72 :: 		Delay_1sec();
	CALL	_Delay_1sec
;Click_LTE_IoT2_DSPIC.c,74 :: 		lteiot2_cmdSingle( "AT+QCFG=\"band\",0,0,80,1" );
	MOV	#lo_addr(?lstr5_Click_LTE_IoT2_DSPIC), W10
	CALL	_lteiot2_cmdSingle
;Click_LTE_IoT2_DSPIC.c,75 :: 		Delay_1sec();
	CALL	_Delay_1sec
;Click_LTE_IoT2_DSPIC.c,77 :: 		lteiot2_cmdSingle( "AT+QCFG=\"nwscanmode\",3,1" );
	MOV	#lo_addr(?lstr6_Click_LTE_IoT2_DSPIC), W10
	CALL	_lteiot2_cmdSingle
;Click_LTE_IoT2_DSPIC.c,78 :: 		Delay_1sec();
	CALL	_Delay_1sec
;Click_LTE_IoT2_DSPIC.c,80 :: 		lteiot2_cmdSingle( "AT+QCFG=\"nwscanseq\",030201,1" );
	MOV	#lo_addr(?lstr7_Click_LTE_IoT2_DSPIC), W10
	CALL	_lteiot2_cmdSingle
;Click_LTE_IoT2_DSPIC.c,81 :: 		Delay_1sec();
	CALL	_Delay_1sec
;Click_LTE_IoT2_DSPIC.c,83 :: 		lteiot2_cmdSingle( "AT+QCFG=\"iotopmode\",1,1" );
	MOV	#lo_addr(?lstr8_Click_LTE_IoT2_DSPIC), W10
	CALL	_lteiot2_cmdSingle
;Click_LTE_IoT2_DSPIC.c,84 :: 		Delay_1sec();
	CALL	_Delay_1sec
;Click_LTE_IoT2_DSPIC.c,86 :: 		lteiot2_cmdSingle( "AT+QCFG=\"servicedomain\",1,1" );
	MOV	#lo_addr(?lstr9_Click_LTE_IoT2_DSPIC), W10
	CALL	_lteiot2_cmdSingle
;Click_LTE_IoT2_DSPIC.c,87 :: 		Delay_1sec();
	CALL	_Delay_1sec
;Click_LTE_IoT2_DSPIC.c,89 :: 		lteiot2_cmdSingle( "AT+CGDCONT=1,\"IP\",\"internet\"" );
	MOV	#lo_addr(?lstr10_Click_LTE_IoT2_DSPIC), W10
	CALL	_lteiot2_cmdSingle
;Click_LTE_IoT2_DSPIC.c,90 :: 		Delay_1sec();
	CALL	_Delay_1sec
;Click_LTE_IoT2_DSPIC.c,92 :: 		lteiot2_cmdSingle( "AT+CFUN=1" );
	MOV	#lo_addr(?lstr11_Click_LTE_IoT2_DSPIC), W10
	CALL	_lteiot2_cmdSingle
;Click_LTE_IoT2_DSPIC.c,93 :: 		Delay_1sec();
	CALL	_Delay_1sec
;Click_LTE_IoT2_DSPIC.c,95 :: 		lteiot2_cmdSingle( "AT+COPS=1,2,\"22001\",0" );
	MOV	#lo_addr(?lstr12_Click_LTE_IoT2_DSPIC), W10
	CALL	_lteiot2_cmdSingle
;Click_LTE_IoT2_DSPIC.c,96 :: 		Delay_1sec();
	CALL	_Delay_1sec
;Click_LTE_IoT2_DSPIC.c,97 :: 		lteiot2_cmdSingle( "AT+CGATT?" );
	MOV	#lo_addr(?lstr13_Click_LTE_IoT2_DSPIC), W10
	CALL	_lteiot2_cmdSingle
;Click_LTE_IoT2_DSPIC.c,98 :: 		Delay_1sec();
	CALL	_Delay_1sec
;Click_LTE_IoT2_DSPIC.c,99 :: 		lteiot2_cmdSingle( "AT+CEREG?" );
	MOV	#lo_addr(?lstr14_Click_LTE_IoT2_DSPIC), W10
	CALL	_lteiot2_cmdSingle
;Click_LTE_IoT2_DSPIC.c,100 :: 		Delay_1sec();
	CALL	_Delay_1sec
;Click_LTE_IoT2_DSPIC.c,102 :: 		lteiot2_cmdSingle( "AT+QIACT=1" );
	MOV	#lo_addr(?lstr15_Click_LTE_IoT2_DSPIC), W10
	CALL	_lteiot2_cmdSingle
;Click_LTE_IoT2_DSPIC.c,103 :: 		Delay_1sec();
	CALL	_Delay_1sec
;Click_LTE_IoT2_DSPIC.c,105 :: 		lteiot2_cmdSingle( "AT+QIOPEN=1,0,\"UDP\",\"79.114.83.116\",16666" );
	MOV	#lo_addr(?lstr16_Click_LTE_IoT2_DSPIC), W10
	CALL	_lteiot2_cmdSingle
;Click_LTE_IoT2_DSPIC.c,106 :: 		Delay_1sec();
	CALL	_Delay_1sec
;Click_LTE_IoT2_DSPIC.c,108 :: 		lteiot2_cmdSingle( "AT+QISENDEX=0,\"48656C6C6F\"" );
	MOV	#lo_addr(?lstr17_Click_LTE_IoT2_DSPIC), W10
	CALL	_lteiot2_cmdSingle
;Click_LTE_IoT2_DSPIC.c,109 :: 		Delay_1sec();
	CALL	_Delay_1sec
;Click_LTE_IoT2_DSPIC.c,110 :: 		}
L_end_applicationInit:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _applicationInit

_applicationTask:

;Click_LTE_IoT2_DSPIC.c,112 :: 		void applicationTask()
;Click_LTE_IoT2_DSPIC.c,114 :: 		lteiot2_process();
	PUSH	W10
	CALL	_lteiot2_process
;Click_LTE_IoT2_DSPIC.c,116 :: 		lteiot2_cmdSingle( "AT+QISENDEX=0,\"48656C6C6F\"" );
	MOV	#lo_addr(?lstr18_Click_LTE_IoT2_DSPIC), W10
	CALL	_lteiot2_cmdSingle
;Click_LTE_IoT2_DSPIC.c,117 :: 		Delay_ms(5000);
	MOV	#102, W8
	MOV	#47563, W7
L_applicationTask0:
	DEC	W7
	BRA NZ	L_applicationTask0
	DEC	W8
	BRA NZ	L_applicationTask0
	NOP
;Click_LTE_IoT2_DSPIC.c,118 :: 		}
L_end_applicationTask:
	POP	W10
	RETURN
; end of _applicationTask

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;Click_LTE_IoT2_DSPIC.c,120 :: 		void main()
;Click_LTE_IoT2_DSPIC.c,122 :: 		systemInit();
	CALL	_systemInit
;Click_LTE_IoT2_DSPIC.c,123 :: 		applicationInit();
	CALL	_applicationInit
;Click_LTE_IoT2_DSPIC.c,125 :: 		while (1)
L_main2:
;Click_LTE_IoT2_DSPIC.c,127 :: 		applicationTask();
	CALL	_applicationTask
;Click_LTE_IoT2_DSPIC.c,128 :: 		}
	GOTO	L_main2
;Click_LTE_IoT2_DSPIC.c,129 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
