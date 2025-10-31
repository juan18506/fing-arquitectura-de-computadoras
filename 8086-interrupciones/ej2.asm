; Segmento de datos de DS
.data

MENSAJE EQU 0x20;
STX EQU 0x02;
ETX EQU 0x03;
MAX_BUFFER EQU 1024;
estado DB 0;

ESTADO_ESPERA_STX EQU 0;
ESTADO_LEE_CANAL EQU 1;
ESTADO_LEE_TEXTO EQU 2;

IRQ_NUEVO_CHAR EQU 9;
IRQ_NUEVO_CHAR_OFFSET EQU IRQ_NUEVO_CHAR * 4;
IRQ_NUEVO_CHAR_SEG EQU IRQ_NUEVO_CHAR * 4 + 2;

.code  ; Segmento de código

main PROC
    CLI; disable()
    PUSH ES;
    PUSH AX;
    XOR AX, AX;
    MOV ES, AX;
    MOV WORD PTR ES:[IRQ_NUEVO_CHAR_OFFSET], OFFSET nuevoChar;
    MOV WORD PTR ES:[IRQ_NUEVO_CHAR_SEG], SEGMENT nuevoChar;
    MOV BYTE PTR [estado], ESTADO_ESPERA_STX;
    POP AX;
    POP ES;
    STI; enable()
    RET;
main ENDP

nuevoChar PROC FAR
    PUSH DX;
    PUSH AX;
    PUSH BX;
    MOV DX, MENSAJE;
    IN AL, DX; AL: caracter
    CMP BYTE PTR CS:[estado], ESTADO_ESPERA_STX; case ESTADO_ESPERA_STX:
    JNE case_lee_canal;
    CMP AL, STX; if (caracter == STX)
    JNE fin;
    MOV BYTE PTR CS:[estado], ESTADO_LEE_CANAL;
    JMP fin;
case_lee_canal:
    CMP BYTE PTR CS:[estado], ESTADO_LEE_CANAL; case ESTADO_LEE_CANAL:
    JNE case_lee_texto;
    CMP AL, 0; if (caracter == 0)
    JNE else1;
    MOV BYTE PTR CS:[estado], ESTADO_ESPERA_STX;
    JMP fin;
else1:
    MOV BYTE PTR CS:[estado], ESTADO_LEE_TEXTO;
    JMP fin;
case_lee_texto:
    CMP AL, ETX; if (caracter == ETX)
    JNE else2;
    MOV BYTE PTR CS:[estado], ESTADO_ESPERA_STX;
    JMP fin;
else2:
    MOV BX, ES:[0]; BX: pcarga
    MOV ES:[BX+2], AL; buffer[pcarga] = caracter
    INC BX;
    MOV AX, BX;
    XOR DX, DX;
    MOV BX, MAX_BUFFER;
    DIV BX;
    MOV ES:[0], DX; pcarga = (pcarga + 1) % MAX_BUFFER
fin:
    POP BX;
    POP AX;
    POP DX;
    IRET;
nuevoChar ENDP

.ports ; Definición de puertos
; 200: 1,2,3  ; Ejemplo puerto simple
; 201:(100h,10),(200h,3),(?,4)  ; Ejemplo puerto PDDV

.interrupts ; Manejadores de interrupciones
; Ejemplo interrupcion del timer
;!INT 8 1
;  iret
;!ENDINT
