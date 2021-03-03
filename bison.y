%{
#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<fcntl.h>
#include <string.h>


//int nb_ligne =1, Col=1;

extern FILE* yyin ;
int yylex();
void yyerror(char *s);
int yyparse();

//char* sauvtype;
char sauvtype[8] = "";
char sauvtypeTab[8]="";
char nomtab[10]="";
int tailletab=0;
//char *sauvtype = malloc(10);


 //chmp type vide --> var non declaré 
 //taille de tableau 
 //<tstr>mc_entier <tstr>mc_reel <tstr>mc_str    

%}
%token mc_pgm  
%token mc_process mc_loop mc_array mc_const mc_var
%token <tstr>IDF <tstr>mc_entier <tstr>mc_reel <tstr>mc_str 
%token  dz division addition multi dpts egale affectation fin acco 
%token accf crov crof sep mc_instruction
%token mc_read paro parf mc_write bar address
%token mc_while mc_execut mc_if mc_else mc_end_if
%token <tentier>typeInt <tfloat> typeFloat <tstr>typeString <tchar>typeChar
%token mc_sup mc_supe mc_eg mc_dif mc_infe mc_inf
%token quotation_mark
%token signe_real signe_string signe_char moins
 
%union{
        int tentier; 
        float tfloat; 
        char* tstr; 
        char tchar;    
}

%start S
%%
S: LIST_BIB mc_pgm IDF acco DEC  accf {printf("la chaine est correct\n\n\n");YYACCEPT;}
    ;

LIST_BIB: LIST_BIB BIB
        |
        ;

BIB: dz NOM_BIB fin  
    ;

NOM_BIB: mc_loop
        | mc_process
        |  mc_array
        ;

DEC:DEC_VAR DEC_INST
    |
    ;

DEC_VAR:  mc_var LIST_DEC  mc_const LIST_CST
        |  mc_const LIST_CST mc_var LIST_DEC
        | mc_var LIST_DEC
        | mc_const LIST_CST
        |
        ;

LIST_DEC:TYPE dpts LIST_IDF  LIST_DEC
        |
        ;

LIST_IDF: IDF sep LIST_IDF { if(doubleDeclaration($1)==0) insererTYPE($1,sauvtype);
                             else printf("err semantique double declaration de %s \n",$1); }
        | IDF_TABLEAU LIST_IDF  {if(tailletab>0){
                                                  if(doubleDeclaration(nomtab)==0) insererTYPE(nomtab,sauvtype);
                                                  else printf("err semantique double declaration de %s \n",nomtab);
                                }
                                else printf(" erreur symentique - la taille de tableau %s est negatif (%d)",nomtab,tailletab);
        
        }

        | IDF fin { printf("***%s %s***",sauvtype,$1);
                if(doubleDeclaration($1)==0) insererTYPE($1,sauvtype);
                             else printf("err semantique double declaration de %s \n",$1); }
        
        | IDF_TABLEAU fin { 
                {if(tailletab>0){printf("%s",sauvtype);
                                                  if(doubleDeclaration(nomtab)==0) {insererTYPE(nomtab,sauvtypeTab); printf("=====");}
                                                  else printf("err semantique double declaration de %s \n",nomtab);
                        }
                        else printf(" erreur symentique - la taille de tableau %s est negatif (%d)",nomtab,tailletab);
        
        }}
        ;

LIST_CST:TYPE dpts LIST_IDF_CST LIST_CST
        |
        ;   
LIST_IDF_CST: IDF affectation TYPE_IDF sep LIST_IDF_CST
            | IDF affectation TYPE_IDF fin
            ;




DEC_INST: DEC_INST2 DEC_INST
        |DEC_INST2
        ;
DEC_INST2:DEC_READ 
         |DEC_WRITE 
         |DEC_WHILE 
         |DEC_AFFECTATION 
         |DEC_EXECUT 
         ;

DEC_READ:mc_read paro typeString  bar address IDF parf fin
        ;

DEC_WRITE: mc_write paro typeString DEC_WRITE2 parf fin
         
         ;
DEC_WRITE2: bar IDF DEC_WRITE2
          | 
          ;

DEC_WHILE: mc_while paro DEC_COND parf acco DEC_AFFECTATION accf
         ;
DEC_AFFECTATION: IDF affectation DEC_AFFECTATION2 fin {if(doubleDeclaration($1)==1) printf("operation semantique oklm");
                                                         else printf("err semantique identificateur non declaré  %s \n",$1);}
                | IDF_TABLEAU affectation DEC_AFFECTATION2 fin {if(doubleDeclaration(nomtab)==1) printf("operation semantique oklm");
                                                                  else printf("err semantique identificateur non declaré  %s \n",nomtab);}
                ;
DEC_AFFECTATION2: TYPE_IDF OPERATEUR_ARITHMETHIQUE DEC_AFFECTATION2
                | IDF OPERATEUR_ARITHMETHIQUE DEC_AFFECTATION2
                | TYPE_IDF
                | IDF
                ;
DEC_COND:DEC_COND2 OPERATEUR_COMPARAISON DEC_COND2
        |
        ;
DEC_COND2:typeInt OPERATEUR_ARITHMETHIQUE DEC_COND2
         | IDF OPERATEUR_ARITHMETHIQUE  DEC_COND2
         | typeInt
         |IDF
         ;

DEC_EXECUT:mc_execut DEC_AFFECTATION mc_if paro DEC_COND parf DEC_EXECUT_ELSE  mc_end_if
          ;

DEC_EXECUT_ELSE: mc_else mc_execut DEC_AFFECTATION
                |
                ;


     
TYPE: mc_entier {strcpy(sauvtype,$1);}
    | mc_reel {strcpy(sauvtype,$1);}
    | mc_str 
    ;
IDF_TABLEAU:IDF crov typeInt crof { strcpy(nomtab,$1);
                                    tailletab=($3);
                                    };


TYPE_IDF:typeInt 
        |typeFloat 
        |typeString 
        |typeChar
        ;
 

OPERATEUR_ARITHMETHIQUE:division
                        |addition
                        |multi
                        |moins
                        ;
        
OPERATEUR_COMPARAISON:mc_sup
                     |mc_supe
                     |mc_eg
                     |mc_dif
                     |mc_inf
                     |mc_infe
                     ;

%%
void yyerror(char *msg){ 
        printf("erreur syntaxique \n");
        //printf("erreur symentique dans ligne %d \n",nbr_lg);
}

int main(int argc, char* argv[]){
    int fd;
    //le cas ou on a pas un fichier passer dans le terminal
     
    if(argc==1){ 
            printf("erreur! entrer un fichier text\n");
            return -1;
    }
    yyin=fopen(argv[1],"r");
    fd =open(argv[1],O_RDONLY);
    if(fd == -1){
            //si le fichier n'existe pas 
            printf("le fichier .txt n'existe pas \n");
            return -1;
    }
    //sinon le fichier existe 
        initialisation();
        yyparse(); 
        afficher();
       
        return 0;
    
}

int yywrap(void){
       //pour eviter les problem signaler par gcc
        /*
        SIGNE_FORMATAGE:signe_real 
                |signe_string 
                |signe_char
                |fin
                ;    

                strcpy(sauvType,$1);
                comparer le type de $1 avec 
        */
        return 0;}


