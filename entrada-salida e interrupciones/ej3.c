#define TECLA 0x20

typedef void rutina;
// Para obtener la dirección de una rutina se dispone de la función
rutina* radr (char *nombre_rutina);
// Para pasar el control a una dirección determinada se usa la función
void jmp(rutina* dirección);
// Para obtener la dirección del programa interrumpido se usa la función
rutina* padr();

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
            rutina *dir = padr();
            jmp(dir);
        }
    } else if (hay_escape_prev && es_num_valido) {
        hay_escape_prev = 0;
        rutina_activa = 1;
        char *nombre_rutina;
        if (caracter == 0x31) nombre_rutina = "RUTINA1";
        if (caracter == 0x32) nombre_rutina = "RUTINA2";
        if (caracter == 0x33) nombre_rutina = "RUTINA3";
        rutina *dir = radr(nombre_rutina);
        jmp(dir);
    } else if (caracter == 0x1B) {
        hay_escape_prev = 1;
    } else {
        hay_escape_prev = 0;
    }
}
