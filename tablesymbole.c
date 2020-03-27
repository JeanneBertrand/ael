#include "tablesymbole.h"

symbol tab [100] = {"1null",false,false,0};

void addsymbol (char * id,  int constante,  int initialized, int depth) {
    int i =0;
    while ( (i< sizeof(tab)) && (tab[i].id!="1null") ) {
        i ++;
    } if (i != sizeof(tab)) {
        symbol newsym ={id, constante, initialized, depth};
        tab[i]=newsym;
    }
}


int findsymbol (char * id, int depth) {
    for (int i=0;i<sizeof(tab);i++) {
        if ( (tab[i].id == id) && (tab[i].depth == depth) ){
            return i;
        }
    }
    return -1;
}