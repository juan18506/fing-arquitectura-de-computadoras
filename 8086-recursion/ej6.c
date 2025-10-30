/*
* n: nro de discos total
* i: nro de discos en la torre inicial
* j: nro de discos en la torre objetivo
*/
void torres(short n, short i, short j) {
    short k;
    if (n == 1) {
        moverDisco(i, j); /* Mueve disco de torre i a j */
    } else {
        k = 6-i-j;
        torres(n-1, i, k);
        torres(1, i, j);
        torres(n-1, k, j);
    }
}
