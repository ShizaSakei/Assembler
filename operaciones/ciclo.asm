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
    msg_salto db '. ',10
    msg_len_salto equ $-msg_salto

section .bss
    numero resb 2

section .text
    global _start

_start:
    mov cx, 10
    jmp ciclo

ciclo:
    cmp cx, 0
    jz salida
    
    dec cx

    jmp imprimir_loop

imprimir_loop:
    push cx ;envia el valor al segmento de pila
    imprimir numero,1
    imprimir msg_salto,msg_len_salto
    pop cx ;recupera el valor del segmento de pila
    jmp ciclo

salida:
    mov eax, 1
    int 80h
