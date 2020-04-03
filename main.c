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

void putinTree(tree t, char* string, int i){
    int n;
    char* tmp;
    if(i > 0){
        n = i - 1;
        tmp = strdup(t[n]);
        strcat(tmp, string + i + 1);
    }
    else tmp = strdup(string);
    t[i] = strdup(tmp);
    mkdir(t[i], 0777);
}

void createfich(char* nome, char* path){
    //char* paath = "cd ";
    //int v = contatracos(tmp);
    //strcat(paath, t[v - 1]);
    //printf("system -> %s\n", paath);
    //system(paath);
    printf("criar ficheiro: %s\n", nome);
    FILE *file = fopen(nome, "w");
    int results = fputs(buffer, file);
    if (results == EOF) printf("deu merda!\n");
    fclose(file);
    memset(buffer, 0, sizeof(char)*1000); // limpar buffer
    //for(int i = 0; i < v; i++){
    //    system("cd ..");
    //}
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
//libc_hidden_builtin_def (strcat)

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
