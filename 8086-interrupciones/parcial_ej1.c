char hayTransferencia;
short cantTransferir;
short cantTransferidos;

void main() {
    disable();
    // instalar interrupciones
    hayTransferencia = false;
    enable();
}

char programarDMA(int dirInicioES, int dirInicioMEM, char esLecturaES, short cantBytes) {
    if (hayTransferencia) {
        return 0;
    }
    cantTransferir = cantBytes;
    cantTransferidos = 0;
    hayTransferencia = 1;
    OUT(DMA_E_S_INICIO, dirInicioES);
    OUT(DMA_MEM_INICIO, dirInicioMEM);
    OUT(DMA_CONTROL, (esLecturaES & 1) << 15 | (cantBytes & 0xEFFF));
    return 1;
}

void interrupt transferencia() {
    short transferidos = IN(DMA_CANT_BYTES);
    cantTransferidos += transferidos;
    if (cantTransferidos >= cantTransferir) {
        hayTransferencia = 0;
    }
}

