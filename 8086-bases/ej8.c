short substr(char* texto, char* buscado) {
    for (short post = 0; texto[post] != '\0'; post++) {
        short cpost = post;
        short posb = 0;
        for (short posb = 0; ; posb++, cpost++) {
            if (buscado[posb] == '\0') {
                return post;
            }   
            if (texto[cpost] == '\0' || buscado[posb] != texto[cpost]) {
                break;
            }
        }
    }
    return -1;
}
