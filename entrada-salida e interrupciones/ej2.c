#define BOMBA   0x20


void activarBomba() {
    out(BOMBA, in(BOMBA) | 0x04);
    while (!(in(BOMBA) & 0x01));
    out(BOMBA, in(BOMBA) | 0x10);
}

void desactivarBomba() {
    out(BOMBA, in(BOMBA) & 0xFB);
    while (in(BOMBA) & 0x01);
    out(BOMBA, in(BOMBA) & 0xEF);
}
