; Segmento de datos de DS
.data

BOMBA EQU 0x20
TECLA EQU 0x21
IRQ_TECLADO EQU 4;
IRQ_TECLADO_OFFSET EQU IRQ_TECLADO * 4;
IRQ_TECLADO_SEG EQU IRQ_TECLADO * 4 + 2;

.code  ; Segmento de código

main PROC
    XOR AX, AX;
    MOV ES, AX;
    MOV WORD PTR ES:[IRQ_TECLADO_OFFSET], 0x4;
    MOV WORD PTR ES:[IRQ_TECLADO_SEG], 0x4102;
    STI; enable()
    RET;
main ENDP

activarBomba PROC
    in AL, BOMBA;
    OR AL, 0x04;
    out BOMBA, AL;
while_apagado:
    in AL, BOMBA;
    AND AL, 0x01;
    JZ while_apagado;
    IN AL, BOMBA;
    OR AL, 0x10;
    out BOMBA, AL;
    RET;
activarBomba ENDP

desactivarBomba PROC
    in AL, BOMBA;
    AND AL, 0xFB;
    out BOMBA, AL;
while_encendido:
    in AL, BOMBA;
    AND AL, 0x01;
    JNZ while_encendido;
    IN AL, BOMBA;
    AND AL, 0xEF;
    out BOMBA, AL;
    RET;
desactivarBomba ENDP

teclado PROC FAR
; codigo
    IRET;
teclado ENDP

.ports ; Definición de puertos
; 200: 1,2,3  ; Ejemplo puerto simple
; 201:(100h,10),(200h,3),(?,4)  ; Ejemplo puerto PDDV

.interrupts ; Manejadores de interrupciones
; Ejemplo interrupcion del timer
;!INT 8 1
;  iret
;!ENDINT
