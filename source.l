/*définitions*/

DIGIT   [0-9]
EXP [eE][-+]?{DIGIT}+
NAME    [a-zA-Z][a-zA-Z0-9_]*
%{
#include "y.tab.h"

%}

%%

main  {
            //printf("Main\n"); 
            return tMAIN ;
        }

\{   {
        //printf("Open bracket\n"); 
        return tOB ;
    }

\}   {
        //printf("Closing bracket\n"); 
        return tCB ;
    }

\(   {
        //printf("Open parenthesis\n"); 
        return tOP ;
    }

\)   {
        //printf("Closing parenthesis\n"); 
        return tCP ;
    }

\+  { 
        //printf("Plus\n"); 
        return tPLUS ;
    }

\-  {
        //printf("Minus\n"); 
        return tMINUS ; 
    }

\*  {
        //printf("Cross\n"); 
        return tCROSS ;
    }

\/   {
        //printf("Divide\n"); 
        return tDIV ;
    }

=   {
        //printf("Equal\n"); 
        return tEQU ; 
    }

[\b\t]+ {
            //printf("\b");
        }
[\n]+ {
            //printf("\n"); 
        }
,  {
        //printf("Coma\n");
        return tCOMA ;
    }

;  {
        //printf("Semicolon\n");
        return tSC ;
    }

{DIGIT}+     | 
{DIGIT}+{EXP}   {
                   //printf("Integer %s\n", yytext); 
                   yylval.intValue = atoi(yytext);
                   return tINTEGER;
                }

const   {
            //printf("const\n") ;
            return tCONST ; 
        } 

int    {
            //printf("Integer\n");
            return tINT;
       }

printf  {
            //printf("printf\n");
            return tPRINT;
        }

if      {
            //printf("if\n");
            return tIF;
        }

else    {
            //printf("else\n");
            return tELSE;
        }

{NAME}  {
            //printf("Name %s\n", yytext);
            yylval.stringValue = strdup(yytext) ; 
            return tNAME ;
        }

    
%% 


















