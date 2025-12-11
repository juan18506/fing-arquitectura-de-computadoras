.code
invertir_arbol PROC
    PUSH BP;
    MOV BP, SP;
    PUSH BX;
    MOV BX, [BP+4];
    CMP BX, 0;
    JZ fin;
    PUSH ES:[BX+2];
    CALL invertir_arbol;
    PUSH ES:[BX+4];
    CALL invertir_arbol;
    ; invertir
    MOV AX, ES:[BX+2];
    MOV CX, ES:[BX+4];
    MOV ES:[BX+2], CX;
    MOV ES:[BX+4], AX;
fin:
    MOV BX, [BP+2];
    MOV [BP+4], BX;
    POP BX;
    POP BP;
    ADD SP, 2;
    RET;
invertir_arbol ENDP

