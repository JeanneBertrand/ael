#define false 0
#define true 1 

typedef struct variable {
    char * id ;
     int constante ;
     int initialized ;
    int depth ;
} symbol ;


void addsymbol (char * id,  int constante,  int initialized, int depth) ;

int findsymbol (char * id, int depth);

