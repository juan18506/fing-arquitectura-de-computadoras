#define TECLADO             0x20
#define BARRAS              0x21
#define DISPLAY             0x22
#define ESTADO_ABIERTA      0x10
#define ESTADO_CERRADA      0x11
#define ESTADO_BLOQUEADA    0x12
#define _2_HORAS            14400
#define _5_SEGUNDOS         10
#define MAX_SECUENCIA       8


char secuencia[MAX_SECUENCIA];
char clave[MAX_SECUENCIA];
char tics, tics_reset;
char pcarga, pdescarga, tope;
char hay_espacio;

void main() {
    // instalar interrupciones
    tics = 0, tics_reset = 0;
    pcarga = 0, pdescarga = 0, tope = 0;
    hay_espacio = 0;
    char tope_clave = 0;
    char estado = ESTADO_ABIERTA;
    char intentos = 0;
    enable();
    while (1) {
        switch (estado) {
        case ESTADO_ABIERTA:
            if (hay_espacio && tope >= 4) {
                out(BARRAS, 0x80);
                estado = ESTADO_CERRADA;
                hay_espacio = 0;
                char igual = 0;
                for (char i = 0; i < tope; i++) {
                    clave[i] = secuencia[pdescarga];
                    pdescarga = (pdescarga + 1) % MAX_SECUENCIA;
                }
                tope_clave = tope;
                pcarga = 0, pdescarga = 0, tope = 0;
            }
        break;
        case ESTADO_CERRADA:
        char clave_correcta = 1;
            if (tope == tope_clave)
                for (char i = 0; i < tope_clave; i++) {
                    if (secuencia[pdescarga] != clave[i])
                        clave_correcta = 0;
                    pdescarga = (pdescarga + 1) % MAX_SECUENCIA;
                }
            else
                clave_correcta = 0;
            if (hay_espacio && clave_correcta) {
                out(BARRAS, 1);
                estado = ESTADO_ABIERTA;
                intentos = 0;
                pcarga = 0, pdescarga = 0, tope = 0;
            } else if (hay_espacio) {
                out(DISPLAY, 0xFFFFFFFF);
                intentos++;
                if (intentos == 3) {
                    estado = ESTADO_BLOQUEADA;
                    tics = _2_HORAS;
                }
                pcarga = 0, pdescarga = 0, tope = 0;
            }
        break;
        case ESTADO_BLOQUEADA:
            if (tics == 0) {
                estado = ESTADO_CERRADA;
                intentos = 0;
            } else if (hay_espacio)
                out(DISPLAY, 0xFFFFFFFF);
        break;
        }
    }
}

// void interrupt
void tecla() {
    char digito = in(TECLADO);
    tics_reset = _5_SEGUNDOS;
    if ((digito & 0x0F) == 0xD0)
        hay_espacio = 1;
    else {
        secuencia[pcarga] = (digito & 0xF0) >> 4;
        pcarga = (pcarga + 1) % MAX_SECUENCIA;
        tope++;
        if (tope > MAX_SECUENCIA) {
            pdescarga = (pdescarga + 1) % MAX_SECUENCIA;
            tope = MAX_SECUENCIA;
        }
        hay_espacio = 0;
        // out(DISPLAY, codigo BCD)
    }
}

// void interrupt // 2hz
void tiempo() {
    if (tics_reset > 0) {
        tics_reset--;
        if (tics_reset == 0) {
            out(DISPLAY, 0xEEEEEEEE);
            pcarga = 0, pdescarga = 0, tope = 0;
        }
    }
    if (tics > 0)
        tics--;
}
