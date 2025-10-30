; Segmento de datos de DS
.data

IRQ_BOTON EQU 9;
IRQ_GRUA EQU 31;
IRQ_BOTON_OFFSET EQU IRQ_BOTON * 4;
IRQ_BOTON_SEG EQU IRQ_BOTON * 4 + 2;
IRQ_GRUA_OFFSET EQU IRQ_GRUA * 4;
IRQ_GRUA_SEG EQU IRQ_GRUA * 4 + 2;
JOYSTICK EQU 0x60;
MOTOR EQU 0x80;
en_juego DB 1;

.code  ; Segmento de código

main PROC
    XOR AX, AX;
    MOV ES, AX;
    MOV WORD PTR ES:[IRQ_BOTON_OFFSET], OFFSET boton;
    MOV WORD PTR ES:[IRQ_BOTON_SEG], SEGMENT boton;
    MOV WORD PTR ES:[IRQ_GRUA_OFFSET], OFFSET gruaLiberada;
    MOV WORD PTR ES:[IRQ_GRUA_SEG], SEGMENT gruaLiberada;
    STI;
while:
    CMP BYTE PTR [en_juego], 1;
    JNE finif1;
    MOV DX, JOYSTICK;
    IN AL, DX;
    AND AL, 0x0F;
    CMP AL, 1;
    JNE else;
    MOV CL, 4;
    SHL AL, CL;
    OR AL, 1;
    MOV DX, MOTOR;
    OUT DX, AL;
    JMP finif2;
else:
    MOV DX, MOTOR;
    OUT DX, AL;
finif2:
finif1:
    JMP while;
    RET;
main ENDP

boton PROC FAR
    PUSH DX;
    PUSH AX;
    MOV BYTE PTR DS:[en_juego], 0;
    MOV DX, MOTOR;
    MOV AL, 2;
    OUT DX, AL;
    POP AX;
    POP DX;
    RET;
boton ENDP

gruaLiberada PROC FAR
    MOV BYTE PTR DS:[en_juego], 1;
    RET;
gruaLiberada ENDP

.ports ; Definición de puertos
; 200: 1,2,3  ; Ejemplo puerto simple
; 201:(100h,10),(200h,3),(?,4)  ; Ejemplo puerto PDDV

.interrupts ; Manejadores de interrupciones
; Ejemplo interrupcion del timer
;!INT 8 1
;  iret
;!ENDINT
