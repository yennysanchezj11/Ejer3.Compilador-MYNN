%{
  #include "mynn.tab.h"
%}

NUMBER      [0-9]+(\.[0-9]+)?
TEXT        '.{0,15}'
BOOLEAN        ("true"|"false")
NAME_VAR    ([a-z]+([a-zA-Z0-9]+)?){1,10}
MATH_OPE    ("+"|"-"|"*"|"/")
OPERATORS_COM   (<|>|>=|<=|==|!=)
OPERATORS_LOG   ("&&"|"||"|"!")

%%

{NUMBER}        return NUM;
{TEXT}          return TXT;
{BOOLEAN}       return BOOL;
"if"            return IF;
"else"          return ELSE;
"while"         return WHILE;
"var"           return VAR;
{MATH_OPE}      return MATH;
{NAME_VAR}      return NAME_VAR;
{OPERATORS_COM} return COMPARATOR;
{OPERATORS_LOG} return LOGIC;
"{"             return KO;
"}"             return KC; 
"("             return BO;
")"             return BC;    
"="             return EQ;    
\n              return EOL;
[ \t]+          {}
.                {printf("Error lexico %s\n", yytext);}
%%