#define JOYSTICK 0x9
#define MOTOR 0x31

char en_juego;

void main() {
	// Instalar interrupciones
	en_juego = 1;
	enable();
	while (1) {
		if (en_juego) {
			char movimiento = in(JOYSTICK) & 0x0F;
			if (movimiento)
				out(MOTOR, (movimiento << 4) | 1);
			else
				out(MOTOR, 0);
		}
	}
}

// void interrupt
void boton() {
	en_juego = 0;
	out(MOTOR, 2);
}

// void interrupt
void gruaLiberada() {
	en_juego = 1;
}
