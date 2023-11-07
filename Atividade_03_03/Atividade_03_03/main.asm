;
; Atividade_03_03.asm
;
; Created: 17/07/2023 21:09:33
; Author : lilic
;


; Replace with your application code
.dseg
aNum: .byte 4
.cseg 
LDI R16, 0x16
sts aNum, R16
LDI R16, 0x17
sts aNum +1, R16
LDI R16, 0x18
sts aNum+2, R16
LDI R16, 0x19
sts aNum+3, R16

lds R0, aNum +1


loop: rjmp loop
