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
    msj db "MULTIPLICACION A TRAVES DE SUMAS",10
    len_msj equ $-msj

    primer_num db "Ingrese el primer numero: "
    len_primer_num equ $-primer_num

    segundo_num db "Ingrese el segundo numero: "
    len_segundo_num equ $-segundo_num

    msj_res db "El resultado es: "
    len_msj_res equ $-msj_res

    salto db " ",10
    len_salto equ $-salto

section .bss
    num_uno resb 2
    num_dos resb 2
    resultado resb 2

section .text
    global _start

_start:
    ; Imprime el titulo
    imprimir msj, len_msj

    ; Impresion y lectura del primer numero
    imprimir primer_num, len_primer_num
    leer num_uno, 2

    ; Impresion y lectura del segundo numero
    imprimir segundo_num, len_segundo_num
    leer num_dos, 2

    ; Movimiento de los dos 
    mov ax, [num_uno]
    mov bx, [num_dos]

    ; Transformarlos a numeros
    sub ax, '0'
    sub bx, '0'

    ; Iniciar los acumuladores en cero
    mov cx, 0
    mov dx, 0

    ; Todo el proceso anterior se lo realiza antes
    ; de entrar a la siguiente etiqueta
    ; ya que si eso entra en el "loop" siempre
    ; se van a iniciar de nuevo los valores
    jmp proceso

proceso:
    add dx, ax  ; dx acumula las sumas sucesivas
    add cx, 1   ; cx acumula las veces que se repite un proceso

    cmp bx, cx  ; se compara si cx es igual al segundo numero almacenado en bx
    je presentar_resultado ; si es igual salta a la presentacion del resultado
    jmp proceso ; si no es igual, vuelve al inicio del proceso

presentar_resultado:
    add dx, '0' ; se transforma a caracter
    mov [resultado], dx ; se guarda el resultado de dx en la variable
    int 80h

    ; Impresion de resultado
    imprimir msj_res, len_msj_res
    imprimir resultado, 1
    imprimir salto, len_salto ; Salto de linea

    ; Fin del programa
    jmp salida

salida:
    mov eax, 1
    int 80h 
    