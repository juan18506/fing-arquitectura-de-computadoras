; Segmento de datos de DS
.data

.code  ; Segmento de código

bifurcaciones PROC
; “PUSH segmento árbol”
; “PUSH offset árbol”
; “CALL cantidadBifurcaciones”
; “POP cantidad”
; El resultado se devuelve en el stack y los argumentos deben retirarse del stack.
    PUSH BP;
    MOV BP, SP;
    MOV BX, [BP+4]; BX: offset arbol
    MOV AX, [BP+6];
    MOV DS, AX; DS: segmento arbol
    OR AX, BX; arbol != NULL
    MOV AX, 0; AX: cant = 0, no altera flags
    JZ fin;
    PUSH [BX+2];
    PUSH [BX];
    CALL bifurcaciones
    POP AX; AX: bif izq
    PUSH [BX+6];
    PUSH [BX+4];
    CALL bifurcaciones
    POP CX; CX: bif der
    ADD AX, CX;
    MOV CX, [BX];
    OR CX, [BX+2]; arbol->izq != NULL
    JZ fin;
    MOV CX, [BX+4];
    OR CX, [BX+6]; arbol->der != NULL
    JZ fin;
    INC AX; cant++
fin:
    MOV [BP+6], AX;
    MOV AX, [BP+2];
    MOV [BP+4], AX;
    POP BP;
    ADD SP, 2;
    RET;
bifurcaciones ENDP

.ports ; Definición de puertos
; 200: 1,2,3  ; Ejemplo puerto simple
; 201:(100h,10),(200h,3),(?,4)  ; Ejemplo puerto PDDV

.interrupts ; Manejadores de interrupciones
; Ejemplo interrupcion del timer
;!INT 8 1
;  iret
;!ENDINT