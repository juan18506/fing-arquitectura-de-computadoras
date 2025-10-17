void removerEspacios(char* str, char* res) {
    int j = 0;
    for (int i = 0; str[i] != '\0'; i++) {
        if (str[i] != 0x20) {
            res[j] = str[i];
            j++;
        }
    }
    res[j] = '\0';
    return;
}