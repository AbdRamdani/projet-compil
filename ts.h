#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<fcntl.h>
#include <string.h>



typedef struct
{
   int state;
   char name[20]; //nom de la variable ou constante tab ..
   char code[20]; //IDF const ..
   char type[20]; //entier float .. de variable ou const
   //float val; 
   char val[10];
   int taille;
   //Taille : la taille du tableau (la taille est égale à 1 pour les variables simples).
 } element;

typedef struct
{ 
   int state; 
   char name[20];
   char type[20]; //entier float ..
} elt;

element tab[1000];
//tab : symboles des constantes , variebles
elt tabs[40],tabm[40];
//tabs : symbole separateur et mot clé
//tabm : tab de mot clé
extern char sav[20];


void initialisation()
{
  int i;
  for (i=0;i<1000;i++)
  tab[i].state=0;
  
  

  for (i=0;i<40;i++)
    {tabs[i].state=0;
    tabm[i].state=0;}

}



void inserer (char entite[], char code[],char type[],char val[],int taille,int i, int y)
{
  switch (y)
 { 
   case 0:/*insertion dans la table des IDF et CONST*/
       tab[i].state=1;
       strcpy(tab[i].name,entite);
       strcpy(tab[i].code,code);
	    strcpy(tab[i].type,type);
	   //tab[i].val=val;
     strcpy(tab[i].val,val);
     tab[i].taille=taille;
	   break;

   case 1:/*insertion dans la table des mots clés*/
       tabm[i].state=1;
       strcpy(tabm[i].name,entite);
       strcpy(tabm[i].type,code);
       break; 
    
   case 2:/*insertion dans la table des séparateurs*/
      tabs[i].state=1;
      strcpy(tabs[i].name,entite);
      strcpy(tabs[i].type,code);
      break;
 }

}
                //name
void rechercher (char entite[], char code[],char type[],char val[],int taille,int y)	
{

int j,i;

switch(y) 
  {
   case 0:/*verifier si la case dans la tables des IDF et CONST est libre*/
        for (i=0;((i<1000)&&(tab[i].state==1))&&(strcmp(entite,tab[i].name)!=0);i++); 
        if(i<1000)
        { 
	        
			inserer(entite,code,type,val,taille,i,0); 
	      
         }
        else
          printf("entité existe déjà\n");
          //return -1 ; pour signale une erreur peut etre
        break;

   case 1:/*verifier si la case dans la tables des mots clés est libre*/
       
       for (i=0;((i<40)&&(tabm[i].state==1))&&(strcmp(entite,tabm[i].name)!=0);i++); 
        if(i<40)
          inserer(entite,code,type,val,taille,i,1);
        else
          printf("entité existe déjà\n");
          //return -1 ; pour signale une erreur peut etre
        break; 
    
   case 2:/*verifier si la case dans la tables des séparateurs est libre*/
         for (i=0;((i<40)&&(tabs[i].state==1))&&(strcmp(entite,tabs[i].name)!=0);i++); 
        if(i<40)
         inserer(entite,code,type,val,taille,i,2);
        else
   	       printf("entité existe déjà\n");
            //return -1 ; pour signale une erreur peut etre
        break;
    //case 3 ?? 
    case 3:/*verifier si la case dans la tables des IDF et CONST est libre*/
        for (i=0;((i<1000)&&(tab[i].state==1))&&(strcmp(entite,tab[i].name)!=0);i++); 
                  
        if (i<1000)
        { inserer(entite,code,type,val,taille,i,0); }
        else
          printf("entité existe déjà\n");
        break;
  }

}


/***Step 5 L'affichage du contenue de la table des symboles ***/

void afficher()
{int i;

printf("/***************Table des symboles IDF*************/\n");
printf("______________________________________________________________________________\n");
printf("\tligne| Nom_Entite |  Code_Entite | Type_Entite | Val_Entite  | taille \n");
printf("______________________________________________________________________________\n");
  
for(i=0;i<50;i++)
{	
	
    if(tab[i].state==1)
      { 
        printf("\t%5d|%10s |%15s | %12s | %10s| %3d \n",i,tab[i].name,tab[i].code,tab[i].type,tab[i].val,tab[i].taille);
         
      }
}

 
printf("\n/***************Table des symboles mots clés*************/\n");

printf("_____________________________________\n");
printf("\t| NomEntite |  CodeEntite | \n");
printf("_____________________________________\n");
  
for(i=0;i<40;i++)
    if(tabm[i].state==1)
      { 
        printf("\t|%10s |%12s | \n",tabm[i].name, tabm[i].type);
               
      }

printf("\n/***************Table des symboles séparateurs*************/\n");

printf("_____________________________________\n");
printf("\t| NomEntite |  CodeEntite | \n");
printf("_____________________________________\n");
  
for(i=0;i<40;i++)
    if(tabs[i].state==1)
      { 
        printf("\t|%10s |%12s | \n",tabs[i].name,tabs[i].type );
        
      }


}

/////////////// les autres fonction a ajouté 

int recherche(char nomm[]){
  int i=0;
  while(i<1000){
    if(strcmp(nomm,tab[i].name)==0) { return i;}
    i++;
  }
  return -1; // dans le cas ou l IDF nexiste pas 
}

int doubleDeclaration(char nomm[]){
  int pos; printf("** %s ** ",nomm);
  pos=recherche(nomm);
  if(strcmp(tab[pos].type,"")==0) {  return 0; }
  else { printf(" fonction doubleDeclaration %s retour 1\n",nomm);  return -1;}
 
}

void insererTYPE(char entite[], char typee[],int taille)
{
  int pos;
  pos=recherche(entite);
	if(pos!=-1)
	   {
      strcpy(tab[pos].type,typee); 
      tab[pos].taille =taille;
       
     printf("  insererTYPE %s - %s - %d - ",entite,typee,pos);
     
     }
  else printf("erreur dans la fonction insererType\n");

}


void semantiqueImport(int i,int l){
  switch(i){
    case 0: printf("\nerreur semantique ligne %d: missing ## ARRAY you cant use array\n",l);
        break;
    case 1: printf("\nerreur semantique ligne %d : missing ## LOOP you cant use while \n",l);
        break;
    case 2: printf("\n erreur semantique ligne %d : MISSING ##PROCESS \n",l);
        break;
    case 3:printf("\n erreur semantique double declaration\n");
  }
  

}

int sameTypeDec(char idf[],char entite[]){
  int i ,j ;
  i=recherche(idf);
  j=recherche(entite);
  if(strcmp(tab[j].type,tab[i].type)==0)
    {printf("fonctin sameTypeDec retour 0"); return 0;}
  printf("fonctin sameTypeDec retour -1"); 
  return -1;
}

void insererValCst(char entite[], char typee[])
{
  int i,j;
  i=recherche(entite);
  j=recherche(typee);
	strcpy(tab[i].val,tab[j].val); 
  printf("  insererValCst - %s <- %s  - ",entite,typee);
     
} 

	 
int checkRead(char entite[],char mode[],int l){
  int pos;
  printf("%s %s ",entite,mode);
  pos=recherche(entite);
  if(mode=="$" && strcmp(tab[pos].type,"INTEGER")==0  ) return 1;
  if(mode=="%" && strcmp(tab[pos].type,"REAL")==0 ) return 1;
  if(mode=="#" && strcmp(tab[pos].type,"STRING")==0 ) return 1;
  if(mode=="&" && strcmp(tab[pos].type,"CHAR")==0 ) return 1;
  printf("erreur semantique ligne %d - erreur READ incompatible type %s avec %s",l,entite,mode);
  return 0;

}

