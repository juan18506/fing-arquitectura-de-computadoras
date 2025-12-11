.data
hayTransferencia DB 0
cantTransferir DW 0
cantTransferidos DW 0

.code
main PROC
    CLI;
    MOV BX, 1;
    MOV ES, BX;
    MOV WORD PTR ES:[61], OFFSET transferencia;
    MOV WORD PTR ES:[63], SEGMENT transferencia;
    MOV WORD PTR DS:[hayTransferencia], 1;
    STI;
    RET;
main ENDP

transferencia PROC FAR
    PUSH DX;
    PUSH AX;
    MOV DX, DMA_CANT_BYTES;
    IN AX, DX;
    ADD CS:[cantTransferidos],AX;
    MOV AX, CS:[cantTransferidos];
    CMP AX, CS:[cantTransferir];
    JL fin;
    MOV BYTE PTR CS:[hayTransferencia], 0;
fin:
    POP AX;
    POP DX;
    IRET;
transferencia ENDP

