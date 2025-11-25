void buscoMayor(unsigned char indice, out short mayor, out char indiceMayor) {
    unsigned short mayorI, mayorD;
    unsigned char indiceI, indiceD;
    if (indice == 0) {
        mayor = 0;
        indiceMayor = 0;	
    } else {
    	buscoMayor(arbol[indice].hijoIzq, mayorI, indiceI);	
    	buscoMayor(arbol[indice].hijoDer, mayorD, indiceD);
		if (mayorD > mayorI) {
		    mayor = mayorD;
		    indiceMayor = indiceD;
	    } else { 
		    mayor = mayorI;
		    indiceMayor = indiceI;
		}
		if (arbol[indice].dato > mayor) {
		    mayor = arbol[indice].dato;
		    indiceMayor = indice;
		}
    }
}
