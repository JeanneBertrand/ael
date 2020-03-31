#include "tablesymbole.h"
#include <stdio.h>
#include <string.h>
#include <signal.h>
#include <stdlib.h>

symbol tab [100];
int temptab [10];
int sizetab;

void init (void) {
    sizetab = sizeof(tab)/sizeof(tab[0]);
    printf("debut init \n");
    symbol nulsym = {"1null",false,true,0};
    printf("size tab %d \n",sizetab);
    for (int i=0;i<sizetab;i++) {
        tab[i]=nulsym;
    }
    for (int i=0;i<10;i++) {
        temptab[i]=-1;
    }
}

int addsymbol (char * id,  int constante,  int initialized, int depth) {
    int i =0;
    while ( (i< sizetab )&& (tab[i].id!="1null") ) {
        printf("id %s const %d init %d depth %d \n",tab[i].id, tab[i].constante, tab[i].initialized, tab[i].depth);
        i ++;
    }
     if (i != sizetab) {
        symbol newsym ={id, constante, initialized, depth};
        tab[i]=newsym;
        printf("id %s const %d init %d depth %d \n",tab[i].id, tab[i].constante, tab[i].initialized, tab[i].depth);
        return i;
    }
    return -1;

}


int findsymbol (char * id, int depth) {
    for (int i=0;i<sizetab;i++) {
        if ( !(strcmp(tab[i].id, id)) && (tab[i].depth <= depth) ){
            return i;
        }
    }
    return -1;
}

int initsymbol (char * id, int depth) {
    int indice = findsymbol(id, depth);
    if (indice==-1) {
        fprintf(stderr, "%s", "erreur : variable non déclarée!\n");
        exit(-1);
    } else {
        tab[indice].initialized=true;
        return indice;
    }
}

void deletesymbol(int depth) {
    symbol nulsym = {"1null",false,false,0};
    for (int i=0;i<sizetab;i++) {
        if (tab[i].depth == depth){
            tab[i]=nulsym;
        }
    }
}

int pushtemp(void){
    int i=0;
    while ( (i<10 )&& (temptab[i]!=-1) ) {
        i ++;
    }
     if (i != 10) {
        temptab[i]=3;
        return 200+i;
    }
    return -1;
}

int poptemp(void){
    int i=0;
    while ( (i<10 )&& (temptab[i]!=-1) ) {
        i ++;
    }
     if (i != 10) {
         temptab[i-1]=-1;
        return 200+i-1;
    }
    return -1;
}