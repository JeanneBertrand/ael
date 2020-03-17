%{
#include <stdio.h>
#include <string.h>
 
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
        yyparse();
} 

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
%token<intValue> tINTEGER 
%token<stringValue> tNAME
%token tCONST 
%token tINT   
%token tPRINT 
%type<intValue> math value
%right tEQU
%left tPLUS tMINUS
%left tCROSS tDIV

%union 
{
    int intValue;
    char *stringValue;
}

%%
input   : tINT tMAIN tOP tCP tOB body tCB {printf("main \n"); }
        ;   

body    :   line tSC body
        |   line tSC
        ; 

line    :   declaration
        |   affectation
        |   tPRINT tOP tNAME tCP
        ;

declaration : tINT tNAME 
            | tCONST tINT tNAME
            ;

affectation : tNAME tEQU math 
            ; 

math    :   value tCROSS math {$$ = $1 * $3 ;}
        |   value tDIV math {$$ = $1 / $3 ;}
        |   value tPLUS math {$$ = $1 + $3 ;}
        |   value tMINUS math {$$ = $1 - $3 ;}
        |   tMINUS value {$$ = - $2 ;} %prec tCROSS
        |   value                   
        ;

value   : tINTEGER {$$ = $1 ;}
        | tNAME {$$ = $1;}
        ;
