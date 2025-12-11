typedef struct {
    short valor;
    nodo* izq;
    nodo* der;
} nodo;

void invertir_arbol(nodo* arbol) {
    if (arbol == NULL) {
        return;
    }
    invertir_arbol(arbol->izq);
    invertir_arbol(arbo->der);
    nodo* temp = arbol->izq;
    arbol->izq = arbol->der;
    arbol->der = temp;
}

