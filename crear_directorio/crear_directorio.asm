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
    msj db 10, "Carpeta de directorio creado",10
    len_msj equ $-msj

    msj_input db "Ingrese el valor: "
    len_msj_input equ $-msj_input

    path db "/home/deusvult/Escritorio/          ",0 ;26


section .bss
    dato resb 50

section .text
    global _start

_start:
    imprimir msj_input, len_msj_input
    leer dato, 50

    mov eax, 39                 ; Servicio para crear un directorio
    mov ebx, dato,               ; Define la ruta de un directorio
    mov ecx, 0x1FF              ; Se define el permiso 777
    int 80h

    imprimir msj, len_msj
    mov eax, 1
    int 80h