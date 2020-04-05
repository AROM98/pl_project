#define _GNU_SOURCE
#include "head.h"
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <stdlib.h>
#include <glib.h>


int contatracos(char* string){
    int res = 0;
    for(int i = 0; string[i]; i++){
        if(string[i] == '-'){
            res++;
        }
    }
    return res;
}

//para por na estura chamada de tree (nao é uma arvore)
void putinTree(tree t, char* string, int i){
    int n, res;
    char* tmp;
    if(i > 0){
        n = i - 1;
        tmp = strdup(t[n]);
        strcat(tmp, string + i + 1);
    }
    else tmp = strdup(string);
    t[i] = strdup(tmp);
    res = mkdir(t[i], 0777);
    if(res == 0) printf("%s ... OK\n", t[i]);
    else printf("ERRO tentar criar ou já existe %s\n", t[i]);
}

void createfich(char* nome, char* path){
    //printf("criar ficheiro: %s em %s\n", nome, path);
    FILE *file = fopen(path, "w");
    int results = fputs(buffer, file);
    if (results == EOF) printf("ERRO tentar criar %s\n", nome);
    else printf("%s ... OK\n", nome);
    fclose(file);
    memset(buffer, 0, sizeof(char)*1000); // limpar buffer 
}


gint my_compare(gconstpointer a,gconstpointer b){
    const char *cha = a;
    const char *chb = b;
    return strcmp(cha,chb);
}


char* STRCAT (char* dest, const char* src){
    strcpy (dest + strlen (dest), src);
    return dest;
}


char *strdup(const char *str)
{
    int n = strlen(str) + 1;
    char *dup = malloc(n);
    if(dup)
    {
        strcpy(dup, str);
    }
    return dup;
}
