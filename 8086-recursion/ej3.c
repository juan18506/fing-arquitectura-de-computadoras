struct Nodo {
    short dato;
    unsigned char hijoIzq, hijoDer;
};
struct Nodo arbol[256];

bool ej3(short buscado, unsigned char i) {
    if (i == 0) {
        return 0;
    } else if (buscado == arbol[i].dato) {
        return 1;
    } else {
        char estaIzq = ej3(buscado, arbol[i].hijoIzq);
        char estaDer = ej3(buscado, arbol[i].hijoDer);
        return estaIzq | estaDer;
    }
}
