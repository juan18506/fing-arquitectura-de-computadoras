#define ESTADO_1    0x11
#define ESTADO_2    0x12
#define ESTADO_3    0x13


void main() {
    // instalar interrupciones
    enable();
    while (1);
}

// void interrupt
void int_dispositivos() {
    // esquema de prioridades fijas: disp1 > disp2 > disp3
/*
    if (in(ESTADO_1) & 1)
        atencionDispositivo1();
    else if (in(ESTADO_2) & 1)
        atencionDispositivo2();
    else if (in(ESTADO_3) & 1)
        atencionDispositivo3();
*/
    // esquema de prioridades variables
    char disp_activo = 0;
    char max_prio = -1;
    char prio;

    if (in(ESTADO_1) & 1) {
        prio = pri(1);
        if (prio > max_prio) {
            max_prio = prio;
            disp_activo = 1;
        }
    }
    if (in(ESTADO_2) & 1) {
        prio = pri(2);
        if (prio > max_prio) {
            max_prio = prio;
            disp_activo = 2;
        }
    }
    if (in(ESTADO_3) & 1) {
        prio = pri(3);
        if (prio > max_prio) {
            max_prio = prio;
            disp_activo = 3;
        }
    }

    // atender el de mayor prioridad
    switch (disp_activo) {
        case 1: atencionDispositivo1(); break;
        case 2: atencionDispositivo2(); break;
        case 3: atencionDispositivo3(); break;
        default: break;
    }
}
