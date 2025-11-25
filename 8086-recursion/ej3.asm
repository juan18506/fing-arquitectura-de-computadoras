; Segmento de datos de DS
.data

.code  ; Segmento de código

ej3 PROC
    ; AX entero y en BX indice al arbol
    ; arbol en memoria desde ES:[0], resultado en CL 1t, 0f
    ; se conservan los demas registros
    PUSH SI;
    PUSH BX;
    PUSH DX;
    XOR CL, CL;
    CMP BX, 0; if i == 0
    JNE fin;
    SHL BX, 1;
    SHL BX, 1; convierte indice en offset
    CMP AX, ES:[BX]; if buscado == arbol[i].dato
    JNE else;
    INC CL;
    JMP fin;
else:
    MOV SI, BX;
    MOV BX, ES:[SI+2];
    CALL ej3;
    MOV DL, CL;
    MOV BX, ES:[SI+3];
    OR CL, DL;
fin:
    POP DX;
    POP BX;
    POP SI;
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
