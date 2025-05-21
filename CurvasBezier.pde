/*// una curva de grado 3 (cúbica)
// paramétrica y polinómica
// Voy a utilizar una clase

//Variables y objetos
    curva mi_primera_curva;

//Clases
class curvaBezier
{ 
  //Atributos
  PVector[] puntos_de_ctrl;
  PVector[] coefs;

  //Constructor
  curva(PVector[] p)
  {   //Reservamos memoria
    puntos_de_ctrl = new PVector[4];
    coefs = new PVector[4];
    
    //Inicializamos
    for(int i = 0; i<4; i++)
    {
      puntos_de_ctrl[i] = new PVector(0.0,0.0);
      coefs[i] = new PVector(0.0,0.0);
      
        //Copiamos los puntos recibidos
        puntos_de_ctrl[i] = p[i];
    }
  }
  //Metodos
  
  void calcular_coefs()
  {  //Utilizando la matriz de interpolación, que son 4 calvulamos las C's
    //Cada ecuación se resuelve dos veces, osea para X e Y (estamos en 2D)
    //C0  = P0
    
    coefs[0].x = puntos_de_ctrl[0].x;
    coefs[0].y = puntos_de_ctrl[0].y;
    
    //C1 = -5.5p0+9P1-4.5P2+P3
    
    coefs[1].x = -3 * puntos_de_ctrl[0].x + 3 * puntos_de_ctrl[1].x;
    coefs[1].y = -3 * puntos_de_ctrl[0].y + 3 * puntos_de_ctrl[1].y;
    
    //C2 = 9P0-22.5P1+18P2-4.5P3
    
    coefs[2].x = 3 * puntos_de_ctrl[0].x - 6 * puntos_de_ctrl[1].x + 3*puntos_de_ctrl[2].x;
    coefs[2].y = 3 * puntos_de_ctrl[0].y - 6 * puntos_de_ctrl[1].y + 3*puntos_de_ctrl[2].y;
    
    //C3 = -4.5P0+13.5P1-13.5P2+4.5P3
     coefs[3].x = -1 * puntos_de_ctrl[0].x + 3 * puntos_de_ctrl[1].x -3 * puntos_de_ctrl[2].x + puntos_de_ctrl[3].x;
     coefs[3].y = -1 * puntos_de_ctrl[0].y + 3 * puntos_de_ctrl[1].y -3 * puntos_de_ctrl[2].y + puntos_de_ctrl[3].y;
  }
  
  void pintar_curva()
  {
    float x,y;
  //Pintara los puntos de control y también pintará a la curva, podemos emplear 100 puntos para hacerlo
    //Características de pintado
    
    strokeWeight(5); // 5 Pixeles de grueso para los puntos
    stroke(255,255,0); //Curva de color amarillo
    
    for(float inc_u = 0.0; inc_u < 1.0; inc_u += 0.01) //100 vueltas
    {
       //Calcular X
       x = coefs[0].x + coefs[1].x * inc_u + coefs[2].x * inc_u * inc_u + coefs[3].x * inc_u  * inc_u * inc_u;
       
       //Calcular Y
        y = coefs[0].y + coefs[1].y * inc_u + coefs[2].y * inc_u * inc_u + coefs[3].y * inc_u  * inc_u * inc_u;
       
       //Calcular Z
       //Z = ;
        
       //Pintar un "puntito" en esa coord XYZ
    point(x,y);
    }
  }
 
}

// Variables

//Funciones
void setup()
{
    size(800,600);
    //Inventamos 1 curva
     //Inventarnos sus puntos de control
         PVector[] p;

     p = new PVector[4];
     p[0] = new PVector(200,200);   //Este es el punto de ctrl P0
     p[1] = new PVector(300,300);   //Y este es el P1
     p[2] = new PVector(400, 200);   //El P2
     p[3] = new PVector(500, 300);   //P3
     
     //Llamamos al constructor de la curva
     mi_primera_curva = new curva(p);
     
     //Calculamos sus coeficientes
     mi_primera_curva.calcular_coefs();
}
//El draw pinta la curva
void draw()
{
  background(0);
  mi_primera_curva.pintar_curva();
}*/
