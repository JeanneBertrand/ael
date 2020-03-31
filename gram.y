%{
#include <stdio.h>
#include <string.h>
#include "tablesymbole.h"

int depth ;
%}

%token tMAIN 
%token tOB 
%token tCB 
%token tOP 
%token tCP 
%token tNL
%token tPLUS   
%token tMINUS  
%token tCROSS   
%token tDIV   
%token tEQU   
%token tCOMA  
%token tSC    
%token tIF
%token tELSE
%token<intValue> tINTEGER 
%token<stringValue> tNAME
%token tCONST 
%token tINT   
%token tPRINT 
%right tEQU
%left tPLUS tMINUS
%left tCROSS tDIV

%union 
{
    int intValue;
    char *stringValue;
}



%%
input   :       tINT tMAIN tOP tCP tOB 
                        { depth++;} 
                body tCB 
                        {printf("main \n"); deletesymbol(depth); depth--;}
        ;   

body    :       line body 
        |       line 
        |   
        ; 

line    :   declaration tSC
        |   tPRINT tOP tNAME tCP tSC
        |   tIF tOP condition tCP bodif tELSE bodif
        |   tIF tOP condition tCP bodif 
        ;

declaration :   tINT tNAME tEQU math
                        {printf("declaration affectation \n"); 
                        int i=addsymbol($2, false, true, depth); 
                        int j=poptemp();
                        printf("COP %d %d\n",i,j);}
            |   tCONST tINT tNAME tEQU math
                        {printf("declaration affectation \n"); 
                        int i=addsymbol($3, true, true, depth);
                        int j=poptemp();
                        printf("COP %d %d\n",i,j);}
            |   tINT tNAME 
                        {printf("declaration \n") ; addsymbol($2, false, false, depth);}
            |   tCONST tINT tNAME 
                        {printf("declaration \n") ; addsymbol($3, true, false, depth);}
            |   tNAME tEQU math  
                        {printf("affectation \n"); 
                        int i=initsymbol($1, depth);
                        int j=poptemp();
                        printf("COP %d %d\n",i,j);}

            ; 

math    :   math tCROSS math 
                {printf("multipass \n") ;
                int i = poptemp();
                int j= poptemp();
                int k=pushtemp(); 
                printf("MUL %d %d %d\n",k, j, i);
                }
        |   math tDIV math 
                {printf("division \n") ;
                int i = poptemp();
                int j= poptemp();
                int k=pushtemp(); 
                printf("DIV %d %d %d\n",k, j, i);
                }
        |   math tPLUS math 
                {printf("addition \n") ;
                int i = poptemp();
                int j= poptemp();
                int k=pushtemp(); 
                printf("ADD %d %d %d\n",k, j, i);
                }
        |   math tMINUS math 
                {printf("soustraction \n") ;
                int i = poptemp();
                int j= poptemp();
                int k=pushtemp(); 
                printf("SOU %d %d %d\n",k, j, i);
                }
        |   tMINUS math 
                {printf("moins\n") ;
                int i = poptemp();
                int j =pushtemp();
                printf("AFC %d %d \n",j, 0 );
                j = poptemp();
                int k=pushtemp(); 
                printf("SOU %d %d %d\n",k, j, i);
                } %prec tCROSS
        |   value            
        ;


bodif     :     tOB 
                        {printf("debut if \n"); depth ++;}
                body tCB
                        {printf("fin if \n"); deletesymbol(depth) ; depth --;}
        ;

condition : value tEQU tEQU value ;

value   : tINTEGER 
                {printf("int %d \n",yylval.intValue) ; 
                int i=pushtemp();
                printf("AFC %d %d\n",i,$1); }
        | tNAME 
                {printf("variable %s \n", yylval.stringValue) ;
                int i = findsymbol($1, depth);
                int j=pushtemp();
                printf("COP %d %d \n",j,i);}
        ;

%%




void yyerror(const char *str)
{
        fprintf(stderr,"error: %s\n",str);
}
 
int yywrap()
{
        return 1;
} 
  
int main()
{
        depth=0;
        init();
        yyparse();
        if (depth!=0) {printf("erreur! depth !=0 fin programme\n");}
} 

