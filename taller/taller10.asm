; Segmento de datos de DS
.data

JOYSTICK EQU 0x60;
MOTOR EQU 0x80;
en_juego DB 1;

IRQ_BOTON EQU 9;
IRQ_GRUA EQU 31;
IRQ_BOTON_OFFSET EQU IRQ_BOTON * 4;
IRQ_BOTON_SEG EQU IRQ_BOTON * 4 + 2;
IRQ_GRUA_OFFSET EQU IRQ_GRUA * 4;
IRQ_GRUA_SEG EQU IRQ_GRUA * 4 + 2;


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
    CMP BYTE PTR [en_juego], 0; if (en_juego)
    JE finif;
    MOV DX, JOYSTICK;
    IN AL, DX;
    AND AL, 0x0F; AL: movimiento
    JZ else; if (movimiento)
    MOV CL, 4;
    SHL AL, CL;
    OR AL, 1; AL: (movimiento << 4) | 1
    MOV DX, MOTOR;
    OUT DX, AL; out(MOTOR, (movimiento << 4) | 1)
    JMP finif;
else:
    MOV DX, MOTOR;
    OUT DX, AL; out(MOTOR, 0)
finif:
    JMP while;
    RET;
main ENDP

boton PROC FAR
    PUSH DX;
    PUSH AX;
    MOV BYTE PTR CS:[en_juego], 0;
    MOV DX, MOTOR;
    MOV AL, 2;
    OUT DX, AL; out(MOTOR, 2)
    POP AX;
    POP DX;
    IRET;
boton ENDP

gruaLiberada PROC FAR
    MOV BYTE PTR CS:[en_juego], 1;
    IRET;
gruaLiberada ENDP

.ports ; Definición de puertos
; 200: 1,2,3  ; Ejemplo puerto simple
; 201:(100h,10),(200h,3),(?,4)  ; Ejemplo puerto PDDV

.interrupts ; Manejadores de interrupciones
; Ejemplo interrupcion del timer
;!INT 8 1
;  iret
;!ENDINT
