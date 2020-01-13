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
    msg_primer_numero db 'Ingrese el primer numero: '
    msg_len_primer_numero equ $-msg_primer_numero
    msg_segundo_numero db 'Ingrese el segundo numero: '
    msg_len_segundo_numero equ $-msg_segundo_numero

    msg_negativo db 'Es negativo', 10
    msg_len_negativo equ $-msg_negativo
    msg_positivo db 'Es positivo', 10
    msg_len_positivo equ $-msg_positivo

section .bss
    primero resb 2
    segundo resb 2

section .text
    global _start

_start:
    imprimir msg_primer_numero, msg_len_primer_numero
    leer primero, 2

    imprimir msg_segundo_numero, msg_len_segundo_numero
    leer segundo, 2
    
    mov ax, [primero]
    mov bx, [segundo]
    
    sub ax, '0'
    sub bx, '0'

    sub ax, bx
    
    js negativo ; si no se ejecuta el curso normal del programa continua
    jmp positivo

;aun si esta agrupado en una etiqueta, el codigo sigue ejecutandose
;es por ello que debe colocarse un salto sin restricciones para que el resto del
;codigo no se ejecute si no se lo requiere
positivo: 
    imprimir msg_positivo, msg_len_positivo

    jmp salida

negativo: 
    imprimir msg_negativo, msg_len_negativo 

    jmp salida

salida:
    mov eax, 1
    int 80h
