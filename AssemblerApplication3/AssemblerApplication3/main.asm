jmp reset

.org OC1Aaddr
jmp OC1A_Interrupt


OC1A_Interrupt:
;push r16
;in r16, SREG
;push r16

	ldi temp, $FF
;eor leds, temp

;pop r16
;out SREG, r16
;pop r16
	reti

reset:
.def temp = r16
.def leds = r17 ;current LED value
.cseg

;Stack initialization
ldi temp, low(RAMEND)
out SPL, temp
ldi temp, high(RAMEND)
out SPH, temp

;leds display alternating pattern
;ldi temp, $FF
;out DDRB, temp
;ldi leds, $AA
;out PORTB, leds ;alternating pattern

#define CLOCK 8.0e6 ;clock speed
#define DELAY 0.000357 ;seconds
.equ PRESCALE = 0b001 ;/256 prescale
.equ PRESCALE_DIV = 1
.equ WGM = 0b0100 ;Waveform generation mode: CTC
;you must ensure this value is between 0 and 65535
.equ TOP = int(0.5 + ((CLOCK/PRESCALE_DIV)*DELAY))
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
lds r16, TIMSK1
sbr r16, 1 <<OCIE1A
sts TIMSK1, r16
sei;
main_lp:
	out PORTB, leds
	;rjmp main_lp