; Segmento de datos de DS
.data

.code  ; Segmento de código

fibonacci PROC
    ;arg n en AX, y se retorna en BX
    CMP AX, 0;
    JNE finif1;
    XOR BX, BX;
    JMP fin;
finif1:
    CMP AX, 1;
    JNE finif2;
    MOV BX, 1;
    JMP fin;
finif2:
    DEC AX;
    PUSH AX;
    CALL fibonacci;
    MOV CX, BX;
    POP AX;
    DEC AX;
    CALL fibonacci;
    ADD BX, CX;
fin:
    RET;
fibonacci ENDP

.ports ; Definición de puertos
; 200: 1,2,3  ; Ejemplo puerto simple
; 201:(100h,10),(200h,3),(?,4)  ; Ejemplo puerto PDDV

.interrupts ; Manejadores de interrupciones
; Ejemplo interrupcion del timer
;!INT 8 1
;  iret
;!ENDINT