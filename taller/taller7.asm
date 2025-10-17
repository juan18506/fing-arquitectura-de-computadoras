; Segmento de datos de DS
.data

.code  ; Segmento de código
; POSIBLES INVOCACIONES en 0x12345
; MOV AX, 5;
; MOV BX, 0x1234;
; MOV ES, BX;
; CALL toUpper;

; MOV AX, 15;
; MOV BX, 0x1224;
; MOV ES, BX;
; CALL toUpper;

toUpper PROC
    ; ES:[AX]: str, retornar en CX
    MOV BX, AX;
    XOR CX, CX; cantidad = 0
    XOR DI, DI; i = 0
for:
    CMP BYTE PTR ES:[BX+DI], 0; str[i] != '\0'
    JE finfor;
    CMP BYTE PTR ES:[BX+DI], 0x7A; str[i] <= 'z'
    JNLE finif;
    CMP BYTE PTR ES:[BX+DI], 0x61; str[i] >= 'a'
    JNGE finif;
    SUB BYTE PTR ES:[BX+DI], 0x20; str[i] -= 'a' - 'A'
    INC CX; cantidad++
finif:
    INC DI; i++
    JMP for;
finfor:
    RET;
toUpper ENDP

.ports ; Definición de puertos
; 200: 1,2,3  ; Ejemplo puerto simple
; 201:(100h,10),(200h,3),(?,4)  ; Ejemplo puerto PDDV

.interrupts ; Manejadores de interrupciones
; Ejemplo interrupcion del timer
;!INT 8 1
;  iret
;!ENDINT
