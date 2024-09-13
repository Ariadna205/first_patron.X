; PIC16F887 Configuration Bit Settings

; Assembly source line config statements
#include "p16f887.inc"

; CONFIG1
; __config 0x20D5
__CONFIG _CONFIG1, _FOSC_INTRC_CLKOUT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _CP_OFF & _CPD_OFF & _BOREN_OFF & _IESO_OFF & _FCMEN_OFF & _LVP_OFF
; CONFIG2
; __config 0x3FFF
__CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF

    LIST P=16F887

N       EQU 0xD0      ; constante (EQU palabra reservada para guardar valores en espacios)
cont1   EQU 0x20      ; variable
cont2   EQU 0x21
cont3   EQU 0x22

    ORG 0x00
    GOTO INICIO       ; GOTO comando para ir hacia INICIO

INICIO
    BCF STATUS, RP1   ; RP1=0  bcf=0/bsf=1
    BSF STATUS, RP0   ; BSF = fijar o poner en 1
    MOVLW 0x71
    MOVWF OSCCON      ; CONFIGURAR RELOJ A 8 MHz

    MOVLW 0x10
    MOVWF TRISA       ; Configurar puerto A como entrada
    CLRF TRISD        ; Configurar puerto D como salida (0 salida / 1 Entrada)

    BSF STATUS, RP1   ; RP1=1
    CLRF ANSEL        ; Configurar todos los pines como digitales (0 digital, 1 analógico)
    
    BCF STATUS, RP0   ; Ambos 0
    BCF STATUS, RP1

SECUENCIA1    
    MOVLW 0x05
    MOVWF cont3       ; Inicializar contador

    MOVLW 0x80        ; Valor inicial en PORTD (LED en bit 7 encendido)
    MOVWF PORTD

LOOP1
    CALL RETARDO      ; Llamar al retardo
    CALL RETARDO
    RRF PORTD        ; Desplazar a la derecha
    BSF PORTD,7      ; Mantener encendido el LED del bit 7
    DECFSZ cont3, 0   ; Decrementar cont3, si es cero, continuar
    GOTO LOOP1        ; Repetir si cont3 no es cero

    GOTO SECUENCIA1  ; Volver a la secuencia 1


RETARDO
    MOVLW N
    MOVWF cont1

REP_1
    MOVLW N
    MOVWF cont2

REP_2
    DECFSZ cont2, 1
    GOTO REP_2
    DECFSZ cont1, 1
    GOTO REP_1
    RETURN

    END





