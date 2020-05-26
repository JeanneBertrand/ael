%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tablesymbole.h"
typedef struct _instruct{
        char * inst;
        int a;
        int b;
        int c;
} instruct;
int depth ;
int current_ligne=0;
instruct * labels;

void patch(int from, int to){
        char * i = labels[from].inst ;
        if (i == "JMF"){
                labels[from].b = to;
        } else {
                labels[from].a = to;
        }
        
}
%}

%token tMAIN 
%token tOB 
%token tCB 
%token tCP 
%token tNL
%token tPLUS   
%token tMINUS  
%token tCROSS   
%token tDIV   
%token tEQU   
%token tCOMA  
%token tSC
%token<intValue> tINTEGER tIF tELSE tWHILE tOP
%type<intValue> bodif while condition
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

line    :       declaration tSC
        |       tPRINT tOP tNAME tCP tSC
        |       bodif 
                        {
                        patch($1, current_ligne);
                        }
        |       bodif tELSE
                        {
                        patch($1, current_ligne+1);
                        instruct inst={"JMP",-1,-1,-1};
                        labels[current_ligne]=inst;
                        current_ligne++;
                        $1=current_ligne-1;
                        }
                tOB body tCB
                        {
                        patch($1,current_ligne);
                        }
        |       while
        ;

declaration :   tINT tNAME tEQU math
                        {printf("declaration affectation \n"); 
                        int i=addsymbol($2, false, true, depth); 
                        int j=poptemp();
                        instruct inst={"COP",i,j,-1};
                        labels[current_ligne]=inst;
                        current_ligne++;
                        }
            |   tCONST tINT tNAME tEQU math
                        {printf("declaration affectation \n"); 
                        int i=addsymbol($3, true, true, depth);
                        int j=poptemp();
                        instruct inst={"COP",i,j,-1};
                        labels[current_ligne]=inst;
                        current_ligne++;
                        }
            |   tINT tNAME 
                        {printf("declaration \n") ; addsymbol($2, false, false, depth);}
            |   tCONST tINT tNAME 
                        {printf("declaration \n") ; addsymbol($3, true, false, depth);}
            |   tNAME tEQU math  
                        {printf("affectation \n"); 
                        int i=initsymbol($1, depth);
                        int j=poptemp();
                        instruct inst={"COP",i,j,-1};
                        labels[current_ligne]=inst;
                        current_ligne++;
                        }
            ; 

math    :   math tCROSS math 
                {printf("multipass \n") ;
                int i = poptemp();
                int j= poptemp();
                int k=pushtemp(); 
                instruct inst={"MUL",k,j,i};
                labels[current_ligne]=inst;
                current_ligne++;
                }
        |   math tDIV math 
                {printf("division \n") ;
                int i = poptemp();
                int j= poptemp();
                int k=pushtemp(); 
                instruct inst={"DIV",k,j,i};
                labels[current_ligne]=inst;
                current_ligne++;
                }
        |   math tPLUS math 
                {printf("addition \n") ;
                int i = poptemp();
                int j= poptemp();
                int k=pushtemp(); 
                instruct inst={"ADD",k,j,i};
                labels[current_ligne]=inst;
                current_ligne++;
                }
        |   math tMINUS math 
                {printf("soustraction \n") ;
                int i = poptemp();
                int j= poptemp();
                int k=pushtemp(); 
                instruct inst={"SOU",k,j,i};
                labels[current_ligne]=inst;
                current_ligne++;
                }
        |   tMINUS math 
                {printf("moins\n") ;
                int i = poptemp();
                int j =pushtemp();
                instruct inst={"AFC",j,0,-1};
                labels[current_ligne]=inst;
                current_ligne++;
                j = poptemp();
                int k=pushtemp(); 
                instruct inst2= {"SOU",k,j,i};
                labels[current_ligne]=inst2;
                current_ligne++;
                } %prec tCROSS
        |   value            
        ;


bodif     :     tIF tOP condition tCP 
                        {printf("debut if \n"); 
                        depth ++;
                        printf("JMF \n");
                        int k = poptemp();
                        instruct inst={"JMF",k,-1,-1};
                        labels[current_ligne]=inst;
                        current_ligne++;
                        $1 = current_ligne-1;
                        } 
                tOB body tCB
                        {
                        $$ = $1;
                        printf("fin if \n"); 
                        deletesymbol(depth) ; 
                        depth --;
                        }
        ;

while :         tWHILE 
                        {
                                $1=current_ligne;
                        }
                tOP condition tCP
                        {
                                int k = poptemp();
                                instruct inst={"JMF",k,-1,-1};
                                labels[current_ligne]=inst;
                                $3 = current_ligne;
                                current_ligne++;
                        }
                tOB body tCB
                        {
                                int i =$1 ;
                                instruct inst={"JMP",i,-1,-1};
                                labels[current_ligne]=inst;
                                current_ligne++;
                                i = $3;
                                patch(i,current_ligne);
                        }

        ;
condition : value tEQU tEQU value 
                {printf("checking condition \n");
                int i = poptemp();
                int j = poptemp();
                int k = pushtemp();
                instruct inst={"EQU",k,j,i};
                labels[current_ligne]=inst;
                current_ligne++;
                }
        ;

value   : tINTEGER 
                {printf("int %d \n",yylval.intValue) ; 
                int i=pushtemp();
                instruct inst={"AFC",i,$1,-1};
                labels[current_ligne]=inst;
                current_ligne++;
                }
        | tNAME 
                {printf("variable %s \n", yylval.stringValue) ;
                int i = findsymbol($1, depth);
                int j=pushtemp();
                instruct inst={"COP",j,i,-1};
                labels[current_ligne]=inst;
                current_ligne++;
                }
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

FILE * print_asm(){
        FILE * asmFile = fopen( "asm.asm", "w" );
        instruct instr;
        for (int i=0; i<current_ligne;i++){
                instr = labels[i];
                if (instr.b == -1){
                        fprintf(asmFile,"%s %d\n", instr.inst, instr.a);
                } else if (instr.c == -1){
                        fprintf(asmFile,"%s %d %d\n", instr.inst, instr.a, instr.b);
                }else {
                        fprintf(asmFile,"%s %d %d %d\n", instr.inst, instr.a, instr.b, instr.c);
                }
        }
        return asmFile;
}

int main()
{
        depth=0;
        init();
        labels = malloc(1024 * sizeof(instruct));
        yyparse();
        FILE * asmFile= print_asm();
        if (depth!=0) {printf("erreur! depth !=0 fin programme\n");}
        if (fclose(asmFile) != 0) {printf("erreur de fermeture du fichier");}
} 

