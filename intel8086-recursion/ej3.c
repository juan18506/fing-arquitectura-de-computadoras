#include <stdbool.h>

struct Nodo {
    short dato;
    unsigned char hijoIzq, hijoDer;
};
struct Nodo arbol[256];

bool ej3(short buscado, unsigned char i) {
    if (i == 0) {
        return false;
    } else if (buscado == arbol[i].dato) {
        return true;
    } else if (buscado < arbol[i].dato) {
        return ej3(buscado, arbol[i].hijoIzq);
    } else if (buscado > arbol[i].dato) {
        return ej3(buscado, arbol[i].hijoDer);
    }
}