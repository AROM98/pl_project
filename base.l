%{
#include "head.h"
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <stdlib.h>

/*
char* email;
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
int i = 0;
char* cona[50];
tree arvore;
char* path;
char* tmppath;
%}
%x meta tree ficheiro
qnamef \{\%name\%\}
qemail \{\%email\%\}
qautor \{\%author\%\}
%%
    BEGIN 0;
=== ;
meta {printf("entrei no estado meta\n"); BEGIN meta;}
tree {printf("entrei no estado tree\n"); BEGIN tree;}
[a-zA-Z0-9]+\.[a-zA-Z0-9]+ {printf("entrei no estado ficheiro\n"); 
                            nomefich = strdup(yytext); 
                            path = strdup(arvore[contatracos(tmppath)]);
                            BEGIN ficheiro;}
[a-zA-Z0-9]+ {printf("entrei no estado ficheiro\n"); nomefich = strdup(yytext); 
              path = strdup(arvore[contatracos(tmppath)]);
              BEGIN ficheiro;}
{qnamef}\.[a-zA-Z0-9]+ {printf("entrei no estado ficheiro\n"); extensao = strdup(yytext + 8);
                nomefich = strdup(nomefinal); strcat(nomefich, extensao); 
                path = strdup(arvore[contatracos(tmppath)]);
                BEGIN ficheiro;}


<meta>=== {printf("vou sair de meta e voltar ao inicio\n"); BEGIN 0;}
<meta>email:\ ([a-z0-9]+\.)*[a-z0-9]+@([a-z0-9]+\.)+[a-z]+ {email = strdup(yytext+7); 
                                                            printf("seu email é: %s\n", email);}
<meta>author:\ ([a-zA-Z|ç|ã|á|à|â|é]+(\.|\ )*)+ {autor = strdup(yytext+8);
                                            printf("o autor é: %s\n", autor);}
<meta>.|\n ;


<tree>=== {printf("vou sair de tree e voltar ao inicio\n"); BEGIN 0;}
<tree>{qnamef}\/ {dir = strdup(nomefinal); strcat(dir, "/"); printf("dir : %s\n",dir);
                  cona[i++] = strdup(dir); putinTree(arvore, dir, 0); tmppath = strdup(dir);}
<tree>\-+\ [a-zA-Z0-9]+\/ {dir = strdup(yytext); printf("dir : %s com %d traços\n", dir, contatracos(dir)); 
                           cona[i++] = strdup(dir); putinTree(arvore, dir, contatracos(dir));
                           tmppath = strdup(dir);}
<tree>\-+\ [a-zA-Z0-9]+(\.[a-z0-9]+)?$ {dflag = 2; dir = strdup(yytext);
                                        printf("dir : %s com %d traços\n", dir, contatracos(dir));
                                        cona[i++] = strdup(dir); tmppath = strdup(dir);}
<tree>\-+\ {qnamef}\.[a-z0-9]+ {dflag = 2; dir = strdup(yytext); 
                                printf("dir : %s com %d traços\n", dir, contatracos(dir));
                                cona[i++] = strdup(dir); tmppath = strdup(dir);}

<tree>.|\n ;



<ficheiro>=== {printf("vou sair do FICHEIRO e voltar ao inicio\n");
               printf("%s  %s\n", nomefich, tmppath);
               createfich(nomefich, tmppath, arvore);
               BEGIN 0;}
<ficheiro><<EOF>> {createfich(nomefich, tmppath, arvore);}
<ficheiro>{qnamef} {yytext = nomefinal; strcat(buffer, yytext); }
<ficheiro>{qemail} {yytext = email; strcat(buffer, yytext); }
<ficheiro>{qautor} {yytext = autor; strcat(buffer, yytext); }
<ficheiro>[^===] {strcat(buffer, yytext); }


%%

// putinTree(tree, dir, contatracos(dir));

int main(int argc, char* argv[]){
    nomefinal = strdup(argv[1]);
    yyin = fopen(argv[2], "r");
    printf("hello world\n");
    printf("nome do programa é: %s\n", argv[1]);
    yylex();
    for(int i = 0; cona[i]; i++){
        printf("%s\n", cona[i]);
    }
    printf("agora o array de paths das pastas\n");
    for(int i = 0; arvore[i]; i++){
        printf("%s\n", arvore[i]);
    }
    printf("%d\n", contatracos("coisas/"));
    return 0;
}



