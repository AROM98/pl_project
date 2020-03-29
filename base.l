%{
#include <string.h>
#include "head.h"
/*char* email;
char* nome;
char* buffer;
*/
%}
%x meta tree makefile filemd filelex readme
qnamef \{\%name\%\}
qemail \{\%email\%\}
qautor \{\%author\%\}
%%
    BEGIN 0;
=== ;
meta {printf("entrei no estado meta\n"); BEGIN meta;}
tree {printf("entrei no estado tree\n"); BEGIN tree;}
Makefile {printf("entrei no estado Makefile\n"); BEGIN makefile;}
{qnamef}\.md {printf("entrei no estado md\n"); BEGIN filemd;}
{qnamef}\.fl {printf("entrei no estado fl\n"); BEGIN filelex;}
README {printf("entrei no estado ReadME\n"); BEGIN readme;}

<meta>=== {printf("vou sair de meta e voltar ao inicio\n"); BEGIN 0;}
<meta>email:\ ([a-z0-9]+\.)*[a-z0-9]+@([a-z0-9]+\.)+[a-z]+ {email =  strdup(yytext+7); 
                                                            printf("seu email é: %s\n", email);}
<meta>author:\ ([a-zA-Z|ç|ã|á|à|â|é]+(\.|\ )*)+ {autor = strdup(yytext+8);
                                            printf("o autor é: %s\n", autor);}
<meta>.|\n ;


<tree>=== {printf("vou sair de tree e voltar ao inicio\n"); BEGIN 0;}
<tree>{qnamef}\/ {dir = strdup(nomefinal); printf("dir : %s\n",dir); dflag = 0; return CREATDIR;}
<tree>\-\ [a-z0-9]+\/ {dflag = 1; dir = strdup(yytext); return CREATDIR;}
<tree>\-\ [a-zA-Z0-9]+(\.[a-z0-9]+)?$ {dflag = 3; dir = strdup(yytext); return CREATDIR;}
<tree>\-\ {qnamef}\.[a-z0-9]+ {dflag = 3; dir = strdup(yytext); return CREATDIR;}

<tree>\-\-\ [a-z0-9]+\/ {dflag = 2; dir = strdup(yytext); return CREATDIR;}
<tree>\-\-\ [a-zA-Z0-9]+(\.[a-z0-9]+)?$ {dflag = 4; dir = strdup(yytext); return CREATDIR;}
<tree>\-\-\ {qnamef}\.[a-z0-9]+ {dflag = 4; dir = strdup(yytext); return CREATDIR;}

<tree>.|\n ;

<makefile>=== {printf("vou sair da makefile e voltar ao inicio\n"); BEGIN 0; return CREATMAKE;}
<makefile>{qnamef} {yytext = nomefinal; strcat(buffer, yytext);}
<makefile>[^===] {strcat(buffer, yytext);}

<filemd>=== {printf("vou sair de filemd e voltar ao inicio\n"); BEGIN 0; return CREATMD;}
<filemd>{qnamef} {yytext = nomefinal; strcat(buffer, yytext);}
<filemd>{qemail} {yytext = email; strcat(buffer, yytext);}
<filemd>{qautor} {yytext = autor; strcat(buffer, yytext);}
<filemd>[^===] {strcat(buffer, yytext);}

<filelex>=== {printf("vou sair de filelex e voltar ao inicio\n"); BEGIN 0; return CREATFL;}
<filelex>[^===] {strcat(buffer, yytext);}

<readme><<EOF>> {printf("README para terminar\n"); return CREATREADME;}
<readme>.* {strcat(buffer, yytext);}


%%





