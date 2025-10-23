; Segmento de datos de DS
.data

.code  ; Segmento de código

ej3 PROC
    ; AX entero y en BX puntero al arbol
    ; arbol en memoria desde ES:[0], resultado en CL 1t, 0f
    ; se conservan los demas registros
    CMP BYTE PTR ES:[BX], 0;
    JNE finif1;
    XOR CL, CL;
    JMP fin;
finif1:
    CMP AX, ES:[BX];
    JNE finif2;
    MOV CL, 1;
    JMP fin;
finif2:
    CMP AX, ES:[BX];
    JNL finif3;
    PUSH DX;
    PUSH BX;
    XOR DH, DH;
    MOV DL, ES:[BX+2];
    SHL DX, 1;
    SHL DX, 1;
    MOV BX, DX;
    CALL ej3;
    POP BX;
    POP DX;
    JMP fin;
finif3:
    PUSH DX;
    PUSH BX;
    XOR DX, DX;
    MOV DL, ES:[BX+3];
    SHL DX, 1;
    SHL DX, 1;
    MOV BX, DX;
    CALL ej3;
    POP BX;
    POP DX;
fin:
    RET;
ej3 ENDP

.ports ; Definición de puertos
; 200: 1,2,3  ; Ejemplo puerto simple
; 201:(100h,10),(200h,3),(?,4)  ; Ejemplo puerto PDDV

.interrupts ; Manejadores de interrupciones
; Ejemplo interrupcion del timer
;!INT 8 1
;  iret
;!ENDINT