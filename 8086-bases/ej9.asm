; Segmento de datos de DS
.data
CANT_MATRICES EQU 20        ; cantidad de matrices
PESOS_MATRICES DW DUP(CANT_MATRICES) 0 ; arreglo de pesos, 20 shorts inicializados a 0
MATRICES DW  DUP(320) 0 ; 20 matrices de 4x4 shorts = 16 shorts por matriz

.code  ; Segmento de código
sumaMatrices PROC
    XOR BX, BX; BX: i
    MOV DX, CANT_MATRICES;
    SHL DX, 1; como short 2 bytes sumo 2 a i por lo tanto comparo con 2*CANT_MATRICES
fori:
    CMP BX, DX; i < CANT_MATRICES
    JNL finfori;
    MOV WORD PTR DS:[BX+PESOS_MATRICES], 0; pesosMatrices[i] = 0
    XOR AX, AX; AX: j
forj:
    CMP AX, 4; j < 4
    JNL finforj;
    XOR CX, CX; CX: k
fork:
    CMP CX, 4;
    JNL finfork;
    MOV SI, ES:[MATRICES]; SI: posicion matrices[i][j][k]
    MOV DI, BX;
    PUSH CX;
    MOV CL, 4;
    SHL DI, CL; i * 32 , me muevo en las matrices, recordar estamos con 2i por lo que desplazamos 4 lugares en lugar de 5
    ADD SI, DI;
    MOV DI, AX;
    MOV CL, 3;
    SHL DI, CL; j * 8 , me muevo en las filas
    POP CX;
    ADD SI, DI;
    MOV DI, CX;
    SHL DI, 1;
    ADD SI, DI; sumo la pos de la columna
    ; tengo en ES:[SI] la posicion de memoria inicial de matrices[i][j][k]
    MOV DI, ES:[SI]; DI: matrices[i][j][k]
    ADD DS:[BX+PESOS_MATRICES], DI;
finfork:
    INC AX; j++;
    JMP forj;
finforj:
    ADD DX, 2; i++
    JMP fori;
finfori:
    RET;
sumaMatrices ENDP

.ports ; Definición de puertos
; 200: 1,2,3  ; Ejemplo puerto simple
; 201:(100h,10),(200h,3),(?,4)  ; Ejemplo puerto PDDV

.interrupts ; Manejadores de interrupciones
; Ejemplo interrupcion del timer
;!INT 8 1
;  iret
;!ENDINT
