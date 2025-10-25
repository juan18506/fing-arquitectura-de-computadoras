#define EST_CONT_0  0x10
#define DATO_0      0x11
#define EST_CONT_1  0x12
#define DATO_1      0x13
#define EST_CONT_2  0x14
#define DATO_2      0x15
#define EST_CONT_3  0x16
#define DATO_3      0x17
#define DATO_S      0x20
#define MAX_BUFFER  512


char buffer[MAX_BUFFER];
short pcarga, pdescarga, tope;
char req_trans_manual;

void main() {
    // instalar interrupciones
    pcarga = 0;
    pdescarga = 0;
    tope = 0;
    req_trans_manual = 1;
    enable();
    while (1);
}

// void interrupt
void intEntrada() {
    if (tope < MAX_BUFFER - 1) {
        // solo se lee 1 dato, si hay varios para leer 
        // debería reejecutarse sola intEntrada por def
        // prioridad: dato0 > dato1 > dato2 > dato3
        if (in(EST_CONT_0) & 1) {
            buffer[pcarga] = 0;
            buffer[(pcarga + 1) % MAX_BUFFER] = in(DATO_0);
        } else if (in(EST_CONT_1) & 1) {
            buffer[pcarga] = 1;
            buffer[(pcarga + 1) % MAX_BUFFER] = in(DATO_1);
        } else if (in(EST_CONT_2) & 1) {
            buffer[pcarga] = 2;
            buffer[(pcarga + 1) % MAX_BUFFER] = in(DATO_2);
        } else {
            buffer[pcarga] = 3;
            buffer[(pcarga + 1) % MAX_BUFFER] = in(DATO_3);
        }
        pcarga = (pcarga + 2) % MAX_BUFFER;
        tope += 2;
    }
    if (req_trans_manual) {
        out(DATO_S, buffer[pdescarga]);
        pdescarga = (pdescarga + 1) % MAX_BUFFER;
        tope--;
        req_trans_manual = 0;
    }
}

// void interrupt
void intSalida() {
    if (tope > 0) {
        out(DATO_S, buffer[pdescarga]);
        pdescarga = (pdescarga + 1) % MAX_BUFFER;
        tope--;
        req_trans_manual = 0;
    } else
        req_trans_manual = 1;
}