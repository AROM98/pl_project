#include "head.h"
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>

//criar var global para o nome do projecto?

extern int yylex();

int main (int argc, char* argv[]){
    nomefinal = strdup(argv[1]);
    int dica;
    char* dir1, dir2, dir3;
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
        }
        case CREATDIR:{
            if(dflag == 0){ //only used once
                dir1 = strdup(nomefinal);
                dir = strdup(dir1); // atualiza dir actual
                strcat(dir1,"/");
                mkdir(dir1, 0664);
            }
            if(dflag == 1){  
                dir2 = strdup(dir);
                strcat(dir2,"/");
                mkdir(dir2, 0664);
            }
            if(dflag == 2){
                dir3 = strdup(nomefinal);
                strcat(dir3,"/");
                mkdir(dir3, 0664);
            }
            break;
        }
        case CREATFL:{
            char* filefl = strdup(nomefinal);
            strcat(filefl,".fl");
            FILE *file = fopen(filefl, "w");
            int results = fputs(buffer, file);
            if (results == EOF) printf("deu merda!\n");
            fclose(file);
            memset(buffer, 0, sizeof(char)*1000); // limpar buffer
            break;
        }
        case CREATMAKE:
            break;
        
        case CREATREADME:{
            FILE *file = fopen("ReadME.txt", "w");
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
    
    printf("nome do programa: %s\n", argv[1]);
    printf("autor -> %s\n", autor);
    printf("email -> %s\n", email);
    return 0;
}