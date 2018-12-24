
Click_LTE_IoT2_PIC_lteiot2_configTimer:

;click_lte_iot2_timer.h,15 :: 		static void lteiot2_configTimer()
;click_lte_iot2_timer.h,17 :: 		T1CON         = 0x01;
	MOVLW       1
	MOVWF       T1CON+0 
;click_lte_iot2_timer.h,18 :: 		TMR1IF_bit         = 0;
	BCF         TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
;click_lte_iot2_timer.h,19 :: 		TMR1H         = 0xC1;
	MOVLW       193
	MOVWF       TMR1H+0 
;click_lte_iot2_timer.h,20 :: 		TMR1L         = 0x80;
	MOVLW       128
	MOVWF       TMR1L+0 
;click_lte_iot2_timer.h,21 :: 		TMR1IE_bit         = 1;
	BSF         TMR1IE_bit+0, BitPos(TMR1IE_bit+0) 
;click_lte_iot2_timer.h,22 :: 		INTCON         = 0xC0;
	MOVLW       192
	MOVWF       INTCON+0 
;click_lte_iot2_timer.h,23 :: 		}
L_end_lteiot2_configTimer:
	RETURN      0
; end of Click_LTE_IoT2_PIC_lteiot2_configTimer

_interrupt:

;click_lte_iot2_timer.h,25 :: 		void interrupt()
;click_lte_iot2_timer.h,27 :: 		if (TMR1IF_bit != 0)
	BTFSS       TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
	GOTO        L_interrupt0
;click_lte_iot2_timer.h,29 :: 		lteiot2_tick();
	CALL        _lteiot2_tick+0, 0
;click_lte_iot2_timer.h,30 :: 		TMR1IF_bit = 0;
	BCF         TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
;click_lte_iot2_timer.h,31 :: 		TMR1H = 0xC1;
	MOVLW       193
	MOVWF       TMR1H+0 
;click_lte_iot2_timer.h,32 :: 		TMR1L = 0x80;
	MOVLW       128
	MOVWF       TMR1L+0 
;click_lte_iot2_timer.h,33 :: 		}
L_interrupt0:
;click_lte_iot2_timer.h,34 :: 		}
L_end_interrupt:
L__interrupt6:
	RETFIE      1
; end of _interrupt

_lteiot2_default_handler:

;Click_LTE_IoT2_PIC.c,33 :: 		void lteiot2_default_handler( uint8_t *rsp, uint8_t *evArgs )
;Click_LTE_IoT2_PIC.c,35 :: 		mikrobus_logWrite( rsp, _LOG_TEXT );
	MOVF        FARG_lteiot2_default_handler_rsp+0, 0 
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVF        FARG_lteiot2_default_handler_rsp+1, 0 
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_LTE_IoT2_PIC.c,36 :: 		}
L_end_lteiot2_default_handler:
	RETURN      0
; end of _lteiot2_default_handler

_systemInit:

;Click_LTE_IoT2_PIC.c,38 :: 		void systemInit()
;Click_LTE_IoT2_PIC.c,40 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_AN_PIN, _GPIO_INPUT );
	CLRF        FARG_mikrobus_gpioInit_bus+0 
	CLRF        FARG_mikrobus_gpioInit_pin+0 
	MOVLW       1
	MOVWF       FARG_mikrobus_gpioInit_direction+0 
	CALL        _mikrobus_gpioInit+0, 0
;Click_LTE_IoT2_PIC.c,41 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_PWM_PIN, _GPIO_INPUT );
	CLRF        FARG_mikrobus_gpioInit_bus+0 
	MOVLW       6
	MOVWF       FARG_mikrobus_gpioInit_pin+0 
	MOVLW       1
	MOVWF       FARG_mikrobus_gpioInit_direction+0 
	CALL        _mikrobus_gpioInit+0, 0
;Click_LTE_IoT2_PIC.c,42 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_INT_PIN, _GPIO_INPUT );
	CLRF        FARG_mikrobus_gpioInit_bus+0 
	MOVLW       7
	MOVWF       FARG_mikrobus_gpioInit_pin+0 
	MOVLW       1
	MOVWF       FARG_mikrobus_gpioInit_direction+0 
	CALL        _mikrobus_gpioInit+0, 0
;Click_LTE_IoT2_PIC.c,43 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_RST_PIN, _GPIO_OUTPUT );
	CLRF        FARG_mikrobus_gpioInit_bus+0 
	MOVLW       1
	MOVWF       FARG_mikrobus_gpioInit_pin+0 
	CLRF        FARG_mikrobus_gpioInit_direction+0 
	CALL        _mikrobus_gpioInit+0, 0
;Click_LTE_IoT2_PIC.c,44 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_CS_PIN, _GPIO_OUTPUT );
	CLRF        FARG_mikrobus_gpioInit_bus+0 
	MOVLW       2
	MOVWF       FARG_mikrobus_gpioInit_pin+0 
	CLRF        FARG_mikrobus_gpioInit_direction+0 
	CALL        _mikrobus_gpioInit+0, 0
;Click_LTE_IoT2_PIC.c,45 :: 		mikrobus_uartInit( _MIKROBUS1, &_LTEIOT2_UART_CFG[0] );
	CLRF        FARG_mikrobus_uartInit_bus+0 
	MOVLW       __LTEIOT2_UART_CFG+0
	MOVWF       FARG_mikrobus_uartInit_cfg+0 
	MOVLW       hi_addr(__LTEIOT2_UART_CFG+0)
	MOVWF       FARG_mikrobus_uartInit_cfg+1 
	MOVLW       higher_addr(__LTEIOT2_UART_CFG+0)
	MOVWF       FARG_mikrobus_uartInit_cfg+2 
	CALL        _mikrobus_uartInit+0, 0
;Click_LTE_IoT2_PIC.c,46 :: 		mikrobus_logInit( _MIKROBUS3, 115200 );
	MOVLW       2
	MOVWF       FARG_mikrobus_logInit_port+0 
	MOVLW       0
	MOVWF       FARG_mikrobus_logInit_baud+0 
	MOVLW       194
	MOVWF       FARG_mikrobus_logInit_baud+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logInit_baud+2 
	MOVLW       0
	MOVWF       FARG_mikrobus_logInit_baud+3 
	CALL        _mikrobus_logInit+0, 0
;Click_LTE_IoT2_PIC.c,47 :: 		mikrobus_logWrite(" --- System init --- ", _LOG_LINE );
	MOVLW       ?lstr1_Click_LTE_IoT2_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr1_Click_LTE_IoT2_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_LTE_IoT2_PIC.c,48 :: 		}
L_end_systemInit:
	RETURN      0
; end of _systemInit

_applicationInit:

;Click_LTE_IoT2_PIC.c,50 :: 		void applicationInit()
;Click_LTE_IoT2_PIC.c,53 :: 		lteiot2_configTimer();
	CALL        Click_LTE_IoT2_PIC_lteiot2_configTimer+0, 0
;Click_LTE_IoT2_PIC.c,56 :: 		lteiot2_uartDriverInit((T_LTEIOT2_P)&_MIKROBUS1_GPIO, (T_LTEIOT2_P)&_MIKROBUS1_UART);
	MOVLW       __MIKROBUS1_GPIO+0
	MOVWF       FARG_lteiot2_uartDriverInit_gpioObj+0 
	MOVLW       hi_addr(__MIKROBUS1_GPIO+0)
	MOVWF       FARG_lteiot2_uartDriverInit_gpioObj+1 
	MOVLW       higher_addr(__MIKROBUS1_GPIO+0)
	MOVWF       FARG_lteiot2_uartDriverInit_gpioObj+2 
	MOVLW       __MIKROBUS1_UART+0
	MOVWF       FARG_lteiot2_uartDriverInit_uartObj+0 
	MOVLW       hi_addr(__MIKROBUS1_UART+0)
	MOVWF       FARG_lteiot2_uartDriverInit_uartObj+1 
	MOVLW       higher_addr(__MIKROBUS1_UART+0)
	MOVWF       FARG_lteiot2_uartDriverInit_uartObj+2 
	CALL        _lteiot2_uartDriverInit+0, 0
;Click_LTE_IoT2_PIC.c,57 :: 		lteiot2_coreInit( lteiot2_default_handler, 1500 );
	MOVLW       _lteiot2_default_handler+0
	MOVWF       FARG_lteiot2_coreInit_defaultHdl+0 
	MOVLW       hi_addr(_lteiot2_default_handler+0)
	MOVWF       FARG_lteiot2_coreInit_defaultHdl+1 
	MOVLW       FARG_lteiot2_default_handler_rsp+0
	MOVWF       FARG_lteiot2_coreInit_defaultHdl+2 
	MOVLW       hi_addr(FARG_lteiot2_default_handler_rsp+0)
	MOVWF       FARG_lteiot2_coreInit_defaultHdl+3 
	MOVLW       220
	MOVWF       FARG_lteiot2_coreInit_defaultWdog+0 
	MOVLW       5
	MOVWF       FARG_lteiot2_coreInit_defaultWdog+1 
	MOVLW       0
	MOVWF       FARG_lteiot2_coreInit_defaultWdog+2 
	MOVWF       FARG_lteiot2_coreInit_defaultWdog+3 
	CALL        _lteiot2_coreInit+0, 0
;Click_LTE_IoT2_PIC.c,60 :: 		lteiot2_hfcEnable( true );
	MOVLW       1
	MOVWF       FARG_lteiot2_hfcEnable_hfcState+0 
	CALL        _lteiot2_hfcEnable+0, 0
;Click_LTE_IoT2_PIC.c,61 :: 		lteiot2_modulePower( true );
	MOVLW       1
	MOVWF       FARG_lteiot2_modulePower_powerState+0 
	CALL        _lteiot2_modulePower+0, 0
;Click_LTE_IoT2_PIC.c,65 :: 		lteiot2_cmdSingle( "ATI" );
	MOVLW       ?lstr2_Click_LTE_IoT2_PIC+0
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+0 
	MOVLW       hi_addr(?lstr2_Click_LTE_IoT2_PIC+0)
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+1 
	CALL        _lteiot2_cmdSingle+0, 0
;Click_LTE_IoT2_PIC.c,66 :: 		Delay_1sec();
	CALL        _Delay_1sec+0, 0
;Click_LTE_IoT2_PIC.c,68 :: 		lteiot2_cmdSingle( "AT+IPR=115200;&W" );
	MOVLW       ?lstr3_Click_LTE_IoT2_PIC+0
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+0 
	MOVLW       hi_addr(?lstr3_Click_LTE_IoT2_PIC+0)
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+1 
	CALL        _lteiot2_cmdSingle+0, 0
;Click_LTE_IoT2_PIC.c,69 :: 		Delay_1sec();
	CALL        _Delay_1sec+0, 0
;Click_LTE_IoT2_PIC.c,71 :: 		lteiot2_cmdSingle( "AT+QCFG=\"nbsibscramble\",0" );
	MOVLW       ?lstr4_Click_LTE_IoT2_PIC+0
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+0 
	MOVLW       hi_addr(?lstr4_Click_LTE_IoT2_PIC+0)
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+1 
	CALL        _lteiot2_cmdSingle+0, 0
;Click_LTE_IoT2_PIC.c,72 :: 		Delay_1sec();
	CALL        _Delay_1sec+0, 0
;Click_LTE_IoT2_PIC.c,74 :: 		lteiot2_cmdSingle( "AT+QCFG=\"band\",0,0,80,1" );
	MOVLW       ?lstr5_Click_LTE_IoT2_PIC+0
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+0 
	MOVLW       hi_addr(?lstr5_Click_LTE_IoT2_PIC+0)
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+1 
	CALL        _lteiot2_cmdSingle+0, 0
;Click_LTE_IoT2_PIC.c,75 :: 		Delay_1sec();
	CALL        _Delay_1sec+0, 0
;Click_LTE_IoT2_PIC.c,77 :: 		lteiot2_cmdSingle( "AT+QCFG=\"nwscanmode\",3,1" );
	MOVLW       ?lstr6_Click_LTE_IoT2_PIC+0
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+0 
	MOVLW       hi_addr(?lstr6_Click_LTE_IoT2_PIC+0)
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+1 
	CALL        _lteiot2_cmdSingle+0, 0
;Click_LTE_IoT2_PIC.c,78 :: 		Delay_1sec();
	CALL        _Delay_1sec+0, 0
;Click_LTE_IoT2_PIC.c,80 :: 		lteiot2_cmdSingle( "AT+QCFG=\"nwscanseq\",030201,1" );
	MOVLW       ?lstr7_Click_LTE_IoT2_PIC+0
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+0 
	MOVLW       hi_addr(?lstr7_Click_LTE_IoT2_PIC+0)
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+1 
	CALL        _lteiot2_cmdSingle+0, 0
;Click_LTE_IoT2_PIC.c,81 :: 		Delay_1sec();
	CALL        _Delay_1sec+0, 0
;Click_LTE_IoT2_PIC.c,83 :: 		lteiot2_cmdSingle( "AT+QCFG=\"iotopmode\",1,1" );
	MOVLW       ?lstr8_Click_LTE_IoT2_PIC+0
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+0 
	MOVLW       hi_addr(?lstr8_Click_LTE_IoT2_PIC+0)
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+1 
	CALL        _lteiot2_cmdSingle+0, 0
;Click_LTE_IoT2_PIC.c,84 :: 		Delay_1sec();
	CALL        _Delay_1sec+0, 0
;Click_LTE_IoT2_PIC.c,86 :: 		lteiot2_cmdSingle( "AT+QCFG=\"servicedomain\",1,1" );
	MOVLW       ?lstr9_Click_LTE_IoT2_PIC+0
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+0 
	MOVLW       hi_addr(?lstr9_Click_LTE_IoT2_PIC+0)
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+1 
	CALL        _lteiot2_cmdSingle+0, 0
;Click_LTE_IoT2_PIC.c,87 :: 		Delay_1sec();
	CALL        _Delay_1sec+0, 0
;Click_LTE_IoT2_PIC.c,89 :: 		lteiot2_cmdSingle( "AT+CGDCONT=1,\"IP\",\"internet\"" );
	MOVLW       ?lstr10_Click_LTE_IoT2_PIC+0
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+0 
	MOVLW       hi_addr(?lstr10_Click_LTE_IoT2_PIC+0)
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+1 
	CALL        _lteiot2_cmdSingle+0, 0
;Click_LTE_IoT2_PIC.c,90 :: 		Delay_1sec();
	CALL        _Delay_1sec+0, 0
;Click_LTE_IoT2_PIC.c,92 :: 		lteiot2_cmdSingle( "AT+CFUN=1" );
	MOVLW       ?lstr11_Click_LTE_IoT2_PIC+0
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+0 
	MOVLW       hi_addr(?lstr11_Click_LTE_IoT2_PIC+0)
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+1 
	CALL        _lteiot2_cmdSingle+0, 0
;Click_LTE_IoT2_PIC.c,93 :: 		Delay_1sec();
	CALL        _Delay_1sec+0, 0
;Click_LTE_IoT2_PIC.c,95 :: 		lteiot2_cmdSingle( "AT+COPS=1,2,\"22001\",0" );
	MOVLW       ?lstr12_Click_LTE_IoT2_PIC+0
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+0 
	MOVLW       hi_addr(?lstr12_Click_LTE_IoT2_PIC+0)
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+1 
	CALL        _lteiot2_cmdSingle+0, 0
;Click_LTE_IoT2_PIC.c,96 :: 		Delay_1sec();
	CALL        _Delay_1sec+0, 0
;Click_LTE_IoT2_PIC.c,97 :: 		lteiot2_cmdSingle( "AT+CGATT?" );
	MOVLW       ?lstr13_Click_LTE_IoT2_PIC+0
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+0 
	MOVLW       hi_addr(?lstr13_Click_LTE_IoT2_PIC+0)
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+1 
	CALL        _lteiot2_cmdSingle+0, 0
;Click_LTE_IoT2_PIC.c,98 :: 		Delay_1sec();
	CALL        _Delay_1sec+0, 0
;Click_LTE_IoT2_PIC.c,99 :: 		lteiot2_cmdSingle( "AT+CEREG?" );
	MOVLW       ?lstr14_Click_LTE_IoT2_PIC+0
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+0 
	MOVLW       hi_addr(?lstr14_Click_LTE_IoT2_PIC+0)
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+1 
	CALL        _lteiot2_cmdSingle+0, 0
;Click_LTE_IoT2_PIC.c,100 :: 		Delay_1sec();
	CALL        _Delay_1sec+0, 0
;Click_LTE_IoT2_PIC.c,102 :: 		lteiot2_cmdSingle( "AT+QIACT=1" );
	MOVLW       ?lstr15_Click_LTE_IoT2_PIC+0
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+0 
	MOVLW       hi_addr(?lstr15_Click_LTE_IoT2_PIC+0)
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+1 
	CALL        _lteiot2_cmdSingle+0, 0
;Click_LTE_IoT2_PIC.c,103 :: 		Delay_1sec();
	CALL        _Delay_1sec+0, 0
;Click_LTE_IoT2_PIC.c,105 :: 		lteiot2_cmdSingle( "AT+QIOPEN=1,0,\"UDP\",\"79.114.83.116\",16666" );
	MOVLW       ?lstr16_Click_LTE_IoT2_PIC+0
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+0 
	MOVLW       hi_addr(?lstr16_Click_LTE_IoT2_PIC+0)
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+1 
	CALL        _lteiot2_cmdSingle+0, 0
;Click_LTE_IoT2_PIC.c,106 :: 		Delay_1sec();
	CALL        _Delay_1sec+0, 0
;Click_LTE_IoT2_PIC.c,108 :: 		lteiot2_cmdSingle( "AT+QISENDEX=0,\"48656C6C6F\"" );
	MOVLW       ?lstr17_Click_LTE_IoT2_PIC+0
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+0 
	MOVLW       hi_addr(?lstr17_Click_LTE_IoT2_PIC+0)
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+1 
	CALL        _lteiot2_cmdSingle+0, 0
;Click_LTE_IoT2_PIC.c,109 :: 		Delay_1sec();
	CALL        _Delay_1sec+0, 0
;Click_LTE_IoT2_PIC.c,110 :: 		}
L_end_applicationInit:
	RETURN      0
; end of _applicationInit

_applicationTask:

;Click_LTE_IoT2_PIC.c,112 :: 		void applicationTask()
;Click_LTE_IoT2_PIC.c,114 :: 		lteiot2_process();
	CALL        _lteiot2_process+0, 0
;Click_LTE_IoT2_PIC.c,116 :: 		lteiot2_cmdSingle( "AT+QISENDEX=0,\"48656C6C6F\"" );
	MOVLW       ?lstr18_Click_LTE_IoT2_PIC+0
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+0 
	MOVLW       hi_addr(?lstr18_Click_LTE_IoT2_PIC+0)
	MOVWF       FARG_lteiot2_cmdSingle_pCmd+1 
	CALL        _lteiot2_cmdSingle+0, 0
;Click_LTE_IoT2_PIC.c,117 :: 		Delay_ms(5000);
	MOVLW       2
	MOVWF       R10, 0
	MOVLW       150
	MOVWF       R11, 0
	MOVLW       216
	MOVWF       R12, 0
	MOVLW       8
	MOVWF       R13, 0
L_applicationTask1:
	DECFSZ      R13, 1, 1
	BRA         L_applicationTask1
	DECFSZ      R12, 1, 1
	BRA         L_applicationTask1
	DECFSZ      R11, 1, 1
	BRA         L_applicationTask1
	DECFSZ      R10, 1, 1
	BRA         L_applicationTask1
	NOP
;Click_LTE_IoT2_PIC.c,118 :: 		}
L_end_applicationTask:
	RETURN      0
; end of _applicationTask

_main:

;Click_LTE_IoT2_PIC.c,120 :: 		void main()
;Click_LTE_IoT2_PIC.c,122 :: 		systemInit();
	CALL        _systemInit+0, 0
;Click_LTE_IoT2_PIC.c,123 :: 		applicationInit();
	CALL        _applicationInit+0, 0
;Click_LTE_IoT2_PIC.c,125 :: 		while (1)
L_main2:
;Click_LTE_IoT2_PIC.c,127 :: 		applicationTask();
	CALL        _applicationTask+0, 0
;Click_LTE_IoT2_PIC.c,128 :: 		}
	GOTO        L_main2
;Click_LTE_IoT2_PIC.c,129 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
