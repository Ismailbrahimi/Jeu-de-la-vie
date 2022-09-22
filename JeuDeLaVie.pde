//BRAHIMI Ismail


int n = 50; //dimension

//creation tableau 2D
int[][]tab = new int[n][n];
int[][]cellule = new int[n][n];
//incrementation et coordonnees rectangle
int i,j;
float x=0,y=0;

//dimension rectangle
float tailleX;// taille x
float tailleY;//taille y

//valeur pour verifier la valeur des cellules voisines
int consigne=0;

void setup(){
  size(400,400);
   tailleX = width/n;// taille x
   tailleY = height/n;//taille y
   println("PROJET JEU DE LA VIE\n\n Consignes du jeu : \n-Une cellule peut survir si elle est entourée par 2 ou 3 voisines.\n-Au dessus de 3 elle meurt d'isolation.\n-au dessous de 2 elle meurt d'isolation.\n-Si une case vide est autour de 3 cases voisines on a une naissance d'une cellule.\n");
  noStroke();
  //print("taille :",tailleX);
  frameRate(10); //nombre de frames par seconde 
  for (i=0;i<n;i++)
  {
   for (j=0;j<n;j++)
    {
    //distribution de probabilite 50%
    int repartition =int(random(10));
    if (repartition<5) 
    {
      tab[i][j]=1; ;  //la cellule vivante de valeur 1
    }  
    else 
    {
      tab[i][j]=0;  //la cellule morte valeur 0
    }
    }
  }
}

void draw(){
 background(127); 
 // calcul nvelle etape
 for (i=0;i<n;i++)
 {
  for (j=0;j<n;j++)
  {
     consigne=algo_general(i,j);
        if (tab[i][j]==0)
         {
           if (consigne==3)
           {
            cellule[i][j]=1; //naissance
           } 
           else 
           {
           cellule[i][j]=0; //soit elle meurt a cause du manque de population cad 'case < 3' ou de surpopulation 'case > 3'
           }
         }
         else
         {
           if((consigne==2)||(consigne==3))
           { 
           cellule[i][j]=1; //survie
           } 
           else
           { 
           cellule[i][j]=0;//soit elle meurt a cause du manque de population cad 'case < 3' ou de surpopulation 'case > 3
           }
         }
   }
  }
 
 //interface graphique

 x = 0;
 y = 0;
 for (i=0;i<n;i++)
 {
  for (j=0;j<n;j++)
  {
    if(cellule[i][j]==0)
    { 
      tuer();
    }
    else 
    {
      mettre_en_vie();
    }
    dessin_tableau();
    x =x+tailleX;
   }
   y = y+ tailleY;
   x = 0;
 }

//a chaque fois on stock les cellules dans le tableau initial
for (i=0;i<n;i++)
 {
   for (j=0;j<n;j++)
   {
    tab[i][j]=cellule[i][j];
   }
 }
 
 println("numero de frame par seconde :"+frameCount);
}

void dessin_tableau()
{
  stroke(3);
  rect(x,y, tailleX, tailleY);
}

void mettre_en_vie()
{
  fill(0);
}

void tuer()
{
  fill(255);
}

//fonction consigne
int algo_general(int i,int j)
{
  int ib,jb,ia,ja,resultat=0;
  if(i == 0)
  {
  ib =n-1;//gestion des valeurs de la bordure ib= i before
  }
  else
  {
  ib=i-1;
  }
  
  if(j == 0)
  {
  jb =n-1;//gestion des valeurs de la bordure jb= j before
  }
  else
  {
  jb=j-1;
  }
  
  if(i == n-1)
  {
  ia =0;//gestion des valeurs de la bordure ia= i after
  }
  else
  {
  ia=i+1;
  }
  
  if(j == n-1)
  {
  ja =0;//gestion des valeurs de la bordure ja= j after
  }
  else
  {
  ja=j+1;
  }
  
 //je prends une case et je l'ajoute a la case d'en bas et au final on fait la somme de tout ces case pour verifier si c'est egale a 3 ou a 2 ou superieur a 3 ou inferieur.
 resultat= resultat+tab[ib][jb];
 resultat= resultat+tab[ib][j];
 resultat= resultat+tab[ib][ja];
 resultat= resultat+tab[i][jb];
 resultat= resultat+tab[i][ja];
 resultat= resultat+tab[ia][jb];
 resultat= resultat+tab[ia][j];
 resultat= resultat+tab[ia][ja];
  return resultat;
}
