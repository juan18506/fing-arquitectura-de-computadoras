; Segmento de datos de DS
.data

.code  ; Segmento de código

profundidad PROC
; “PUSH segmento árbol”
; “PUSH offset árbol”
; “CALL profundidad”
; “POP profundidad”
    PUSH BP;
    MOV BP, SP;
    PUSH AX;
    PUSH BX;
    PUSH DS;
    MOV BX, [BP+4]; BX: offset del arbol
    MOV AX, [BP+6]; 
    MOV DS, AX; DS: segmento del arbol
    OR AX, BX;
    MOV AX, -1;
    JZ fin;
    PUSH [BX+2];
    PUSH [BX];
    CALL profundidad;
    POP AX; AX: prof(arbol izq)
    INC AX;
    PUSH [BX+6];
    PUSH [BX+4];
    CALL profundidad;
    POP BX; BX: prof(arbol der)
    INC BX;
    CMP AX, BX;
    JG fin;
    MOV AX, BX;
fin:
    MOV [BP+6], AX;
    MOV AX, [BP+2];
    MOV [BP+4], AX;
    POP DS;
    POP BX;
    POP AX;
    POP BP;
    ADD SP, 2;
    RET;
profundidad ENDP

.ports ; Definición de puertos
; 200: 1,2,3  ; Ejemplo puerto simple
; 201:(100h,10),(200h,3),(?,4)  ; Ejemplo puerto PDDV

.interrupts ; Manejadores de interrupciones
; Ejemplo interrupcion del timer
;!INT 8 1
;  iret
;!ENDINT