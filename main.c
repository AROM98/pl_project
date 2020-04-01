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

//criar var global para o nome do projecto?

extern int yylex();

int main (int argc, char* argv[]){
    nomefinal = strdup(argv[1]);
    char* pathf = strdup(argv[1]);
    strcat(pathf, "/");
    int dica, dir_flag = 0, used = 0;
    char* dirs[50];
    char* ficheiro;
    int tracos = 0;
    //no qual argv[1] será o nome do projecto a criar
    // e argv[2] será o nome do template (com extensao)
    while ((dica = yylex())){
        switch (dica){
        case CREATDIR:{
            if(dflag == 0){ //only used once
                dirs[dir_flag] = strdup(nomefinal);
                //dir = strdup(dirs); // atualiza dir actual
                strcat(dirs[dir_flag],"/");
                mkdir(dirs[dir_flag], 0777);
                used++;
            }
            if(dflag == 1){ // tem que contar os -  e strcat(dris[N-1], nome da pasta ++ /); e por isto em N.
                /* contar os -*/
                for(int i  = 0; dir[i]; i++){
                    if(dir[i] == '-'){
                        tracos++;
                    }
                }
                printf("%s tem %d traços\n", dir, tracos);

                /* -------------------- */
                //dirs[dir_flag] = strdup(pathf);
                //strcat(dirs[dir_flag], dir);
                //mkdir(dirs[dir_flag], 0777);
                //used++;
                //dir_flag = 0;
            }
            /*
            if(dflag == 2){ // criar pasta no /{name}/coisa/(pasta a criar) . caso de --
                dir_flag = used;
                dirs[dir_flag] = strdup(dirs[dir_flag - 1]); // copia path da ultima pasta criada.
                strcat(dirs[dir_flag], dir);
                mkdir(dirs[dir_flag], 0777);
                used++;
                dir_flag = 0; // volta a origem.
            }
            */
           break;
        }
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
    */
    printf("nome do programa: %s\n", argv[1]);
    printf("autor -> %s\n", autor);
    printf("email -> %s\n", email);
    return 0;
}