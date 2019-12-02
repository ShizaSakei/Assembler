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
    msj1 db "Ingrese el dividendo: "
    len1 equ $-msj1

    msj2 db "Ingrese el divisor: "
    len2 equ $-msj2

    mensaje db "El resultado es: "
    len equ $-mensaje

    men_cociente db "El cociente es: "
    len_c equ $-men_cociente

    men_resto db "El resto es: "
    len_r equ $-men_resto
    
    salto db " ", 10
    len_salto equ $-salto

section .bss
    division resb 1
    cociente resb 1
    resto resb 1
    n1 resb 1
    n2 resb 1

section .text
    global _start

_start:
    ; Primer numero
    imprimir msj1, len1
    leer n1, 2

    ; Segundo numero
    imprimir msj2, len2
    leer n2, 2

    ; Proceso de division
    mov al, [n1]
    mov bl, [n2]

    sub ax, '0'
    sub bl, '0'

    div bl

    add al, '0'
    add ah, '0'

    mov [cociente], al
    mov [resto], ah

    int 80h

    ; Cociente
    imprimir men_cociente, len_c
    imprimir cociente, 1

    ; Salto de linea
    imprimir salto, len_salto

    ; Residuo
    imprimir men_resto, len_r
    imprimir resto, 1

    ; Salto de linea
    imprimir salto, len_salto

    ; Salida
    mov eax, 1
    int 80h