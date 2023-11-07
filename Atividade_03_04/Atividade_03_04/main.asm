;
; Atividade_03_04.asm
;
; Created: 17/07/2023 23:25:03
; Author : lilic
;


; Replace with your application code
.cseg 
LDI R16, 'L'
mov R0, R16
LDI R16, 'M'
mov R1, R16
LDI R16, 'C'
mov R2, R16
.dseg
myInitials: .byte 3
.cseg
sts myInitials, R0
sts myInitials+1, R1
sts myInitials+2, R2

ldi YH, high(myInitials + 2)
ldi YL, low(myInitials + 2)


