
;
; Atividade_03.asm
;
; Created: 17/07/2023 14:26:20
; Author : lilic
;


; Replace with your application code
.cseg ;Coloquei a direção para a memória Flash
.org 0x0000 ; Direcionei para a posição na memória Flash
.db "LMC" ; Adicionei cada caractere na memória  -> 4c(L) 4d(M) 43(C)
.org 0x0100 ; Indico a posição para a próxima instrução
start:
	ldi ZL, low(0x0000) ; Uso o ZL para pegar as informações em 0X0000
	ldi ZH, high(0x0000) ; Uso ZH para pegar as informações em 0X0000

	lpm R0, Z+ ; Adiciono L em R0
	lpm R1, Z+ ; Adiciono M em R1
	lpm R2, Z+ ; Adiciono C em R2

loop: ;Loop infinito
	rjmp loop