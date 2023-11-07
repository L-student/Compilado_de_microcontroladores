;
; Trabalho_01.asm
; Illustrate the use of a Timer/Counter to blink an LED
; LEDBlinker_Timer.asm
;
; Created: 27/02/2023 11:56:54
; Author : Rangel, Lívia, Matheus e Daniel
;
;LED's on PORTB
;Clock speed 16 MHz
;Timer Counter 1 is used to count off a 0.5 second interval.
;At the end of each interval, the LED's are toggled.
.def vector01=r19
.equ Bit0 = 0
.equ Bit1 = 1
.equ Bit2 = 2
.equ Bit3 = 3
.equ Bit4 = 4
.equ Bit5 = 5
.equ Bit6 = 6
.equ Bit7 = 7
.def vector02=r20

jmp reset
.org OC1Aaddr
jmp OC1A_Interrupt

OC1A_Interrupt:
push r16
in r16, SREG
push r16

lpm display, Z+

pop r16
out SREG, r16
pop r16
reti



reset:
	.cseg 
	tabela: .db 0x7E, 0x30, 0x6D, 0x79, 0x33, 0x5B, 0x5F, 0x70, 0x7F, 0x7B, 0x77, 0x1F, 0x4E, 0x3D, 0x4F, 0x47

	ldi ZH, high(tabela*2)
	;out ZH, r16
	ldi ZL, low(tabela*2)
	;out ZL, r16

	.def bt_call01 = r30
	.def bt_call02 = r29
	.def bt_call03 = r28

	lds r16, TIMSK1
	sbr r16, 1 <<OCIE1A
	sts TIMSK1, r16

	.def temp = r16
	.def display = r17 ;current LED value
	.cseg

	;Stack initialization
	ldi temp, low(RAMEND)
	out SPL, temp
	ldi temp, high(RAMEND)
	out SPH, temp

	;leds display alternating pattern
	ldi temp, $FF
	out DDRD, temp
	lpm display, Z+
	out PORTD, display ;alternating pattern

	#define CLOCK 16.0e6 ;clock speed
	.equ PRESCALE = 0b100 ;/256 prescale
	.equ PRESCALE_DIV = 256
	#define DELAY 1 ;seconds
	.equ WGM = 0b0100 ;Waveform generation mode: CTC
	;you must ensure this value is between 0 and 65535
	.equ TOP =	int(0.5 + ((CLOCK/PRESCALE_DIV)*DELAY))
	.if TOP > 65535
	.error "TOP is out of range"
	.endif

	;On MEGA series, write high byte of 16-bit timer registers first
	ldi temp, high(TOP) ;initialize compare value (TOP)
	sts OCR1AH, temp
	ldi temp, low(TOP)
	sts OCR1AL, temp
	ldi temp, ((WGM&0b11) << WGM10) ;lower 2 bits of WGM
	sts TCCR1A, temp
	;upper 2 bits of WGM and clock select
	ldi temp, ((WGM>> 2) << WGM12)|(PRESCALE << CS10)
	sts TCCR1B, temp ;start counter
	sei;



	main_lp:

	;fazer o swich para verificar os estados dos botões
	;criar um pilha para chamados [opcional] pode ser no reg mais não temos como saber a ordem
	;implementar os contadores

		out PORTD, display
		cpi display, 0x47
		breq reset
		rjmp main_lp






; Replace with your application code

    ldi r16, 0b00110111
	ldi r17, 0xFF
	out DDRD, r17
	out PORTD, r16

start:
	rjmp start