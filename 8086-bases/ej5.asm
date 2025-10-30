.data  ; Segmento de datos

.code  ; Segmento de código
ej5 PROC
    XOR AX, AX; AX: suma = 0
    XOR SI, SI; SI: i
do:
    ADD AX, ES:[BX+SI]; suma += vector[i]
    JC fin;
    ADD SI, 2;
    CMP SI, 2048;
    JB do;
    XOR SI, SI;
fin:
    SHR SI, 1;
    MOV AX, SI;
    RET;
ej5 ENDP

.ports ; Definición de puertos
; 200: 1,2,3  ; Ejemplo puerto simple
; 201:(100h,10),(200h,3),(?,4)  ; Ejemplo puerto PDDV

.interrupts ; Manejadores de interrupciones
; Ejemplo interrupcion del timer
;!INT 8 1
;  iret
;!ENDINT
