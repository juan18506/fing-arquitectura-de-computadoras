#define N 20

struct Item {
    char c;
    short siguiente;
};
struct Item lista[N];

void ConstruirCadena(short indiceLista, char *bufferDestino) {
    if (indiceLista < 0)
        *bufferDestino = '\0';
    else {
        *bufferDestino = lista[indiceLista].c;
        ConstruirCadena(lista[indiceLista].siguiente, bufferDestino + 1);
    }
}

