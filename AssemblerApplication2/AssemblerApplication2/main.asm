;
; AssemblerApplication2.asm
;
; Created: 19/07/2023 11:27:37
; Author : lilic
;


; Replace with your application code
;ldi r16, 0x01
;mov r7, r16

;tst r7
;breq locZero
;rjmp locNotZero


;locZero: add r17, r16
;locNotZero: subi r17, 1

.def counter = r16; unsigned byte
.def limit = r17; unsigned byte 
.def aH = r25;a = r25:r24 ;signed 16-bit int
.def aL = r24 
.def bH = r23 ;b = r23:r22 signed 16-bit int
.def bL = r22

;a. do {counter ++; limit?; } while (counter < limit);
;b. while (a < b){a += limit;} // beware of data sizes
;c. while (true){a + +; if (a < b) break; b?}

ldi aL, 0
ldi aH, 0
ldi bL, 5
ldi bH, 0

ldi r28, 1

ldi counter, 0
ldi limit, 10

do:
	inc counter
	dec limit 	
	cp counter, limit ; limit > counter
	brlo do 	


while_b:
	cp aL, bL
	cpc aH, bH 	
	brge end_while_b ; a >= b
	add aL, limit
	rjmp while_b
end_while_b:


rjmp while_c
lp:
	subi bL, 1
	sbc bH, r28
while_c:
	adiw aH:aL, 1
	cp aL, bL
	cpc aH, bH 	
	brge loop ; a => b 
rjmp lp

loop:
rjmp loop


.def r16 = count 	;unsigned 8-bit integer
.def r17 = sum 		;signed 8-bit integer
.def r18 = limit 	;signed 8-bit integer
one: cpi count, $A ; compara count e A 
brsh two; if(count >= A) go to "two"
inc sum ; sum++
two: cp sum, limit ;compara sum e limit
brlt three; if(sum < limit) go to "three"
dec limit ; limit --
rjmp four ; chama four
three: add sum, limit ;sum = sum + limit 
sub sum, count; sum = sum - count
four: inc count ; count ++

switch(){
	case 1:
		if(count >= 10){
		goto case 2;
		}
		sum ++;
	case 2:
		if(sum < limit){
		goto case 3;
		}
		limit --
		goto case 4;
	case 3:
		sum += limit;
		sun-=count;
	case 4:
		count++;
		break;
}


0000 - 0
0001 - 1
0010 - 2
0011 - 3
0100 - 4
0101 - 5
0110 - 6
0111 - 7
1000 - 8
1001 - 9
1010 - 10
1011 - 11
1100 - 12
1101 - 13
1110 - 14
1111 - 15