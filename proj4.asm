;;;;;;;;;;;;;;;;;;;;;;;;;
;Samuel Crumpler	;
;CSCI-273		;
;Project 4		;
;11/12/2017		;
;;;;;;;;;;;;;;;;;;;;;;;;;

section .data				; Section for variables
fb1: dd 1				; first number in the sequence
fb2: dd 1				; second number in the sequence
fbtotal: dd 1				; total value, started at one.

section .text				; Section for running the program
global _main
_main:

    	mov ebx, 2     			; move the number 2 into ebx for the division	

_chk: 					; checks the value for the fibonacci number
      					; if fb2 is not equal to an odd number, jump to the next number
      					; else continue as normal
      
	mov eax, [fb2] 			; move the second number into eax to be checked
    	div ebx        			; Divide the value
    	cmp edx, 0			; Compare the remainder to check if the number is odd
    	jz _inc 			; Jump to _inc if the value is even
      
_sum: 					;adds the value to the total

    	mov eax, [fb2] 			; move second number into EAX
    	add dword [fbtotal], eax 	; add to the total value.

_inc: 					; increments to the next values

   	mov eax, [fb2] 			; move current fb2 value into eax
   	add eax, [fb1] 			; add fb1 value for the next number in the fibonacci sequence.
    	mov dword [fb2], eax		; push updated value into fb2
    	mov eax, [fb2]			; move updated value into eax
    	sub eax, [fb1]			; perform subtraction to get the new eax value
    	mov dword [fb1], eax 		; push updated value into fb1
    	cmp dword [fb2], 1000000	; compare fb2 to 1,000,000
    	jb _chk				; jump back to _chk while the value is below 1,000,000

_endprog:				; setup the program to exit normally
    mov eax, 1				; set eax to 1
    mov ebx, 0				; set ebx to 0
    int 80h				; value given to shut the program down.



