int comparar(char* D1, char* D2, int N) {
    int z = 1;
    for (int i = 0; i < N; i++) {
        if (D1[i] != D2[i]) {
            z = 0;
        }
    }
    
    return z;
}