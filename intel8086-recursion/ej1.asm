; Segmento de datos de DS
.data
buffer DW DUP(1024) 0;

.code  ; Segmento de código

; Llamada a la funcion
; MOV BX, ... ; indice
; MOV AX, OFFSET buffer; en ES
; PUSH AX;
; CALL construirCadena;
; POP AX;

construirCadena PROC
    ; indiceLista se pasa en BX y la lista esta apuntada por DS:SI
    POP AX;
    POP DI; DI: offset buffer
    PUSH DX;
    PUSH AX;
    CMP BX, 0;
    JGE else;
    MOV BYTE PTR ES:[DI], 0;
    JMP fin;
else:
    MOV AX, BX;
    SHL BX, 1;
    ADD BX, AX; BX: indice*3
    MOV CL, [BX+SI]; lista[indice].c
    MOV ES:[DI], CL;
    MOV BX, [BX+SI+1]; lista[indice].sig
    INC DI;
    PUSH DI;
    CALL construirCadena;
    POP DI;
fin:
    RET;
construirCadena ENDP

.ports ; Definición de puertos
; 200: 1,2,3  ; Ejemplo puerto simple
; 201:(100h,10),(200h,3),(?,4)  ; Ejemplo puerto PDDV

.interrupts ; Manejadores de interrupciones
; Ejemplo interrupcion del timer
;!INT 8 1
;  iret
;!ENDINT