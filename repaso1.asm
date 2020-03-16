%macro escribir 2
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

    path1 db '/home/pancho/Documentos/practicas/arreglo1/arreglo1.txt', 0
    len_path1 equ $-path1

    path2 db '/home/pancho/Documentos/practicas/arreglo2/arreglo2.txt', 0
    len_path2 equ $-path2

    msj1 db 10,'El primer arreglo es:', 10
    len1 equ $-msj1

    msj2 db 10,'Ingrese el segundo arreglo:', 10
    len2 equ $-msj2

    msj3 db 10,'El segundo arreglo es:', 10
    len3 equ $-msj3

    msj4 db 10,'El suma del primer arreglo es:', 10
    len4 equ $-msj4

    msj5 db 10,'El resta del segundo arreglo es:', 10
    len5 equ $-msj5

    msj6 db 10,'La suma de los arreglos es:', 10
    len6 equ $-msj6


    mensaje_error db "error en el archivo", 10
    len_error equ $-mensaje_error

    arreglo2 db '     '
    suma db '  '
    len_suma equ $-suma
    len_arreglo2 equ $-arreglo2

section .bss
    texto1 resb 35
    texto2 resb 35
    idarchivo resb 1

section .text
    global _start
_start:
;******************************** arreglo 1****************** 
    ;leer la direccion 
    mov eax, 5
    mov ebx, path1
    mov ecx, 0
    mov edx, 0
    int 80h

    test eax, eax
    jz error

    mov dword [idarchivo], eax
    ; leer el contenido del archivo arreglo1
    mov eax, 3
    mov ebx, [idarchivo]
    mov ecx, texto1
    mov edx, 35
    int 80h
    ; escribir el contenido del arreglo 1 
    escribir msj1, len1
    escribir texto1, 35
    ; cerrar el archivo segun mintio perfecto
    mov eax, 6
    mov ebx, [idarchivo]
    mov ecx, 0
    mov edx, 0
    int 80h

;******************************** arreglo2 ************************
    ;////////////////////////////// escritura arreglo 2 ///////////////////////
    ; Ingresar el arreglo2
    escribir msj2, len2
    leer arreglo2, len_arreglo2
    
    ; leer la ruta a guardar 
    mov eax, 8 ; subrutina
    mov ebx, path2;ruta 
    mov ecx, 1 ; acceso
    mov edx, 0x1FF ;permiso
    int 80h

    test eax, eax
    jz error

    mov dword [idarchivo], eax
    ; escribir dentro del archivo arreglo2.txt
    mov eax, 4
    mov ebx, [idarchivo]
    mov ecx, arreglo2
    mov edx, len_arreglo2
    int 80h
    ;//////////////////////////////// lectura arreglo2 ////////////////////////
    ;leer la direccion 
    mov eax, 5
    mov ebx, path2
    mov ecx, 0
    mov edx, 0
    int 80h

    test eax, eax
    jz error

    mov dword [idarchivo], eax
    ; leer el contenido del archivo arreglo2
    mov eax, 3
    mov ebx, [idarchivo]
    mov ecx, texto2
    mov edx, 35
    int 80h
    ; escribir el contenido del arreglo2
    escribir msj3, len3
    escribir texto2, 35
    ; cerrar el archivo 
    mov eax, 6
    mov ebx, [idarchivo]
    mov ecx, 0
    mov edx, 0
    int 80h

;************************suma del arreglo 1**********

    mov esi, 0
    mov edi, 0
    mov ecx, 5
    clc

    mov al, 0
    mov [suma], al

proceso_suma:
    mov al, [suma]
    mov ah, [texto1 + esi]
    sub ah, '0'

    adc al, ah

    aaa
    pushf
    or al, 30h
    popf

    mov [suma], al

    add esi, 1
    add edi, 1
    
    loop proceso_suma

    escribir msj4, len4
    escribir suma, len_suma
    
    jmp salir

error:
    escribir mensaje_error, len_error

salir:    

    mov eax, 1
    int 80h
