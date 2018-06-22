SECTION .data

stringMessage:
    DB "You already know what the next", 0ah
    DB "variable will be don't you?",0
lengthString: EQU ($ - stringMessage)
lengthString5: EQU (lengthString + 5)
SECTION .text
global _main

_main:

mov eax, 0
add eax, lengthString5
inc eax

int 80h