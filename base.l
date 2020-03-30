%{
#include <string.h>
#include "head.h"
/*char* email;
char* nome;
char* buffer;

<tree>\-\-\ [a-z0-9]+\/ {dflag = 2; dir = strdup(yytext); return CREATDIR;}
<tree>\-\-\ [a-zA-Z0-9]+(\.[a-z0-9]+)?$ {dflag = 4; dir = strdup(yytext); return CREATDIR;}
<tree>\-\-\ {qnamef}\.[a-z0-9]+ {dflag = 4; dir = strdup(yytext); return CREATDIR;}


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


*/
%}
%x meta tree makefile filemd filelex readme ficheiro
qnamef \{\%name\%\}
qemail \{\%email\%\}
qautor \{\%author\%\}
%%
    BEGIN 0;
=== ;
meta {printf("entrei no estado meta\n"); BEGIN meta;}
tree {printf("entrei no estado tree\n"); BEGIN tree;}
[a-zA-Z0-9]+\.[a-zA-Z0-9]+ {printf("entrei no estado ficheiro\n"); nomefich = strdup(yytext); BEGIN ficheiro;}
[a-zA-Z0-9]+ {printf("entrei no estado ficheiro\n"); nomefich = strdup(yytext); BEGIN ficheiro;}
{qnamef}\.[a-zA-Z0-9]+ {printf("entrei no estado ficheiro\n"); extensao = strdup(yytext + 8);
                nomefich = strdup(nomefinal); strcat(nomefich, extensao); BEGIN ficheiro;}


<meta>=== {printf("vou sair de meta e voltar ao inicio\n"); BEGIN 0;}
<meta>email:\ ([a-z0-9]+\.)*[a-z0-9]+@([a-z0-9]+\.)+[a-z]+ {email = strdup(yytext+7); 
                                                            printf("seu email é: %s\n", email);}
<meta>author:\ ([a-zA-Z|ç|ã|á|à|â|é]+(\.|\ )*)+ {autor = strdup(yytext+8);
                                            printf("o autor é: %s\n", autor);}
<meta>.|\n ;


<tree>=== {printf("vou sair de tree e voltar ao inicio\n"); BEGIN 0;}
<tree>{qnamef}\/ {dir = strdup(nomefinal); printf("dir : %s\n",dir); dflag = 0; return CREATDIR;}
<tree>\-\ [a-z0-9]+\/ {dflag = 1; dir = strdup(yytext); return CREATDIR;}

<tree>\-+\ [a-zA-Z0-9]+\/ {dflag = 1; dir = strdup(yytext); return CREATDIR;}

<tree>\-\ [a-zA-Z0-9]+(\.[a-z0-9]+)?$ {dflag = 3; dir = strdup(yytext); return CREATDIR;}
<tree>\-\ {qnamef}\.[a-z0-9]+ {dflag = 3; dir = strdup(yytext); return CREATDIR;}

<tree>.|\n ;


<ficheiro>=== {printf("vou sair do FICHEIRO e voltar ao inicio\n"); BEGIN 0; return CREATFICH;}
<ficheiro>{qnamef} {yytext = nomefinal; strcat(buffer, yytext);}
<ficheiro>{qemail} {yytext = email; strcat(buffer, yytext);}
<ficheiro>{qautor} {yytext = autor; strcat(buffer, yytext);}
<ficheiro>[^===] {strcat(buffer, yytext);}


%%





