#define BOTON   0x10
#define LAMPARA 0x11
#define T_900_SEGUNDOS 18000

short dir_abs = 0x34008;
char en_juego;
char lampara_actual, lamparas_prendidas;
short tics;

void main() {
    // instalar interrupciones
    en_juego = 0;
    lampara_actual = 1;
    lamparas_prendidas = 0;
    tics = 0;
    enable();
    while (1);
}

// void interrupt cada 50ms
void timer() {
    if (!en_juego)
        return;
    if (tics < T_900_SEGUNDOS) {
        if ((tics & 1) == 0) { // cambia de lampara cada 2 tics
            do {
                lampara_actual = lampara_actual << 1;
                if (lampara_actual == 0)
                    lampara_actual = 1;
            } while (lamparas_prendidas & lampara_actual);
            out(LAMPARA, lamparas_prendidas | lampara_actual);
        }
        tics++;
    } else {
        en_juego = 0;
        dir_abs = 0xB0B0;
    }
}

// void interrupt
void interruptor() {
    if (!en_juego) {
        en_juego = 1;
        tics = 0;
        lampara_actual = 1;
        lamparas_prendidas = 0;
    } else {
        char boton = in(BOTON);
        char lampara = in(LAMPARA) ^ lamparas_prendidas;
        if (lampara & (1 << boton)) {
            lamparas_prendidas = lamparas_prendidas | lampara;
            out(LAMPARA, lamparas_prendidas);
        }
        if (lamparas_prendidas == 0xFF) {
            en_juego = 0;
            dir_abs = tics;
        }
    }
}
