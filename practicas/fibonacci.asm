%macro imprimir 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro leer 2
    mov eax, 3
    mov eax, 2
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

section .data
    msj_title db "SERIE FIBONACCI",10
    len_msj_title equ $-msj_title

    msj_guion db "- "
    len_msj_guion equ $-msj_guion

    salto db " ",10
    len_salto equ $-salto

section .bss
    a_num resb 1
    b_num resb 1
    c_num resb 1
    result resb 1

section .text
    global _start

_start:
    imprimir msj_title, len_msj_title
    mov ax, 0
    mov bx, 1
    mov cx, 0
    mov dx, 7

    jmp proceso

proceso:
    mov ax, bx
    mov bx, cx

    mov dx, ax
    add dx, bx

    mov cx, dx
    
    push cx

    cmp cx, 5
    jng proceso
    jmp recuperar_numeros

recuperar_numeros:
    mov ax, 0

    pop cx
    cmp cx, 0
    jg imprimir_numero
    jmp salir

imprimir_numero:
    add cx, '0'
    mov [result], cx
    int 80h

    imprimir msj_guion, len_msj_guion
    imprimir result, 1
    imprimir salto, len_salto

    jmp recuperar_numeros

salir:
    mov eax, 1
    int 80h



