; Segmento de datos de DS
.data

.code  ; Segmento de código
MOV AX, 0x5E01;
MOV BX, 0x03AE;
MOV CX, 0x00FA;
PUSH AX;
PUSH BX;
PUSH CX;
CALL ej10;

ej10 PROC
    PUSH BP;
    MOV BP, SP; BP = bp, ip, z, y, x
    PUSH BX;
    PUSH CX;
    MOV AX, [BP+8]; AX: x
    MOV BX, [BP+6]; BX: y
    MOV CX, [BP+4]; CX: z
    AND AX, BX; x & y
    AND AX, CX; x & y & z
    POP CX;
    POP BX;
    POP BP;
    RET;
ej10 ENDP

.ports ; Definición de puertos
; 200: 1,2,3  ; Ejemplo puerto simple
; 201:(100h,10),(200h,3),(?,4)  ; Ejemplo puerto PDDV

.interrupts ; Manejadores de interrupciones
; Ejemplo interrupcion del timer
;!INT 8 1
;  iret
;!ENDINT
