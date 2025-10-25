#define LUCES 0x20
#define _45_SEG 45


char tics;

void main() {
    disable();
    // instalar interrupciones
    tics = 0;
    enable();
}

// void interrupt
void tiempo() {
    if (tics > 0) {
        tics--;
        if (tics == 0)
            out(LUCES, 0);
    }
}

// void interrupt
void boton() {
    out(LUCES, 1);
    tics = _45_SEG;
}
