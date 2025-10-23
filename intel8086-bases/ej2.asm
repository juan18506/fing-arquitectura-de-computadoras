.data  ; Segmento de datos

.code  ; Segmento de código
copia PROC
    MOV BP, AX;
    XOR DI, DI;
for:
    CMP DI, CX;
    JZ endfor;
    MOV DL, ES:[BP+DI];
    MOV ES:[BX+DI], DL;
    INC DI;
    JMP for;

endfor:
    RET;
copia ENDP
.ports ; Definición de puertos
; 200: 1,2,3  ; Ejemplo puerto simple
; 201:(100h,10),(200h,3),(?,4)  ; Ejemplo puerto PDDV

.interrupts ; Manejadores de interrupciones
; Ejemplo interrupcion del timer
;!INT 8 1
;  iret
;!ENDINT
