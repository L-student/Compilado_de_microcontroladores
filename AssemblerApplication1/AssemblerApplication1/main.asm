;
; Atividade_03.asm
;
; Created: 17/07/2023 14:26:20
; Author : lilic
;


; Replace with your application code
.cseg ;Coloquei a direção para a memória Flash
.org 0x0000
lp:
	.db "lmc"
start:
	ldi ZL, low(lp) ;Usa ZL para pegar o low de lp
	ldi ZH, high(lp) ;Usa ZL para pegar o High de lp
	lpm R0, Z ;Usa Z para colocar o byte mais significativo em lp

loop:
 rjmp loop