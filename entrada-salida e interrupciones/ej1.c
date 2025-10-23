#define ESTADO_TECLADO
#define DATO_TECLADO

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
