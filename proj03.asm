;;;;;;;;;;;;;;;;;;;;;;;;;
;Samuel Crumpler	;
;CSCI-273		;
;Project 3		;
;11/1/2017		;
;;;;;;;;;;;;;;;;;;;;;;;;;

section .data
arrSour: DW 5, 10, 15, 20

section .bss
arrDest: RESD 4

section .text
global _main
_main:

;First value in array index
mov ax, [arrSour] ;move the first element into EAX
mov cx, 0 ; using edx as the index increment
mov bx, 8 ; push the value of 8 into 
mul bx    ; multiply by 8
mov [arrDest], ax ; move updated value into the first element of destination array

inc cx ; increase value by 1; 1

mov ax, [arrSour+2]
mul bx
mov WORD [arrDest+4], ax

inc cx ; increase value by 1; 2 

mov ax, [arrSour+ecx*2]
mul bx
mov WORD [arrDest+ecx*4], ax

inc cx ; increase value by 1; 3

mov ax, [arrSour+ecx * 2]
mul bx
mov WORD [arrDest + ecx * 4], ax
 
mov ax, 1
mov bx, 0
int 80h



