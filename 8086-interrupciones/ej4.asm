; Segmento de datos de DS
.data

BOTON EQU 0x10;
LAMPARA EQU 0x11;
T_900_SEG EQU 18000;
tics DW 0;
en_juego DB 0;
lampara_actual DB 1;
lamparas_prendidas DB 0;

IRQ_TIMER EQU 13;
IRQ_TIMER_OFFSET EQU IRQ_TIMER * 4;
IRQ_TIMER_SEG EQU IRQ_TIMER * 4 + 2;
IRQ_INTERRUPTOR EQU 14;
IRQ_INTERRUPTOR_OFFSET EQU IRQ_INTERRUPTOR * 4;
IRQ_INTERRUPTOR_SEG EQU IRQ_INTERRUPTOR * 4 + 2;

.code  ; Segmento de código

main PROC
    XOR AX, AX;
    MOV ES, AX;
    MOV WORD PTR ES:[IRQ_TIMER_OFFSET], 0x0;
    MOV WORD PTR ES:[IRQ_TIMER_SEG], 0x5590;
    MOV WORD PTR ES:[IRQ_INTERRUPTOR_OFFSET], 0x10C;
    MOV WORD PTR ES:[IRQ_INTERRUPTOR_SEG], 0x5590;
    MOV AX, 0x3400;
    MOV ES, AX;
    STI;
while:
    JMP while;
    RET;
main ENDP

timer PROC FAR
    CMP BYTE PTR CS:[en_juego], 0; if (!en_juego)
    JE fintimer;
    CMP WORD PTR CS:[tics], T_900_SEG; if (tics < T_900_SEGUNDOS)
    JGE else1;
    MOV CX, CS:[tics];
    AND CX, 1; if ((tics & 1) == 0)
    JNZ finif2;
dowhile:
    SHL BYTE PTR CS:[lampara_actual], 1;
    JNZ cmpdowhile; if (lampara_actual == 0)
    INC BYTE PTR CS:[lampara_actual];
cmpdowhile:
    MOV AL, CS:[lamparas_prendidas];
    AND AL, CS:[lampara_actual]; while (lamparas_prendidas & lampara_actual)
    JNZ dowhile;
    MOV DX, LAMPARA;
    MOV AL, CS:[lamparas_prendidas];
    OR AL, CS:[lampara_actual];
    OUT DX, AL; out(LAMPARA, lamparas_prendidas | lampara_actual)
finif2:
    INC WORD PTR CS:[tics];
    JMP fintimer;
else1:
    MOV BYTE PTR CS:[en_juego], 0;
    MOV WORD PTR ES:[8], 0xB0B0;
fintimer:
    IRET;
timer ENDP

interruptor PROC FAR
    CMP BYTE PTR CS:[en_juego], 0; if (!en_juego)
    JNE else2;
    MOV BYTE PTR CS:[en_juego], 1;
    MOV WORD PTR CS:[tics], 0;
    MOV BYTE PTR CS:[lampara_actual], 1;
    MOV BYTE PTR CS:[lamparas_prendidas], 0;
    JMP fininterruptor;
else2:
    MOV DX, BOTON;
    IN AL, DX;
    MOV CL, AL; CL: boton
    MOV DX, LAMPARA;
    IN AL, DX;
    XOR AL, CS:[lamparas_prendidas]; AL: lampara
    MOV AH, 1;
    SHL AH, CL; 1 << boton
    AND CL, AH; if (lampara & (1 << boton))
    JZ finif3;
    OR CS:[lamparas_prendidas], AL;
    MOV AL, CS:[lamparas_prendidas];
    OUT DX, AL; out(LAMPARA, lamparas_prendidas)
finif3:
    CMP BYTE PTR CS:[lamparas_prendidas], 0xFF;
    JNE fininterruptor;
    MOV BYTE PTR CS:[en_juego], 0;
    MOV AX, CS:[tics];
    MOV ES:[8], AX;
fininterruptor:
    IRET;
interruptor ENDP

.ports ; Definición de puertos
; 200: 1,2,3  ; Ejemplo puerto simple
; 201:(100h,10),(200h,3),(?,4)  ; Ejemplo puerto PDDV

.interrupts ; Manejadores de interrupciones
; Ejemplo interrupcion del timer
;!INT 8 1
;  iret
;!ENDINT
