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
                        {printf("main before body \n") ; depth++;} 
                body tCB 
                        {printf("main \n"); depth--;}
        ;   

body    :       line 
                        {printf("line before body \n") ;} 
                body 
                        {printf("line ; body \n") ;}
        |       line 
                        {printf("line  \n") ;}
        |   
        ; 

line    :   declaration tSC
        |   affectation tSC
        |   tPRINT tOP tNAME tCP tSC
        |   tIF tOP condition tCP bodif tELSE bodif
        |   tIF tOP condition tCP bodif 
        ;

declaration :   tINT tNAME 
                        {printf("declaration \n") ; addsymbol($2, false, false, depth);}
            |   tCONST tINT tNAME 
                        {printf("declaration \n") ; addsymbol($3, true, false, depth);}
            ;

affectation :   tNAME tEQU math  
                        {printf("affectation \n");}
            |   declaration tEQU math
                        {printf("declaration affectation \n");}
            ; 

math    :   value tCROSS math {printf("multipass \n") ;}
        |   value tDIV math {printf("division \n") ;}
        |   value tPLUS math {printf("addition \n") ;}
        |   value tMINUS math {printf("soustraction \n") ;}
        |   tMINUS value {printf("moins\n") ;} %prec tCROSS
        |   value                   
        ;

bodif     :     tOB 
                        {printf("debut if \n"); depth ++;}
                body tCB
                        {printf("fin if \n"); depth --;}
        ;

condition : value tEQU tEQU value ;

value   : tINTEGER {printf("int %d \n",yylval.intValue) ;}
        | tNAME {printf("variable %s \n", yylval.stringValue) ;}
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
        yyparse();
        if (depth!=0) {printf("erreur! depth !=0 fin programme\n");}
} 

