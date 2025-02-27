/* Scanner para uma linguagem de programacao parecida com Pascal */

%{
/* include necessario para a chamada da funcao atof() abaixo */
#include <math.h>
%}


DIGITO    [0-9]
ID        [a-z][a-z0-9]*



%%

{DIGITO}+    {
     		    printf( "Um inteiro: %s (%d)\n", yytext,
             	atoi( yytext ) );
     	     }

{DIGITO}+"."{DIGITO}*        {
     		    printf( "Um real: %s (%g)\n", yytext,
                atof( yytext ) );
              }

if|then|begin|end|procedure|function        {
     		printf( "Uma palavra reservada: %s\n", yytext );
     	      }

{ID}	printf( "Um identificador: %s\n", yytext );

"+"|"-"|"*"|"/"   printf( "Um operador: %s\n", yytext );

"{"[\^{}}\n]*"}"     /* consome comentários de uma linha */

[ \t\n]+             /* consome brancos */

.           printf( "Caracter nao reconhecido: %s\n", yytext );

%%

int main( int argc, char **argv ) {
	++argv, --argc;  /* pula o nome do programa */
	if ( argc > 0 )
     		yyin = fopen( argv[0], "r" );
	else
     		yyin = stdin;

	yylex();
}
