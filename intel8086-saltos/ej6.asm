.data  ; Segmento de datos

.code  ; Segmento de código
ej6 PROC
    XOR SI, SI; SI: i
    MOV BP, DI; resultado en ES:[BP], liberamos DI para indice
    XOR DI, DI; DI: j
    MOV DL, 0x00; DL: caracter nul
    MOV DH, 0x20; DH: caracter espacio
for:
    CMP ES:[BX+SI], DL; str[i] != '\0'
    JE finfor;
    CMP ES:[BX+SI], DH; str[i] != 0x20
    JE finif;
    MOV CL, ES:[BX+SI];
    MOV ES:[BP+DI], CL;
    INC DI;
finif:
    INC SI;
    JMP for;
finfor:
    MOV ES:[BP+DI], DL; res[j] = '\0';
    RET;
ej6 ENDP

.ports ; Definición de puertos
; 200: 1,2,3  ; Ejemplo puerto simple
; 201:(100h,10),(200h,3),(?,4)  ; Ejemplo puerto PDDV

.interrupts ; Manejadores de interrupciones
; Ejemplo interrupcion del timer
;!INT 8 1
;  iret
;!ENDINT
