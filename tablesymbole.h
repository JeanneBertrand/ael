#define false 0
#define true 1 

typedef struct variable {
    char * id ;
     int constante ;
     int initialized ;
    int depth ;
} symbol ;

void init (void);

int addsymbol (char * id,  int constante,  int initialized, int depth) ;

int findsymbol (char * id, int depth);

int initsymbol (char * id, int depth);

void deletesymbol(int depth);

int pushtemp(void);

int poptemp(void);

