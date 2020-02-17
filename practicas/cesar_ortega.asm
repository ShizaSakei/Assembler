; EVALUACION 2 - PILAS Y SALTOS
; 03/02/2020
; CESAR ALFONSO ORTEGA JARAMILLO

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
    msj db "ORDENAR NUMEROS",10
    len_msj equ $-msj

    msj_ingreso db "Ingrese un numero: "
    len_msj_ingreso equ $-msj_ingreso

    msj_mayor db "El mayor es: "
    len_msj_mayor equ $-msj_mayor

    msj_menor db "El menor es: "
    len_msj_menor equ $-msj_menor

    salto db " ",10
    len_salto equ $-salto

section .bss
    num_1 resb 1
    num_2 resb 1
    num_3 resb 1
    num_4 resb 1
    num_5 resb 1

    mayor resb 1
    menor resb 1

    aux resb 1

section .text
    global _start

_start:
    imprimir msj, len_msj

    imprimir msj_ingreso, len_msj_ingreso
    leer num_1, 2

    imprimir msj_ingreso, len_msj_ingreso
    leer num_2, 2

    imprimir msj_ingreso, len_msj_ingreso
    leer num_3, 2

    imprimir msj_ingreso, len_msj_ingreso
    leer num_4, 2

    imprimir msj_ingreso, len_msj_ingreso
    leer num_5, 2

    mov edx, 0 ; contador 1

llenar_pila:
    mov ecx, edx ; contador 2

    mov ebx, [num_1]
    add ebx, '0'
    push ebx

    mov ebx, [num_2]
    add ebx, '0'
    push ebx

    mov ebx, [num_3]
    add ebx, '0'
    push ebx

    mov ebx, [num_4]
    add ebx, '0'
    push ebx

    mov ebx, [num_5]
    add ebx, '0'
    push ebx

    jmp proceso

proceso:
    cmp edx, 5
    je imprimir_numeros

    cmp ecx, 0
    jg vaciar_pila

    inc edx
    
    mov ecx, 5
    sub ecx, edx

    pop ebx
    mov [aux], ebx

    jmp comparar

comparar:
    cmp ecx, 0
    je empujar_valor

    dec ecx

    mov eax, [aux]
    pop ebx

    cmp eax, ebx
    jg comparar

    mov [aux], ebx
    jmp comparar

empujar_valor:
    mov eax, [aux]
    push eax
    jmp llenar_pila

vaciar_pila:
    cmp ecx, 0
    je proceso

    pop ebx
    dec ecx

    jmp vaciar_pila

imprimir_numeros:
    pop ebx
    sub ebx, '0'
    mov [aux], ebx

    push edx

    imprimir aux, 1
    imprimir salto, len_salto

    pop edx
    dec edx 

    cmp edx, 0
    jg imprimir_numeros
    jmp salida


salida:
    mov eax, 1
    int 80h

    









