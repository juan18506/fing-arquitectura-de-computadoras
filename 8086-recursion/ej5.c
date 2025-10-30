#include <stdio.h>

struct Nodo {
    struct Nodo *izq; // offset , segmento
    struct Nodo *der;
    short numero;
};

short cantidadBifurcaciones(struct Nodo *arbol) {
    short cant;
    if (arbol == NULL) {
        cant = 0;
    } else {
        cant = cantidadBifurcaciones(arbol->izq) + cantidadBifurcaciones(arbol->der);
        if (arbol->izq != NULL && arbol->der != NULL) {
            cant++;
        }
    }
    
    return cant;
}