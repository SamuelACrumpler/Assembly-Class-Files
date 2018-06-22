;---------------------
;|  Chris Todd       |
;|  Seth Grant       |
;|  Samuel Crumpler  |
;|  Connor Dominik   |
;|  CSCI 273         |
;|  proj6.asm        |
;|  11-30-2017       |
;---------------------


; Project 6
; Possibly Due on November 30, 2017
; Page 131 : Project 7.2
;
; LOUD NOISES!
;
; Write a program using the appropriate string primitive instructions
; that iterates through the string "I DON'T KNOW WHAT WE'RE YELLING ABOUT!"
; and converts each character to its lowercase counterpart and stores the
; resulting string in another location.

;    HINT!
;    Use the ASCII Tables and subtract 32 from the Uppercase value
;    to get the Lowercase value

section .data                                               ;Section to store initialized variables
string: db "I DON'T KNOW WHAT WE'RE YELLING ABOUT!",0ah     ;base string, used during the string character conversion
strLen: equ($ - string)                                     ;length of the string
string2: db "",0ah                                          ;empty string to store the converted string


section .text                                               ;section for the main program
global _main                                                ;Directive for where the object code is generated.
_main:                                                      ;label for the main program

mov eax, 0                                                  ;EAX functions as the position counter, and is set to 0

loop:                                                       ;label for the loop
or byte[string + eax], 0x20                                 ;Compares the current position in the string to the hexadecimal value of 32 in order to make the uppercase character, a lowercase character.
add eax, 1                                                  ;increment position by one
mov edx, strLen - 1                                         ;push string minus 1 to offset the value for  comparison for the position counter
cmp eax, edx                                                ;compare EAX and EDX to see if the entire string has been completely iterated through
je end                                                      ;jump to the end label if eax and edx are equal
jmp loop                                                    ;else repeat the loop

end:                                                        ;label for ending the program
lea esi, [string]                                           ;copy string source
lea edi, [string2]                                          ;copy string destination
mov ecx, strLen                                             ;move the length of string 1 into ecx
cld                                                         ;clear direction flag
rep movsd                                                   ;rep repeats while ecx ~= to 0. Moves string in esi, to string in edi until ecx is equal to 0

mov ecx, string2                                            ;Place string2 into ECX for printing.
mov edx, strLen                                             ;move the length of the string into edx, this is the length of the input in bytes
mov ebx, 1                                                  ;1 in ebx is used to print to the screen
mov eax, 4                                                  ;4 is interpreted as write
int 0x80                                                    ;call the kernel

mov eax, 1                                                  ;place 1 in EAX for exiting the program
mov ebx, 0                                                  ;place 0 in ebx for exiting the program
int 80h                                                     ;exit the program
