#include <limits.h>

short posCarrySuma(short vector[1024]) {
    unsigned short suma = 0;
    unsigned short i = 0;
    do {
        suma += vector[i];
        if (_carry()) {
            return i;
        }
        i++;
    } while (i < 1024);
    
    return 0;
}
