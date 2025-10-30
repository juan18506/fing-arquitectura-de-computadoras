.data  ; Segmento de datos

.code  ; Segmento de código
substr PROC
    XOR BX, BX; BX: post = 0
for1:
    CMP BYTE PTR [BX+SI], 0; texto[post] != '\0'
    JE finfor1;
    MOV AX, BX; BX: cpost, AX: post
    XOR BP, BP; BP: posb = 0
for2:
    CMP BYTE PTR DS:[BP+DI], 0; buscado[posb] == '\0'
    JNE finif1;
    RET;
finif1:
    CMP BYTE PTR [BX+SI], 0; texto[cpost] == '\0'
    JE break;
    MOV DL, DS:[BP+DI];
    CMP DL, [BX+SI]; buscado[posb] != texto[cpost]
    JNE break;
    INC BP;
    INC BX;
    JMP for2;
break:
    MOV BX, AX;
    INC BX;
    JMP for1;
finfor1:
    MOV AX, -1;
    RET;
substr ENDP

.ports ; Definición de puertos
; 200: 1,2,3  ; Ejemplo puerto simple
; 201:(100h,10),(200h,3),(?,4)  ; Ejemplo puerto PDDV

.interrupts ; Manejadores de interrupciones
; Ejemplo interrupcion del timer
;!INT 8 1
;  iret
;!ENDINT
