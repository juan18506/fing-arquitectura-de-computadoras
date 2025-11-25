#define CONSUMO 0x20
#define CONTROL_EV 0x21
#define ESTADO_DNM 0x22
#define SIRENA 0x23
#define T_2_HORAS 5 * 60*60*2
#define T_20_MINUTOS 5 * 60*20
#define T_1_MINUTO 5 * 60


short tics[8];
short consumo[8];
char consulta[8];
char electrovalvula, sirena;
short tics_sirena;

void main() {
    // instalar interrupciones
    for (int i = 0; i < 8; i++) {
        tics[i] = T_2_HORAS;
        consumo[i] = 0;
        consulta[i] = 1;
        out(CONSUMO+i, 0x00);
    }
    sirena = 0;
    tics_sirena = T_1_MINUTO;
    electrovalvula = 0xFF;
    out(CONTROL_EV, electrovalvula);
    enable();
    while (1) {};
    return;
}

// 5hz
void interrupt tiempo() {
    for (int i = 0; i < 8; i++) {
        tics[i]--;
        if (tics == 0) {
            electrovalvula = electrovalvula & (0xFE << i);
            consulta[i] = 1
            sirena = 1;
            out(SIRENA, sirena);
        }
        if (sirena) {
            tics_sirena--;
            if (!tics_sirena) {
                sirena = 0;
                out(SIRENA, sirena);
                tics_sirena = T_1_MINUTO;
            }
        }
    }
    return;
}

void interrupt caudal() {
    char dnm = in(ESTADO_DNM);
    char elec_debajo = ~electrovalvula & ~dnm;
    if (elec_debajo) {
        for (int i = 0; i < 8; i++) {
            if (consulta[i] && (elec_debajo & (0x01 << i))) {
                consulta[i] = 0;
                tics[i] = T_20_MINUTOS;
            }
        }
    }
    char cant_activos = 0;
    for (int i = 0; i < 8; i++) {
        if (electrovalvula & (1 << i)) {
            cant_activos++;
        }
    }
    for (int i = 0; i < 8; i++) {
        if (electrovalvula & (1 << i)) {
            consumo[i] += 1/cant_activos;
            out(CONSUMO+i, consumo[i])
        }
    }
    return;
}

