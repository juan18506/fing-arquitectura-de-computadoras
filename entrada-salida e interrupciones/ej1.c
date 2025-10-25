#define ESTADO_TECLADO  0x20
#define DATO_TECLADO    0x21

struct Lista *lista;


void leerCaracteres() {
    while (1) {
        char estado = in(ESTADO_TECLADO);
        if (estado & 0x80) {
            char caracter = in(DATO_TECLADO);
            insertar(lista, caracter);
        }
    }
}
