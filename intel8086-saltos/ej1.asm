.data  ; Segmento de datos

.code  ; Segmento de código
ej1 PROC
    ADD AX, BX;
    JNO finif;
    PUSH DX;
    MOV DX, 0x0800;
    MOV DS, DX;
    POP DX;
    MOV DS:[0x0100], AX;
    MOV DS:[0x0102], BX;
    MOV DS:[0x0104], CX;
    MOV DS:[0x0106], DX;
    MOV DS:[0x0108], SI;
    MOV DS:[0x010A], DI;
finif:
    RET;
ej1 ENDP
.ports ; Definición de puertos
; 200: 1,2,3  ; Ejemplo puerto simple
; 201:(100h,10),(200h,3),(?,4)  ; Ejemplo puerto PDDV

.interrupts ; Manejadores de interrupciones
; Ejemplo interrupcion del timer
;!INT 8 1
;  iret
;!ENDINT
