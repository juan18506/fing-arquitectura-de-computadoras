.data


.code
buscoMayor PROC
    ; [BP+4] = indice, [BP+2] IP
    PUSH BP;
    MOV BP, SP;
    PUSH AX;
    PUSH BX;
    PUSH CX;
    PUSH DX;
    PUSH DI;
    PUSH SI;
    XOR BX, BX;
    MOV BL, [BP+2];
    CMP BL, 0; if indice == 0
    JNE else;
    XOR DI, DI; DI: mayor
    XOR SI, SI; SI = indiceMayor
    JMP fin;
else:
    SHL BX, 1;
    SHL BX, 1;
    PUSH ES:[BX]; hijoIzq
    CALL buscoMayor;
    POP SI; SI = indiceI
    POP DI; DI = mayorI
    PUSH ES:[BX+1]; hijoDer
    POP CX; CX = indiceD
    POP DX; DX = mayorD
    CMP DX, AX; if mayorD > mayorI
    JB finif;
    MOV DI, DX; mayor = mayorD
    MOV SI, CX; indiceMayor = indiceD
finif:
    CMP WORD PTR ES:[BX+2], DI; if dato > mayori
    JNA fin;
    MOV DI, ES:[BX+2]; mayor = dato
    MOV SI, BX; indiceMayor = indice
fin:
    ; Alineo stack [BP] = IP, [BP+2] = indiceMayor; [BP+4] mayor
    MOV BX, [BP+2]; BX = IP;
    MOV [BP], BX;
    MOV [BP+2], SI;
    MOV [BP+4], DI;
    POP SI;
    POP DI;
    POP DX;
    POP CX;
    POP BX;
    POP AX;
    RET;
buscoMayor ENDP

