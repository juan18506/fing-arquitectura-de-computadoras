#define CANT_MATRICES 20

typedef short matriz[4][4];

short pesosMatrices[CANT_MATRICES];
matriz matrices[CANT_MATRICES];

void sumaMatrices() {
    for (short i = 0; i < CANT_MATRICES; i++) {
        pesosMatrices[i] = 0;

        for (short j = 0; j < 4; j++) {
            for (short k = 0; k < 4; k++) {
                pesosMatrices[i] += matrices[i][j][k];
            }
        }
    }

    return;
}