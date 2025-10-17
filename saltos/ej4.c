#include <stdio.h>

char* busqueda(char* inicio, char* final, char el) {
    char* posicion = NULL;
    for (char* dir = inicio; dir != final; dir++) {
        if (*dir == el) {
            posicion = dir;
        }
    }
    
   return posicion; 
}