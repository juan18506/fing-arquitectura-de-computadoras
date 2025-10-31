#define MENSAJE 0x20
#define STX 0x02
#define ETX 0x03
#define MAX_BUFFER 1024

#define ESTADO_ESPERA_STX 0
#define ESTADO_LEE_CANAL 1
#define ESTADO_LEE_TEXTO 2


char buffer[MAX_BUFFER];
short pcarga;
char estado;

void main() {
    disable();
    // Instalar interrupciones
    estado = ESTADO_ESPERA_STX;
    pcarga = 0;
    enable();
}

// void interrupt
void nuevoChar() {
    char caracter = in(MENSAJE);

    switch (estado) {
    case ESTADO_ESPERA_STX:
        if (caracter == STX) {
            estado = ESTADO_LEE_CANAL;
        }
    break;
    case ESTADO_LEE_CANAL:
        if (caracter == 0) {
            estado = ESTADO_ESPERA_STX;
        } else {
            estado = ESTADO_LEE_TEXTO;
        }
    break;
    case ESTADO_LEE_TEXTO:
        if (caracter == ETX) {
            estado = ESTADO_ESPERA_STX;
        } else {
            buffer[pcarga] = caracter;
            pcarga = (pcarga + 1) % MAX_BUFFER;
        }
    break;
    }
}
