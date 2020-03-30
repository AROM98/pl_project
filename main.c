#define _GNU_SOURCE
#include "head.h"
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <glib.h>

//criar var global para o nome do projecto?

extern int yylex();

int main (int argc, char* argv[]){
    nomefinal = strdup(argv[1]);
    char* pathf = strdup(argv[1]);
    strcat(pathf, "/");
    int dica, dir_flag = 0, used = 0;
    char* dir1[20];
    char* ficheiro;
    //no qual argv[1] será o nome do projecto a criar
    // e argv[2] será o nome do template (com extensao)
    while ((dica = yylex())){
        switch (dica){
        case CREATMD:{
            char* mdfile = strdup(nomefinal);
            strcat(mdfile,".md");
            FILE *file = fopen(mdfile, "w");
            int results = fputs(buffer, file);
            if (results == EOF) printf("deu merda!\n");
            fclose(file);
            memset(buffer, 0, sizeof(char)*1000); // limpar buffer
            /* old version
            printf("entrei no switch MD\n");
            int new;
            char* mdfile = strcat(nomefinal, ".md");
            printf("nome do ficheiro md -> %s\n", mdfile);
            new = open(mdfile, O_WRONLY | O_CREAT, 0664);
            write(new, buffer, sizeof(buffer));
            close(new);
            */
            break;
        }/*
        case CREATDIR:{
            if(dflag == 0){ //only used once
                dir1[dir_flag] = strdup(nomefinal);
                //dir = strdup(dir1); // atualiza dir actual
                strcat(dir1[dir_flag],"/");
                mkdir(dir1[dir_flag], 0777);
                used++;
            }
            if(dflag == 1){  //criar pasta no /{name}
                dir_flag = used;
                dir1[dir_flag] = strdup(pathf);
                strcat(dir1[dir_flag], dir);
                mkdir(dir1[dir_flag], 0777);
                used++;
                dir_flag = 0;
            }
            if(dflag == 2){ // criar pasta no /{name}/coisa/(pasta a criar) . caso de --
                dir_flag = used;
                dir1[dir_flag] = strdup(dir1[dir_flag - 1]); // copia path da ultima pasta criada.
                strcat(dir1[dir_flag], dir);
                mkdir(dir1[dir_flag], 0777);
                used++;
                dir_flag = 0; // volta a origem.
            }
            if(dflag == 3){ // criar ficheiro em /{name} . caso -
                ficheiro = strdup("touch ");
                strcat(ficheiro, dir);
                printf("1- %s\n", ficheiro);
                //system(ficheiro);
                //memset(ficheiro, 0, sizeof(ficheiro)); // limpar buffer
            }
            if(dflag == 4){ // criar ficheiro em /{name}/coisa/(ficheiro a criar) . caso de --
                dir_flag = used - 1;
                ficheiro = strdup("cd ");
                strcat(ficheiro, dir1[dir_flag]);
                printf("2- %s\n", ficheiro);
                //system(ficheiro);
                ficheiro = strdup("touch ");
                strcat(ficheiro, dir);
                printf("3- %s\n", ficheiro);
                //system(ficheiro);
                dir_flag = 0; // volta a origem.
                //memset(ficheiro, 0, sizeof(ficheiro)); // limpar buffer
            }
            break;
        }
        */
        case CREATFICH:{
            /* CRIA/ESCREVE todos os ficheiros */
            printf("criar ficheiro: %s\n", nomefich);
            FILE *file = fopen(nomefich, "w");
            int results = fputs(buffer, file);
            if (results == EOF) printf("deu merda!\n");
            fclose(file);
            memset(buffer, 0, sizeof(char)*1000); // limpar buffer
            break;
        }
        default:
            break;
        }
    }
    /*
    Escrever nso ficheiros certos??
    */
    printf("nome do programa: %s\n", argv[1]);
    printf("autor -> %s\n", autor);
    printf("email -> %s\n", email);
    return 0;
}