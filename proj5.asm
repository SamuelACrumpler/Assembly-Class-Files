;;;;;;;;;;;;;;;;;;;;;;;;;
;Samuel Crumpler	       ;
;CSCI-273		       ;
;Project Final Project  ;
;12/14/2017		       ;
;;;;;;;;;;;;;;;;;;;;;;;;;

;Create a NASM program that contains functions for:
;findLargest: This function recieves two parameters: Unsigned doubleword array, and the length of an array
;The function must return the largest value in the array to EAX
;preserve all registers (except EAX) that are modified by the function.
;Write a test program in _main that calls findLargest three times, each call using a different array with different lengths

;countHits: This function takes two parameters. Two arrays of unsigned doublewords, and a third parameter holding the array lengths (Arrays are the same length)
;for each element in the first array [ x(i) ], if the second array value [ y(i) ] is equal to that of the first array increase count by one
;After the comparsion is complete return count of the  matching array values to EAX.
;Write a test program in _main  that call, and passes the memory addresses of arrays and the length of the arrays
;Be sure to save and restore any registers other than EAX that are changed by your precedure

;ebp+8 is length
;ebp+12 is the start of the first array
;ebp+44 is the start of the second array

section .data			  ; Section for variables 

;findLargest needs to have three different arrays, with different lengths
;countHits needs to have two arrays of similar size

;findLargest variables
findArr1: DD 2, 9, 7, 4, 1                  ;Array 1. Largest value: 9
findArr2: DD 3, 5, 1, 4, 22, 5              ;Array 2. Largest value: 22
findArr3: DD 1, 6, 10, 3                    ;Array 3. Largest value: 10
faLen1: EQU ($ - findArr1)                  ;Array1 Length:5
faLen2: EQU ($ - findArr2)                  ;Array1 Length:6
faLen3: EQU ($ - findArr3)                  ;Array1 Length:4

;countHits variables: Four matching values

countArr1: DD 10, 5, 3, 4, 22, 1, 9, 15     ;First Count Array
countArr2: DD 32, 5, 3, 6, 29, 1, 10, 15    ;Secound count array
countLen1: EQU ($ - countArr1)              ;1st Array Length: 8
countLen2: EQU ($ - countArr2)              ;2nd Array Length: 8

section .bss
fLen1: RESD 1			;unintialized length variable
fLen2: RESD 1               ;unintialized length variable
fLen3: RESD 1               ;unintialized length variable

cLen1: RESD 1               ;unintialized length variable
cLen2: RESD 1               ;unintialized length variable

section .text                                               ;section for the main program
global _main                                                ;Directive for where the object code is generated.
_main:                                                      ;label for the main program

mov DWORD [fLen1], faLen1	;transfer lengths of arrays into uninitialized variables. The memory addresses of the original variables could not be found.
mov DWORD [fLen2], faLen2	;transfer lengths of arrays into uninitialized variables. The memory addresses of the original variables could not be found.
mov DWORD [fLen3], faLen3	;transfer lengths of arrays into uninitialized variables. The memory addresses of the original variables could not be found.

mov DWORD [cLen1], countLen1	;transfer lengths of arrays into uninitialized variables. The memory addresses of the original variables could not be found.
mov DWORD [cLen2], countLen2	;transfer lengths of arrays into uninitialized variables. The memory addresses of the original variables could not be found.

mov eax, 0
push DWORD [fLen1]     ;length of the first array 
push DWORD [findArr1]   ;push the first array onto the stack
call _findLargest       ;Call findLargest function, should return 22
add esp, 8              ;dereference the current stack

push DWORD [fLen2]     ;length of the first array 
push DWORD [findArr2]   ;push the first array onto the stack
call _findLargest       ;Call findLargest function, should return 22
add esp, 8              ;dereference the current stack

push DWORD [fLen2]     ;length of the first array 
push DWORD [findArr2]   ;push the first array onto the stack
call _findLargest       ;Call findLargest function, should return 22
add esp, 8              ;dereference the current stack

push DWORD [cLen1]         ;length of the arrays
push DWORD [countArr1]     ;push first array onto the stack 
push DWORD [countArr2]     ;push second array onto the stack
call _countHits             ;Call the countHits function
add esp, 12                 ;dereference the current stack

_endprog:				; setup the program to exit normally
    mov eax, 1				; set eax to 1
    mov ebx, 0				; set ebx to 0
    int 80h				; value given to shut the program down.



_findLargest:               ;[findLargest] Searches through an array to find the largest value.
                            ;prologue exists for every function call, allows the program to return to the _main section
    push ebp                ;location of stack frame where local variables are stored
    mov ebp, esp            ;set ebp to the same value of the top of the stack
    push ebx                ;callee-saved register, used for comparsion
    push ecx                ;used for counter
    mov eax, 0              ;set eax to 0 before starting the comparisons
    mov ecx, 0              ;set counter equal to 0
    
searchArray:                            ;[searchArray] Start of the loop in the function
    mov ebx, [ebp + 16 + (4 * ecx)]      ;Search through array
    cmp ebx, eax                        ;compare the eax and ebx value
    ja replace                          ;jump to replace if ebx is greater
    
incr:                                   ;[Incr] Increments counter, checks if the function needs to continue or not
    inc ecx                             ;increment ECX by one
    mov ebx, [ebp + 12]                  ;move the length value into ebx
    dec ebx                      ;decrement to match the proper length of the array
    cmp ecx, ebx	                ;compare the counter with the length of the string
    je endFind                          ;ends the loop if ecx and the string length are equal
    jmp searchArray                     ;Start the loop over again if the conditions aren't met
    
replace:                    ;[Replace] handles the replacing of values
    mov eax, ebx            ;place the higher value into eax
    jmp incr                ;continue with the program
    
   
     
    
endFind:                   ;[endFind] handles ending the function
    pop ecx                 ;restore ECX to the previous value
    pop ebx                 ; restore EBX to previous value
    pop ebp                 ; restore ebp
    ret                     ; return back to the previous location


_countHits:                 ;[countHits] Counts the amount of matching numbers exists within a position of both arrays
                            ;prologue exists for every function call, allows the program to return to the _main section
    push ebp                ;location of stack frame where local variables are stored
    mov ebp, esp            ;set ebp to the same value of the top of the stack
    push ebx                ;callee-saved register, used for comparsion
    push edx                ;callee-saved register, used for comparsion
    push ecx                ;callee-saved register, used for counting
    mov eax, 0              ;set EAX to 0 before starting the comparsions
    
check:                                  ;[check] Checks both values to see if they are the same or not.
    mov ebx, [ebp + 12 + (4*ecx)]        ;Move array1 value to ebx
    mov edx, [ebp + 44 + (4*ecx)]        ;Move array2 value to edx
    cmp ebx, eax                        ;Check values
    je hitUp                            ;Jump to hitUp if equal

hitInc:                                 ;[hitInc] increments the counter, then checks if the function has iterated through all the values
    inc ecx                             ;increment the counter
    mov ebx, [ebp + 8]                  ;move the length value into ebx
    dec ebx                             ;decrement to match the proper length of the array
    cmp ecx, ebx	                   ;compare the counter with the length of the string
    je endHit                           ;end if the values are equal
    jmp check                           ;else continue to check
    
    
hitUp:                                  ;[hitUp] increases the value of EAX when a match is found
    inc eax                             ;increment EAX by one
    jmp hitInc                          ;jump back up to hitInc

endHit:                    ;[endHits] Ends the countHits functions
    pop ecx                 ;restore ECX to the previous value
    pop edx                 ;restore EDX to the previous value
    pop ebx                 ; restore EBX to previous value
    pop ebp                 ; restore ebp
    ret                     ; return back to the previous location
  





