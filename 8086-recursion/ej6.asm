; Segmento de datos de DS
.data

.code  ; Segmento de código
moverDisco PROC
    RET;
moverDisco ENDP


torres PROC
    ; [BP+8] n, [BP+6] i, [BP+4] j, [BP+2] IP
    PUSH BP;
    MOV BP, SP;
    CMP WORD PTR [BP+8], 1; if (n == 1)
    JNE else;
    PUSH [BP+6];
    PUSH [BP+4];
    CALL moverDisco; moverDisco(i, j);
    JMP fin;
else:
    MOV CX, 6;
    SUB CX, [BP+6];
    SUB CX, [BP+4]; CX: k = 6-i-j;
    PUSH CX; guardo k en [BP-2]
    MOV AX, [BP+8]; AX: n;
    DEC AX;
    PUSH AX; guardo n-1 en [BP-4]
    PUSH AX;
    PUSH [BP+6];
    PUSH CX;
    CALL torres; torres(n-1, i, k);
    MOV AX, 1;
    PUSH AX;
    PUSH [BP+6];
    PUSH [BP+4];
    CALL torres; torres(1, i, j);
    PUSH [BP-4];
    PUSH [BP-2];
    PUSH [BP+4];
    CALL torres; torres(n-1, k, j);
    POP AX; quito n-1 y k del stack
    POP CX;
fin:
    ; Alineo el stack
    ; [BP+8] IP, luego basura
    MOV AX, [BP+2]; AX: IP
    MOV [BP+8], AX;
    POP BP;
    ADD SP, 6;
    RET;
torres ENDP

.ports ; Definición de puertos
; 200: 1,2,3  ; Ejemplo puerto simple
; 201:(100h,10),(200h,3),(?,4)  ; Ejemplo puerto PDDV

.interrupts ; Manejadores de interrupciones
; Ejemplo interrupcion del timer
;!INT 8 1
;  iret
;!ENDINT