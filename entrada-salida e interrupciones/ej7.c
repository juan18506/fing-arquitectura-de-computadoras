#define SENSOR 0x20
#define ACCESORIO 0x40
#define ESTADO_SEGURO 1
#define ESTADO_PELIGROSO 2
#define ESTADO_VALVULA_CERRADA 3
#define _30_SEG 300


short tics;

void main() {
    // instalar interrupciones
    tics = 0;
    char estado = ESTADO_SEGURO;
    enable();
    while (1) {
        char conc_peligrosa = in(SENSOR) & 1;

        switch (estado) {
        case ESTADO_SEGURO:
            if (conc_peligrosa) {
                out(ACCESORIO, in(ACCESORIO) | 1);
                tics = _30_SEG;
                estado = ESTADO_PELIGROSO;
            }
        break;
        case ESTADO_PELIGROSO:
            if (!conc_peligrosa) {
                out(ACCESORIO, in(ACCESORIO) & 0xFE);
                estado = ESTADO_SEGURO;
            } else if (tics == 0) {
                out(ACCESORIO, in(ACCESORIO) & 0xFD);
                estado = ESTADO_VALVULA_CERRADA;
            }
        break;
        case ESTADO_VALVULA_CERRADA:
            if (!conc_peligrosa)
                out(ACCESORIO, in(ACCESORIO) & 0xFE);
        break;
        }
    }
}

// void interrupt
void tiempo() {
    if (tics > 0)
      tics--;
}
