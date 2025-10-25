#define TECLA   0x20


// Variables globales
char rutina_activa, hay_escape_prev;

void main() {
    // instalar interrupciones
    rutina_activa = 0;
    hay_escape_prev = 0;
    enable();
    while (1);
}

// void interrupt
void int_teclado() {
    char caracter = in(TECLA);
    char es_num_valido = caracter == 0x31 || caracter == 0x32 || caracter == 0x33;
    if (rutina_activa) {
        hay_escape_prev = 0;
        if (caracter == 0x1B) {
            rutina_activa = 0;
            jmp(padr());
        }
    } else if (hay_escape_prev && es_num_valido) {
        hay_escape_prev = 0;
        rutina_activa = 1;
        char *nombre_rutina;
        if (caracter == 0x31) nombre_rutina = "RUTINA1";
        if (caracter == 0x32) nombre_rutina = "RUTINA2";
        if (caracter == 0x33) nombre_rutina = "RUTINA3";
        jmp(radr(nombre_rutina));
    } else if (caracter == 0x1B) {
        hay_escape_prev = 1;
    } else {
        hay_escape_prev = 0;
    }
}
