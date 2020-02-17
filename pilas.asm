%macro imprimir 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

section .data
    msj db '*'
    msj_salto db ' ',10

section .text
    global _start

_start:
    mov ecx, 9
    jmp principal

principal:
    cmp ecx, 0
    jz salir

    jmp imprimir_tag

imprimir_tag:
    dec ecx
    
    push ecx

    imprimir msj, 1
    imprimir msj_salto, 2
    
    pop ecx

    jmp principal

salir:
    mov eax,1
    int 80h