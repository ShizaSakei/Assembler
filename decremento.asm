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
    msj db '*'
    msj_salto db ' ',10

section .bss
    num resb 1
    result resb 1

section .text
    global _start

_start:
    leer num, 2
    mov cx, 0
    mov dx, [num]

    jmp principal

principal:
    cmp cx, dx
    jg salir

    jmp decremento

decremento:
    push cx
    
    mov ax, 0
    add cx, '0'
    mov [result], cx
    int 80h

    imprimir result, 2

    pop cx
    inc cx

    jmp principal


salir:
    mov eax,1
    int 80h