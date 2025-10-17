int toUpper(char *str) {
    int cantidad = 0;
    for (int i = 0; str[i] != '\0'; i++) {
        if (str[i] >= 'a' && str[i] <= 'z') {
            str[i] -= 'a' - 'A';
            cantidad++;
        }
    }
    return cantidad;
}
