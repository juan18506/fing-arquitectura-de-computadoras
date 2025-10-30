.data  ; Segmento de datos

.code  ; Segmento de código
comparar PROC
    ; Suponemos D1 = AX, D2 = BX, N = CX
    MOV BP, AX;
    XOR SI, SI;
    MOV AL, 1;

for:
    CMP SI, CX;
    JZ endfor;
    MOV AH, DS:[BP+SI]
    CMP [BX+SI], AH;
    JZ finif;
    XOR AL, AL;
finif:
    INC SI;
    JMP for;

endfor:
    CMP AL, 1;
    RET;
comparar ENDP
.ports ; Definición de puertos
; 200: 1,2,3  ; Ejemplo puerto simple
; 201:(100h,10),(200h,3),(?,4)  ; Ejemplo puerto PDDV

.interrupts ; Manejadores de interrupciones
; Ejemplo interrupcion del timer
;!INT 8 1
;  iret
;!ENDINT
