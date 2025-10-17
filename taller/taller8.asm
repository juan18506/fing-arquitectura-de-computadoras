; Segmento de datos de DS
.data

.code  ; Segmento de código

buscarABB PROC
    ; [BP+8] arbol, [BP+6] indice, [BP+4] valor, [BP+2] IP
    PUSH BP;
    MOV BP, SP;
    MOV BX, [BP+8]; BX: arbol
    MOV DI, [BP+6]; DI: indice
    SHL DI, 1; DI: pos relativa del valor arbol[indice]
    MOV BX, ES:[BX+DI]; BX: arbol[indice]
    CMP BX, -1; if (arbol[indice] == -1)
    JNE finif1;
    XOR AX, AX; return false
    JMP fin;
finif1:
    CMP BX, [BP+4]; if (arbol[indice] == valor)
    JNE else1;
    MOV AX, 1; return true
    JMP fin;
else1:
    CMP BX, [BP+4]; if (arbol[indice] > valor)
    JLE else2;
    INC DI;
    PUSH [BP+8];
    PUSH DI;
    PUSH [BP+4];
    CALL buscarABB;
    POP AX; return buscarABB(arbol, (2*indice)+1, valor)
    JMP fin;
else2:
    ADD DI, 2;
    PUSH [BP+8];
    PUSH DI;
    PUSH [BP+4];
    CALL buscarABB;
    POP AX; return buscarABB(arbol, (2*indice)+2, valor)
fin:
    ; Alineo el stack
    ; [BP+8] resultado, [BP+6] IP, el resto basura
    MOV [BP+8], AX;
    MOV AX, [BP+2]; AX: IP
    MOV [BP+6], AX;
    POP BP;
    ADD SP, 4;
    RET;
buscarABB ENDP

.ports ; Definición de puertos
; 200: 1,2,3  ; Ejemplo puerto simple
; 201:(100h,10),(200h,3),(?,4)  ; Ejemplo puerto PDDV

.interrupts ; Manejadores de interrupciones
; Ejemplo interrupcion del timer
;!INT 8 1
;  iret
;!ENDINT
