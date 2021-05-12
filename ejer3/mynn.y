%{
#include <stdio.h>   
#include <stdlib.h>
extern int yylex(void);
extern char *yytext;
void yyerror(char *s); 
extern FILE * yyin;
%}

%token TXT BOOL  NUM  VAR  NAME_VAR IF ELSE WHILE  MATH COMPARATOR LOGIC KO KC BO BC EQ EOL 



%start Input
%%

Input: | Input Line;

Line:   EOL | Variable EOL 
            | Matematicas EOL 
            | Condicional EOL
            | Ciclo EOL
            ;

Variable: VAR NAME_VAR                            {printf("Codigo Correcto VAR \n");} 
        | VAR NAME_VAR EQ TXT                     {printf("Codigo Correcto VAR \n");}
        | VAR NAME_VAR EQ NUM                     {printf("Codigo Correcto VAR \n");}
        | VAR NAME_VAR EQ BOOL                    {printf("Codigo Correcto VAR \n");}
        | NAME_VAR EQ TXT                         {printf("Codigo Correcto VAR \n");}
        | NAME_VAR EQ NUM                         {printf("Codigo Correcto VAR \n");}
        | NAME_VAR EQ BOOL                        {printf("Codigo Correcto VAR \n");}
        | error                                   {printf("Error de sintaxis\n");};
        ;
        
      

Matematicas: Expresion MATH Expresion             {printf("Codigo Correcto MATH \n");} 
        | BO Expresion BC { $$ = $2; }             
        | NUM { $$ = $1; } 
        | NAME_VAR { $$ = $1; }     
        | error {printf("Error math \n");};
        ;


Condicional: IF BO Expresion BC KO Cuerpo KC        {printf("Codigo Correcto IF \n");} 
        | ELSE IF BO Expresion BC KO Cuerpo KC 
        | ELSE KO Cuerpo KC
        | error {printf("Error in conditional\n");};
        ;

        
Ciclo   : WHILE BO Expresion BC KO Cuerpo KC         {printf("Codigo Correcto WHILE \n");} 
        | error {printf("Error in while definition\n");};
        ;


Cuerpo:   Variable 
        | Matematicas 
        ;

Expresion: Expresion COMPARATOR Expresion             
        | NUM {$$ = $1;}
        | NAME_VAR {$$ = $1;}
        | BOOL {$$ = $1;}
        | TXT {$$ = $1;}
        ;
%%


void yyerror(char *s){
  //  printf("Error: %s\n", s);
}

int main(int argc, char **argv) {
	// si hay argumentos cargue el archivo como entrada
    yyin = (argc > 1) ? fopen(argv[1],"r") : stdin;  
    yyparse();
    return 0;
}
