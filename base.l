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

int i = 0, tracos;
char* pathDir[50];
Array path_store;
char path[10240];
char* tmppath;

tabela hashTable;

%}
%x meta tree ficheiro
qnamef \{\%name\%\}
qemail \{\%email\%\}
qautor \{\%author\%\}
%%
    BEGIN 0;
=== ;
meta {BEGIN meta;}
tree {BEGIN tree;}
[a-zA-Z0-9]+\.[a-zA-Z0-9]+ {nomefich = strdup(yytext);
                            BEGIN ficheiro;}
[a-zA-Z0-9]+ {nomefich = strdup(yytext);
              BEGIN ficheiro;}
{qnamef}\.[a-zA-Z0-9]+ {extensao = strdup(yytext + 8);
                nomefich = strdup(nomefinal); strcat(nomefich, extensao);
                BEGIN ficheiro;}


<meta>=== {BEGIN 0;}
<meta>email:\ ([a-z0-9]+\.)*[a-z0-9]+@([a-z0-9]+\.)+[a-z]+ {email = strdup(yytext+7);
                                                            printf("seu email é: %s\n", email);}
<meta>author:\ ([a-zA-Z|ç|ã|á|à|â|é]+(\.|\ )*)+ {autor = strdup(yytext+8);
                                            printf("o autor é: %s\n", autor);}
<meta>.|\n ;


<tree>=== {BEGIN 0;}
<tree>^[a-zA-Z0-9\-\_]+\/$ {dir = strdup(yytext);
                      pathDir[i++] = strdup(dir); guardapath(path_store, dir, 0);
                      }
<tree>^{qnamef}\/$ {dir = strdup(nomefinal); strcat(dir, "/");
                  pathDir[i++] = strdup(dir); guardapath(path_store, dir, 0);
                  }
<tree>^\-+\ [a-zA-Z0-9\-\_]+\/$ {dir = strdup(yytext);
                           pathDir[i++] = strdup(dir); guardapath(path_store, dir, contatracos(dir));
                           }
<tree>^\-+\ [a-zA-Z0-9\-\_]+(\.[a-z0-9]+)?$ {dir = strdup(yytext);
                                        tracos = contatracos(dir);
                                        pathDir[i++] = strdup(dir);
                                        strcpy(path, path_store[tracos - 1]);
                                        tmppath = strdup(dir + tracos + 1);
                                        strcat(path, tmppath);
                                        g_hash_table_insert (hashTable, strdup(tmppath), strdup(path));
                                        }
<tree>^\-+\ {qnamef}\.[a-z0-9]+ {dir = strdup(yytext);
                                tracos = contatracos(dir);
                                pathDir[i++] = strdup(dir);
                                strcpy(path, path_store[tracos - 1]);
                                tmppath = strdup(nomefinal);
                                strcat(tmppath, dir + tracos + 9);
                                strcat(path, tmppath);
                                g_hash_table_insert (hashTable, strdup(tmppath), strdup(path));
                                }
<tree>.|\n ;



<ficheiro>=== {createfich(nomefich, g_hash_table_lookup(hashTable, nomefich));
               BEGIN 0;}
<ficheiro><<EOF>> {createfich(nomefich, g_hash_table_lookup(hashTable, nomefich));
                   return 0;}
<ficheiro>{qnamef} {yytext = nomefinal; strcat(buffer, yytext); }
<ficheiro>{qemail} {yytext = email; strcat(buffer, yytext); }
<ficheiro>{qautor} {yytext = autor; strcat(buffer, yytext); }
<ficheiro>[^===] {strcat(buffer, yytext); }


%%


int main(int argc, char* argv[]){
    hashTable = g_hash_table_new(g_str_hash, g_str_equal);
    nomefinal = strdup(argv[1]);
    yyin = fopen(argv[2], "r");
    printf("nome do programa é: %s\n", argv[1]);
    yylex();
    return 0;
}
