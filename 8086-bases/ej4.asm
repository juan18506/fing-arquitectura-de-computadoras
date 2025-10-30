.data  ; Segmento de datos

.code  ; Segmento de código
busqueda PROC
    ; el = AL, inicio = BX, final = DI
    MOV CX, -1;
    XOR SI, SI;
    SUB DI, BX;
    ; Si DI apunta al primer el fuera de la tabla habria que hacer INC DI
for:
    CMP SI, DI;
    JE endfor;
    CMP ES:[BX+SI], AL;
    JNE finif;
    MOV CX, SI;
finif:
    INC SI;
    JMP for;
endfor:
    RET;
busqueda ENDP

.ports ; Definición de puertos
; 200: 1,2,3  ; Ejemplo puerto simple
; 201:(100h,10),(200h,3),(?,4)  ; Ejemplo puerto PDDV

.interrupts ; Manejadores de interrupciones
; Ejemplo interrupcion del timer
;!INT 8 1
;  iret
;!ENDINT
