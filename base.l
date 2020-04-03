%{
#include "head.h"
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <stdlib.h>
#include <glib.h>

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

path = strdup(arvore[contatracos(tmppath) - 1]);
printf("ficherio: %s -> %s -> %s\n", nomefich, tmppath, path);

GHashTable* coisa = g_hash_table_new (g_str_hash, g_str_equal);

*/
int i = 0, tracos;
char* cona[50];
tree arvore;
char* path;
char* tmppath;

tabela coisa;

int m;

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
                            
                            BEGIN ficheiro;}
[a-zA-Z0-9]+ {printf("entrei no estado ficheiro\n"); nomefich = strdup(yytext); 
              
              BEGIN ficheiro;}
{qnamef}\.[a-zA-Z0-9]+ {printf("entrei no estado ficheiro\n"); extensao = strdup(yytext + 8);
                nomefich = strdup(nomefinal); strcat(nomefich, extensao); 
                
                BEGIN ficheiro;}


<meta>=== {printf("vou sair de meta e voltar ao inicio\n"); BEGIN 0;}
<meta>email:\ ([a-z0-9]+\.)*[a-z0-9]+@([a-z0-9]+\.)+[a-z]+ {email = strdup(yytext+7); 
                                                            printf("seu email é: %s\n", email);}
<meta>author:\ ([a-zA-Z|ç|ã|á|à|â|é]+(\.|\ )*)+ {autor = strdup(yytext+8);
                                            printf("o autor é: %s\n", autor);}
<meta>.|\n ;


<tree>=== {printf("vou sair de tree e voltar ao inicio\n"); BEGIN 0;}
<tree>[a-zA-Z0-9]+\/ {printf("init ler linha1\n");
                      dir = strdup(yytext); printf("dir : %s\n",dir);
                      cona[i++] = strdup(dir); putinTree(arvore, dir, 0); 
                      printf("end ler linha1\n");}
<tree>{qnamef}\/ {printf("init ler linha2\n");
                  dir = strdup(nomefinal); strcat(dir, "/"); printf("dir : %s\n",dir);
                  cona[i++] = strdup(dir); putinTree(arvore, dir, 0);
                  printf("end ler linha2\n");}
<tree>\-+\ [a-zA-Z0-9]+\/ {printf("init ler linha3\n");
                           dir = strdup(yytext); printf("dir : %s com %d traços\n", dir, contatracos(dir)); 
                           cona[i++] = strdup(dir); putinTree(arvore, dir, contatracos(dir));
                           printf("end ler linha3\n");
                           }
<tree>\-+\ [a-zA-Z0-9]+(\.[a-z0-9]+)?$ {printf("init ler linha4\n");
                                        dir = strdup(yytext);
                                        printf("dir : %s com %d traços\n", dir, contatracos(dir));
                                        cona[i++] = strdup(dir);
                                        printf("end ler linha4\n"); }
<tree>\-+\ {qnamef}\.[a-z0-9]+ {printf("init ler linha5\n");
                                dir = strdup(yytext); 
                                printf("dir : %s com %d traços\n", dir, contatracos(dir));
                                tracos = contatracos(dir);
                                cona[i++] = strdup(dir);
                                printf("ERRO1?\n");
                                path = strdup(arvore[tracos - 1]);
                                printf("ERRO2? -> %s\n", path);
                                tmppath = strdup(nomefinal);
                                strcat(tmppath, dir + tracos + 9);
                                printf("ERRO3? -> %s\n", tmppath);
                                strcat(path, tmppath);
                                printf("ERRO4? -> %s\n", path);
                                g_hash_table_insert (coisa, tmppath, path);
                                printf("end ler linha5\n");
                                printf("There are %d keys in the hash table\n",g_hash_table_size(coisa));
                                }

<tree>.|\n ;



<ficheiro>=== {printf("vou sair do FICHEIRO e voltar ao inicio\n");
               
               BEGIN 0;}
<ficheiro><<EOF>> {return 0;}
<ficheiro>{qnamef} {yytext = nomefinal; strcat(buffer, yytext); }
<ficheiro>{qemail} {yytext = email; strcat(buffer, yytext); }
<ficheiro>{qautor} {yytext = autor; strcat(buffer, yytext); }
<ficheiro>[^===] {strcat(buffer, yytext); }


%%

// putinTree(tree, dir, contatracos(dir));
// createfich(nomefich, tmppath, arvore);
//tabela  coisa = g_hash_table_new(g_str_hash, g_str_equal);

//g_hash_table_insert (coisa, nomefich, path);

int main(int argc, char* argv[]){
    coisa = g_hash_table_new(g_str_hash, g_str_equal);
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
    printf("There are %d keys in the hash table\n",g_hash_table_size(coisa));
    printf("%d\n", m);
    return 0;
}



