#define DISPLAY_HI 0x20
#define DISPLAY_LO 0x40
#define MOTOR 0x60
#define BOTONES 0x80

short tics, tics_cinta;
char prendido, velocidad, cont_cinta;

void main() {
    // Instalo interrupciones
    tics = 0, tics_cinta = 0, cont_cinta = 0, prendido = 0, velocidad = 0;
    enable();
    while (1);
}

// void interrupt
void cinta() { cont_cinta++; }

// void interrupt
void tiempo() {
    if (prendido) {
        char alarma, vel_cinta;
        tics++, tics_cinta++;
        if (tics_cinta == 30) {
            vel_cinta = (cont_cinta / 3) * 10;
            if (velocidad == (vel_cinta / 10)) {
                alarma = 1;
            } else {
                alarma = 0;
            }
        }
        cont_cinta = 0;
        short display = (alarma << 15) | (prendido << 14) | (vel_cinta << 7);
        out(DISPLAY_HI, display);
        out(DISPLAY_LO, tics);
    } else {
        out(DISPLAY_HI, 0);
        out(DISPLAY_LO, 0);
    }
}

// void interrupt
void hay_boton() {
    char estado = in(BOTONES) & 0x07;
    if (estado == 1) {
        out(MOTOR, 0);
        tics = 0, prendido = 0;
    } else if (estado == 2) {
        out(MOTOR, (0x32 << 1) | 1);
        prendido = 1, velocidad = 5;
    } else {
        out(MOTOR, (0x6E << 1) | 1);
        prendido = 1, velocidad = 11;
    }
    tics_cinta = 0;
}
