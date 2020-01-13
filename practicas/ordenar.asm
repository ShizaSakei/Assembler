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
    msj_title db "ORDENAR TRES NUMEROS",10
    len_msj_title equ $-msj_title

    msj_numero_uno db "Ingresar el primer numero: "
    len_msj_numero_uno equ $-msj_numero_uno

    msj_numero_dos db "Ingresar el segundo numero: "
    len_msj_numero_dos equ $-msj_numero_dos

    msj_numero_tres db "Ingresar el tercer numero: "
    len_msj_numero_tres equ $-msj_numero_tres

    msj_primer_resultado db "Numero 1: "
    len_msj_primer_resultado equ $-msj_primer_resultado

    msj_segundo_resultado db "Numero 2: "
    len_msj_segundo_resultado equ $-msj_segundo_resultado

    msj_tercer_resultado db "Numero 3: "
    len_msj_tercer_resultado equ $-msj_tercer_resultado

    salto db " ",10
    len_salto equ $-salto

section .bss
    numero_uno resb 2
    numero_dos resb 2
    numero_tres resb 2

section .text
    global _start

_start:
    imprimir msj_title, len_msj_title
    
    imprimir msj_numero_uno, len_msj_numero_uno
    leer numero_uno, 2

    imprimir msj_numero_dos, len_msj_numero_dos
    leer numero_dos, 2

    imprimir msj_numero_tres, len_msj_numero_tres
    leer numero_tres, 2


    mov ax, [numero_uno]
    mov bx, [numero_dos]
    mov cx, [numero_tres]

    sub ax, '0'
    sub bx, '0'
    sub cx, '0'
    
    jmp comparar_bajo

comparar_bajo:
    cmp bx, cx
    jng ordenar_bajo
    jmp comparar_alto

comparar_alto:
    cmp ax, bx
    jng ordenar_alto
    jmp comprobar_bajo

ordenar_bajo:
    mov dx, bx
    mov bx, cx
    mov cx, dx

    jmp comparar_alto

ordenar_alto:
    mov dx, ax
    mov ax, bx
    mov bx, dx

    jmp comprobar_bajo

comprobar_bajo:
    cmp bx, cx
    jng ordenar_bajo_aux
    jmp fijar_numeros

ordenar_bajo_aux:
    mov dx, bx
    mov bx, cx
    mov cx, dx

    jmp fijar_numeros

fijar_numeros:
    add ax, '0'
    add bx, '0'
    add cx, '0'

    mov [numero_uno], ax
    mov [numero_dos], bx
    mov [numero_tres], cx

    int 80h

    jmp presentar

presentar:
    imprimir msj_primer_resultado, len_msj_primer_resultado
    imprimir numero_uno, 1
    imprimir salto, len_salto

    imprimir msj_segundo_resultado, len_msj_segundo_resultado
    imprimir numero_dos, 1
    imprimir salto, len_salto

    imprimir msj_tercer_resultado, len_msj_tercer_resultado
    imprimir numero_tres, 1
    imprimir salto, len_salto

    jmp salida

salida:
    mov eax, 1
    int 80h
    