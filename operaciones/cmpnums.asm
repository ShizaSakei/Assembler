; Macros
%macro imprimir 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro leer 2
    mov eax, 3
    mov ebx, 2
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

section .data
    ; Constants
    msj db "COMPARACIONES ", 10
    msj_len equ-$msj

    msj_may db "El numero es mayor", 10
    msj_len_may equ-$msj_may

    msj_men db "El numero es menor", 10
    msj_len_men equ-$msj_men

    msj_eq db "El numero es igual", 10
    msj_len_eq equ-$msj_eq

section .bss
    ; Variables
    entrada_1 resb 1
    entrada_2 resb 1

section .text
    global _start

_start:
    ; Main instructions
    imprimir msj, msj_len

    leer entrada_1, 2
    leer entrada_2, 2

    mov al, [entrada_1]
    mov bl, [entrada_2]

    cmp al, bl
    jg mayor
    jmp menor

mayor:
    imprimir msj_may, msj_len_may
    jmp salida

menor: 
    imprimir msj_men, msj_len_men
    jmp salida

igualdad:
    imprimir msj_eq, msj_len_eq
    jmp salida

salida:
    mov eax, 1
    int 80h