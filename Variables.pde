int letraActual = 0;
int tiempoAnterior = 0;
int velocidad = 25; // ms entre letras
String textoActual = "";
boolean mostrarActo0 = true;
boolean mostrarActo1 = false;
boolean mostrarActo2 = false;
boolean mostrarActo3 = false;
boolean mostrarActo1Incorrecto = false;
boolean mostrarActo2Incorrecto = false;
boolean mostrarActo3Incorrecto = false;

//Variables de escenas
/*float ryomaX = 1200; // posición inicial
float ryomaY = 150;
float targetX = 600; // posición a la que se moverá
float t = 0; // interpolación
boolean moving = false;*/

color colorA = color(0, 0, 50);     
color colorB = color(255, 100, 150); 
float tiempo = 0;



float u = 0; // parámetro de curva
PVector posicionRyoma;
curva trayectoria;

int startTime;
boolean flipped = false;


PImage DecisionSprite;
PImage CasaSprite;
PImage SakamotoSprite;
PImage KatsuSprite;

void keyPressed()
{
  if((key == ' ' || keyCode == 32) && velocidad == 25 )
  {
    velocidad =5;
  }
  else if((key == ' ' || keyCode == 32) && velocidad ==5)
   {
     velocidad = 25; 
   }
}

class curva
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
    
    coefs[1].x = -5.5 * puntos_de_ctrl[0].x + 9.0 * puntos_de_ctrl[1].x -4.5 * puntos_de_ctrl[2].x + puntos_de_ctrl[3].x;
    coefs[1].y = -5.5 * puntos_de_ctrl[0].y + 9.0 * puntos_de_ctrl[1].y -4.5 * puntos_de_ctrl[2].y + puntos_de_ctrl[3].y;
    
    //C2 = 9P0-22.5P1+18P2-4.5P3
    
    coefs[2].x = 9.0 * puntos_de_ctrl[0].x -22.5 * puntos_de_ctrl[1].x + 18 * puntos_de_ctrl[2].x -4.5*puntos_de_ctrl[3].x;
    coefs[2].y = 9.0 * puntos_de_ctrl[0].y -22.5 * puntos_de_ctrl[1].y + 18 * puntos_de_ctrl[2].y -4.5*puntos_de_ctrl[3].y;
    
    //C3 = -4.5P0+13.5P1-13.5P2+4.5P3
     coefs[3].x = -4.5 * puntos_de_ctrl[0].x + 13.5 * puntos_de_ctrl[1].x -13.5 * puntos_de_ctrl[2].x +4.5*puntos_de_ctrl[3].x;
     coefs[3].y = -4.5 * puntos_de_ctrl[0].y + 13.5 * puntos_de_ctrl[1].y -13.5 * puntos_de_ctrl[2].y +4.5*puntos_de_ctrl[3].y;
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
