
;
; Atividade_03.asm
;
; Created: 17/07/2023 14:26:20
; Author : lilic
;


; Replace with your application code
.cseg ;Coloquei a dire��o para a mem�ria Flash
.org 0x0000 ; Direcionei para a posi��o na mem�ria Flash
.db "LMC" ; Adicionei cada caractere na mem�ria  -> 4c(L) 4d(M) 43(C)
.org 0x0100 ; Indico a posi��o para a pr�xima instru��o
start:
	ldi ZL, low(0x0000) ; Uso o ZL para pegar as informa��es em 0X0000
	ldi ZH, high(0x0000) ; Uso ZH para pegar as informa��es em 0X0000

	lpm R0, Z+ ; Adiciono L em R0
	lpm R1, Z+ ; Adiciono M em R1
	lpm R2, Z+ ; Adiciono C em R2

loop: ;Loop infinito
	rjmp loop