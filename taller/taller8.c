#include <stdbool.h>

short buscarABB(short *arbol, short indice, short valor) {
    if (arbol[indice] == -1)
        return false;
    if (arbol[indice] == valor)
        return true;
    else if (arbol[indice] > valor)
        return buscarABB(arbol, (2*indice)+1, valor);
    else
        return buscarABB(arbol, (2*indice)+2, valor);
}
