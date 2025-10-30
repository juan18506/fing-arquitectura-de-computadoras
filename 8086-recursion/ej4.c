#include <stdio.h>

struct Nodo {
    struct Nodo *izq;
    struct Nodo *der;
    short numero;
};

short profundidad(struct Nodo *arbol) {
    short prof;
    if (arbol != NULL) {
        short profizq = 1 + profundidad(arbol->izq);
        short profder = 1 + profundidad(arbol->der);
        if (profizq > profder) {
            prof = profizq;
        } else {
            prof = profder;
        }
    } else {
        prof = -1;
    }
    return prof;
}