;nasm 2.11.08
;Samuel Crumpler
;CSCI-273
;Project 2


;Create a program that calculates the following expression: x = (a+b)-(c+d)
;The answer must be stored in a variable of the correct data type given your data (a,b,c,d)
;the values for your data(a,b,c,d) must be stored in registers(eax,ebx,etc), not variables
;you must supply the initial values for data(a,b,c,d)
;create a string that could accompny the answer in an output statement
;(The answer is:). You do not have to output the string
;Comment Each line of code, as demonstrated in the Working Examples Section for program 3.2 
;for GAS, to briefly describe each line's meaning

section .data
    answerString:     db 'The answer of (10+9) - (8+7) is: ',10    ;
    answerLen:  equ $-answerString             ; Length of the string
    answer: dd 0

section .text
	global _start

_start:

    mov eax,10			 ; Value A: 10
	mov ebx,9            ; Value B: 9
	add eax,ebx          ; Value A+B: 19
	mov ebx,8			 ; Replace ebx with value C: 8
	mov ecx, 7			 ; Value D: 7
	add ebx, ecx		 ; Value C+D
	sub eax, ebx		 ; Value (A+B) - (C+D)
	mov DWORD [answer], eax ;push the final value into answer
	mov eax, 1
	mov ebx, 0
	int 80h              ; Call the kernel