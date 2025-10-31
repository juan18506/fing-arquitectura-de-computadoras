; Segmento de datos de DS
.data

SENSOR EQU 0x20;
ACCESORIO EQU 0x40;
ESTADO_SEGURO EQU 1;
ESTADO_PELIGROSO EQU 2;
ESTADO_VALVULA_CERRADA EQU 3;
T_30_SEG EQU 300;
tics DW 0;
IRQ_TIEMPO EQU 9;
IRQ_TIEMPO_OFFSET EQU IRQ_TIEMPO * 4;
IRQ_TIEMPO_SEG EQU IRQ_TIEMPO * 4 + 2;

.code  ; Segmento de código

main PROC
    XOR AX, AX;
    MOV ES, AX;
    MOV WORD PTR ES:[IRQ_TIEMPO_OFFSET], 0xA;
    MOV WORD PTR ES:[IRQ_TIEMPO_SEG], 0x3340;
    MOV AH, ESTADO_SEGURO; AH: Estado
    STI;
while:
    MOV DX, SENSOR;
    IN AL, DX;
    AND AL, 1; 
    MOV BL, AL; BL: conc_peligrosa
    CMP AH, ESTADO_SEGURO; case ESTADO_SEGURO:
    JNE case_peligroso;
    CMP BL, 0; if (conc_peligrosa)
    JE finif1;
    MOV DX, ACCESORIO;
    IN AL, DX; 
    OR AL, 1;
    OUT DX, AL;
    MOV WORD PTR [tics], T_30_SEG;
    MOV AH, ESTADO_PELIGROSO;
finif1:
    JMP finswitch;
case_peligroso:
    CMP AH, ESTADO_PELIGROSO; case ESTADO_PELIGROSO:
    JNE case_valvula_cerrada;
    CMP BL, 0; if (!conc_peligrosa)
    JNE elseif;
    MOV DX, ACCESORIO;
    IN AL, DX;
    AND AL, 0xFE;
    OUT DX, AL; out(ACCESORIO, in(ACCESORIO) & 0xFE)
    MOV AH, ESTADO_SEGURO;
    JMP finif2;
elseif:
    CMP WORD PTR [tics], 0; else if (tics == 0)
    JNE finif2;
    MOV DX, ACCESORIO;
    IN AL, DX;
    AND AL, 0xFD;
    OUT DX, AL; out(ACCESORIO, in(ACCESORIO) & 0xFD)
    MOV AH, ESTADO_VALVULA_CERRADA;
finif2:
    JMP finswitch; 
case_valvula_cerrada:
    CMP BL, 0; if (!conc_peligrosa)
    JNE finif3;
    MOV DX, ACCESORIO;
    IN AL, DX;
    AND AL, 0xFE;
    OUT DX, AL; out(ACCESORIO, in(ACCESORIO) & 0xFE)
finif3:
finswitch:
    JMP while;
    RET;
main ENDP

tiempo PROC FAR
    CMP WORD PTR CS:[tics], 0; if (tics > 0)
    JLE finif;
    DEC WORD PTR CS:[tics];
finif:
    IRET;
tiempo ENDP

.ports ; Definición de puertos
; 200: 1,2,3  ; Ejemplo puerto simple
; 201:(100h,10),(200h,3),(?,4)  ; Ejemplo puerto PDDV

.interrupts ; Manejadores de interrupciones
; Ejemplo interrupcion del timer
;!INT 8 1
;  iret
;!ENDINT
