 
%{
    #include<stdio.h>
    #include "bison.tab.h"
    #include "ts.h"
    
    int nbr_lg=1;
    int Col=1;
    
    //extern nbr_lg; 
    //extern Col; 
    extern YYSTYPE yylval;


    //col=col+strlen(yytext);
    //Rechercher(yytext,"",0,0);
    // 0 dans le cac ou on connais pas le type    
    // Rechercher(yytext,0,0);
    // le dernier 0 le tableau ou on l'ajoute 
    //Rechercher(yytext,"real",alof(yytext),0);
    // alof real aloi entier 

    //yylval pour envoyé des valeur de lexical vers symentique
   //extern YYSTYPE yylval;
   // on declare la suite dans bison 
   //yyval.eniter=atoi(yytext)
   //yyval.eniter=atof(yytext)
   //yylval.str=strdup(yytext)
   
    // printf(" ligne colone entite %s",nbrlg col yytext)

    // rechercher(yytext,"entier",atoi(yytext),0,0);
   
%}

lettreM [A-Z]
lettre [a-zA-Z]
chiffre [0-9]
IDF {lettreM}({lettre}|{chiffre})*
cst{chiffre}+
Comment "/*"(.|\n)*"*/"
texte ({lettre}|" ")*
Int ("(-"{chiffre}+")")|{chiffre}+
Float ("(-"{chiffre}+"."{chiffre}+")")|({chiffre}+"."{chiffre}+)
String (\")[^\n\t]+(\")
Char '[^\n\t]'
  

%%
Programme   {   rechercher(yytext,"Mot cle",0,0, 1);
                Col= Col + strlen(yytext);
                return mc_pgm; 
                }
INTEGER     {   rechercher(yytext,"Mot cle",0,0, 1);
                yylval.tstr=strdup(yytext);
                Col= Col + strlen(yytext);
                return mc_entier;
                }
REAL        {   rechercher(yytext,"Mot cle",0,0, 1);
                yylval.tstr=strdup(yytext);
                Col= Col + strlen(yytext);
                return mc_reel;
                }
STRING      {   rechercher(yytext,"Mot cle",0,0, 1);
                yylval.tstr=strdup(yytext);
                Col= Col + strlen(yytext);
                return mc_str;
                }
PROCESS     {   rechercher(yytext,"Mot cle",0,0, 1); 
                Col= Col + strlen(yytext);
                return mc_process;
                }
LOOP        {   rechercher(yytext,"Mot cle",0,0, 1);
                Col= Col + strlen(yytext);
                return mc_loop;
                }
ARRAY       {   rechercher(yytext,"Mot cle",0,0, 1);
                Col= Col + strlen(yytext);
                return mc_array;
                }
VAR         {   rechercher(yytext,"Mot cle",0,0, 1);
                Col= Col + strlen(yytext);
                return mc_var;
                }
INSTRUCTION {   rechercher(yytext,"Mot cle",0,0, 1);
                Col= Col + strlen(yytext);
                return mc_instruction;
                }
CONST       {   rechercher(yytext,"Mot cle",0,0, 1);
                Col= Col + strlen(yytext);
                return mc_const;
                }

READ        {   rechercher(yytext,"Mot cle",0,0, 1);
                Col= Col + strlen(yytext);
                return mc_read;
                }
WRITE       {   rechercher(yytext,"Mot cle",0,0, 1);
                Col= Col + strlen(yytext);
                return mc_write;
                }
WHILE       {   rechercher(yytext,"Mot cle",0,0, 1);
                Col= Col + strlen(yytext);
                return mc_while;
                }
EXECUT      {   rechercher(yytext,"Mot cle",0,0, 1);
                Col= Col + strlen(yytext);
                return mc_execut;
                }
IF          {   rechercher(yytext,"Mot cle",0,0, 1);
                Col= Col + strlen(yytext);
                return mc_if;
                }
END_IF      {   rechercher(yytext,"Mot cle",0,0, 1);
                Col= Col + strlen(yytext);
                return mc_end_if;
                }
ELSE        {   rechercher(yytext,"Mot cle",0,0, 1);
                Col= Col + strlen(yytext);
                return mc_else;
                }

"|"         {   rechercher(yytext,"MC SEP",0,0,2);
                Col= Col + strlen(yytext);
                return bar;
                }
"%"         {   rechercher(yytext,"MC SEP",0,0,2);
                Col= Col + strlen(yytext);
                return signe_real;
                }
"#"         {   rechercher(yytext,"MC SEP",0,0,2);
                Col= Col + strlen(yytext);
                return signe_string;
                }
"&"         {   rechercher(yytext,"MC SEP",0,0,2);
                return signe_char;
                Col= Col + strlen(yytext);
                }
{Int}       {   yylval.tentier=atoi(yytext);
                rechercher(yytext,"Cst entier","INTEGER",0,0); 
                Col= Col + strlen(yytext);
                return typeInt;
                }
{Float}     {   yylval.tfloat=atof(yytext);
                rechercher(yytext,"Cst floatt","FLOAT",0,0); 
                Col= Col + strlen(yytext);
                return typeFloat;
                }
{String}    {   yylval.tstr=strdup(yytext);
                rechercher(yytext,"Cst string","STRING",0,0); 
                Col= Col + strlen(yytext);
                return typeString;
                }
{Char}      {   yylval.tstr=strdup(yytext);
                rechercher(yytext,"Cst charr","CHAR",0,0);
                Col= Col + strlen(yytext);
                return typeChar;
                }
SUP         {   rechercher(yytext,"Mot cle",0,0, 1);
                Col= Col + strlen(yytext);
                return mc_sup;
                }
SUPE        {   rechercher(yytext,"Mot cle",0,0, 1);
                Col= Col + strlen(yytext);
                return mc_supe;
                }
EG          {   rechercher(yytext,"Mot cle",0,0, 1);
                Col= Col + strlen(yytext);
                return mc_eg;
                }
DIF         {   rechercher(yytext,"Mot cle",0,0, 1);
                Col= Col + strlen(yytext);
                return mc_dif;
                }
INFE        {   rechercher(yytext,"Mot cle",0,0, 1);
                Col= Col + strlen(yytext);
                return mc_infe;
                }
INF         {   rechercher(yytext,"Mot cle",0,0, 1);
                Col= Col + strlen(yytext);
                return mc_inf;
                }


\"          {
                Col= Col + strlen(yytext);
                return quotation_mark;
                }

{IDF}       {   yylval.tstr=strdup(yytext);
			    rechercher(yytext,"IDF","",0,0);
                Col= Col + strlen(yytext);
                if(yyleng>10) printf("erreur lexical size de l'idf : %s %d>10  ligne:%d column: %d\n",yytext,yyleng,nbr_lg,Col);
                printf("idf : %s ",yytext);
                return IDF;
                }


{Comment}   {  
                printf("commentaire : %s \n",yytext);}

"("        {    rechercher(yytext,"MC SEP",0,0,2);
                Col= Col + strlen(yytext);
                return paro;
                }
")"        {    rechercher(yytext,"MC SEP",0,0,2);
                Col= Col + strlen(yytext);
                return parf;
                }
@          {    rechercher(yytext,"MC SEP",0,0,2);
                Col= Col + strlen(yytext);
                return address;
                }


"##"        {   rechercher(yytext,"MC SEP",0,0,2);
                Col= Col + strlen(yytext);
                return dz; 
                }
"/"         {   rechercher(yytext,"MC SEP",0,0,2);

                Col= Col + strlen(yytext);
                return division ;
                }
"+"         {   rechercher(yytext,"MC SEP",0,0,2);
                Col= Col + strlen(yytext);
                return addition ;
                }
"*"         {   rechercher(yytext,"MC SEP",0,0,2);
                Col= Col + strlen(yytext);
                return  multi;
                }
"-"         {   rechercher(yytext,"MC SEP",0,0,2);
                Col= Col + strlen(yytext);
                return moins;
                }
"::"        {   rechercher(yytext,"MC SEP",0,0,2);
                Col= Col + strlen(yytext);
                return dpts ;
                }
"="         {   rechercher(yytext,"MC SEP",0,0,2);
                Col= Col + strlen(yytext);
                return  egale;
                }
":="        {   rechercher(yytext,"MC SEP",0,0,2);
                Col= Col + strlen(yytext);
                return affectation  ;
                }
"$"         {   rechercher(yytext,"MC SEP",0,0,2);
                Col= Col + strlen(yytext);
                return fin;
                }
"{"         {   rechercher(yytext,"MC SEP",0,0,2);
                Col= Col + strlen(yytext);
                return acco ;
                }
"}"         {   rechercher(yytext,"MC SEP",0,0,2);
                Col= Col + strlen(yytext);
                return  accf;
                }
"["         {   rechercher(yytext,"MC SEP",0,0,2);
                Col= Col + strlen(yytext);
                return crov;
                }
"]"         {   rechercher(yytext,"MC SEP",0,0,2);
                Col= Col + strlen(yytext);
                return  crof;
                } 
"//"        {   rechercher(yytext,"MC SEP",0,0,2);
                Col= Col + strlen(yytext);
                return sep;
                }

[ \t] 
\n          {   Col=1;
                nbr_lg++;
                printf("\n%d)   ",nbr_lg);}  
.           {
                printf("erreur lexical ligne : %d column : %d dans* %s *\n",nbr_lg,Col,yytext);
                Col= Col + strlen(yytext);
                }
%%
/*
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

}
*/
