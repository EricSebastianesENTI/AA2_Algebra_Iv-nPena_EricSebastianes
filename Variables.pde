int letraActual = 0;
int tiempoAnterior = 0;
int velocidad = 25; // ms entre letras
String textoActual = "";
boolean mostrarActo0 = false;
boolean mostrarActo1 = false;
boolean mostrarActo2 = false;
boolean mostrarActo3 = false;
boolean mostrarActo1Incorrecto = false;
boolean mostrarActo2Incorrecto = false;
  boolean iniciarhistoriaActo3Final = false;
boolean mostraracto2WarioFinal = false;
boolean mostrarhistoriaActo2Final = false;
boolean mostrarhistoriaActo3Final  = false;
boolean mostraracto2Incorrecto2  = false;
boolean mostraracto2WarioComida  = false;
boolean mostraracto2WarioDinero  = false;
boolean mostrartextoPreActo3Elefante  = false;
boolean mostraracto3Incorrecto2 = false;
boolean mostraracto3Incorrecto3 = false;
boolean mostrarhistoriaActo1 = false;
boolean mostrarHistoriaActo2Final = false;
boolean mostrarActo3Incorrecto = false;
boolean mostrarOpciones = false;




color colorA = color(0, 0, 50);     
color colorB = color(255, 100, 150); 
float tiempo = 0;

int ancho = 250;
int largo = 90;

int ancho1 = 250;
int largo1 = 90;

int x1 = 400;
int y1 = 500;
int w1 = ancho;
int h1 = largo;

int x2 = 1100;
int y2 = 500;
int w2 = ancho1;
int h2 = largo1;

float u = 0; // parámetro de curva
PVector posicionRyoma;
curva trayectoria;

PVector[] puntosBezier;
//curvaBezier curvaKatsu;
float progresoKatsu = 0.0;

int startTime;
boolean flipped = false;

boolean decisionTomada = false;
int decisionActoActual = 0; // 0 = ninguna, 1 = izquierda, 2 = derecha

PImage DecisionSprite;
PImage CasaSprite;
PImage SakamotoSprite;
PImage SakamotoAttackSprite;
PImage SakamotoTeaSprite;
PImage KatsuSprite;

PImage KatsuIdle;
PImage KidoSprite;
PImage SaigoSprite;
PImage TemploSprite;


PImage Bowser;
PImage KatsuBowser;

PImage ShogunSprite;
PImage shogunQuemado;
PImage WarioSprite;
PImage ExclamacionSprite;
PImage fondoScroll, fondoTemplo, fondoCalleWario;
PImage MarioShogunSprite;
PImage Iemochi;
PImage Consejero;

float xConsejero = 950;       // Posición inicial fuera de pantalla
float yConsejero = 180;
float objetivoX = 800;         // Posición final al lado de Iemochi
float easing = 0.05;           // Suavidad
boolean animarConsejero = true;

PImage SakamotoHeridoSprite;

void keyPressed()
{
  if((key == ' ' || keyCode == 32) && velocidad == 25 )
  {
    velocidad = 5;
  }
  else if((key == ' ' || keyCode == 32) && velocidad ==5)
   {
     velocidad = 25; 
   }
}


void mousePressed() {
  if (textoActual.length() == letraActual && !decisionTomada) {
    boolean overSprite1 = mouseX > x1 && mouseX < x1 + w1 && mouseY > y1 && mouseY < y1 + h1;
    boolean overSprite2 = mouseX > x2 && mouseX < x2 + w2 && mouseY > y2 && mouseY < y2 + h2;
    
    if (overSprite1 || overSprite2) {
      decisionTomada = true;
      decisionActoActual = overSprite1 ? 1 : 2;

      if (mostrarActo0) {
        if (decisionActoActual == 1) {
          iniciarActo1Incorrecto();
        } else {
          iniciarActo1();
        }
        decisionTomada = false;
        mostrarOpciones = false;
      }

      else if (mostrarActo1) 
      {
        iniciarHistoriaActo2();
        decisionTomada = false;
        mostrarOpciones = false;
      }

      else if (mostrarActo2)
      {
        if (decisionActoActual == 2) 
        {
          iniciarHistoriaActo2Final();
          decisionTomada = false;
          mostrarOpciones = false;
        }
      }
      
      else if (mostrarActo3)
      {
        if (decisionActoActual == 2) 
        {
          iniciarHistoriaActo3Final();
          decisionTomada = false;
          mostrarOpciones = false;
        }
      }
      
 /*               iniciartextoPreActo3Elefante();
           decisionTomada = false;
          mostrarOpciones = false;*/

      else if (mostrarActo1Incorrecto) {
        iniciaracto2Incorrecto2();
        decisionTomada = false;
        mostrarOpciones = false;
      }

      else if (mostraracto2Incorrecto2) {
        if (decisionActoActual == 1) {
          iniciaracto2WarioDinero();
        } else {
          iniciarWarioFinal();
        }
        decisionTomada = false;
        mostrarOpciones = false;
      }
    }
  }
}







/*void mousePressed() {
  if (textoActual.length() == letraActual && !decisionTomada) {
    boolean overSprite1 = mouseX > x1 && mouseX < x1 + w1 && mouseY > y1 && mouseY < y1 + h1;
    boolean overSprite2 = mouseX > x2 && mouseX < x2 + w2 && mouseY > y2 && mouseY < y2 + h2;
    
    if (overSprite1 || overSprite2) {
      decisionTomada = true;
      decisionActoActual = overSprite1 ? 1 : 2;

      if (mostrarActo0) 
      {
        if (decisionActoActual == 1) 
        {
          iniciarActo1Incorrecto();
        } 
        else 
        {
          iniciarActo1();
        }
      }
      else if(mostrarActo1)
      {
        iniciarHistoriaActo2();
      }
      else if(mostrarActo2)
      {
        if (decisionActoActual == 2) 
        {
         iniciarHistoriaActo2Final();
        } 
      }
      
      else if (mostrarActo1Incorrecto)
      {
        iniciaracto2Incorrecto2();
      }
      else if (mostraracto2Incorrecto2) {
        if (decisionActoActual == 1) {
          iniciaracto2WarioDinero();
        } else {
          iniciarWarioFinal();
        }
      }
   
      decisionTomada = false;
      mostrarOpciones = false;
    }
  }
}*/





/*int letraActual = 0;
int tiempoAnterior = 0;
int velocidad = 25; // ms entre letras
String textoActual = "";
boolean mostrarActo0 = false;
boolean mostrarActo1 = false;
boolean mostrarActo2 = false;
boolean mostrarActo3 = false;
boolean mostrarActo1Incorrecto = false;
boolean mostrarActo2Incorrecto = false;
boolean mostrarActo3Incorrecto = false;

color colorA = color(0, 0, 50);     
color colorB = color(255, 100, 150); 
float tiempo = 0;

int ancho = 250;
int largo = 90;

int ancho1 = 250;
int largo1 = 90;

int x1 = 400;
int y1 = 500;
int w1 = ancho;
int h1 = largo;

int x2 = 1100;
int y2 = 500;
int w2 = ancho1;
int h2 = largo1;

float u = 0; // parámetro de curva
PVector posicionRyoma;
curva trayectoria;

PVector[] puntosBezier;
curvaBezier curvaKatsu;
float progresoKatsu = 0.0;

int startTime;
boolean flipped = false;

boolean decisionTomada = false;
int decisionActoActual = 0; // 0 = ninguna, 1 = izquierda, 2 = derecha

PImage DecisionSprite;
PImage CasaSprite;
PImage SakamotoSprite;
PImage SakamotoAttackSprite;
PImage SakamotoTeaSprite;
PImage KatsuSprite;

void keyPressed()
{
  if((key == ' ' || keyCode == 32) && velocidad == 25 )
  {
    velocidad = 5;
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
void mousePressed() {
  if (textoActual.length() == letraActual && !decisionTomada)
  {
    boolean overSprite1 = mouseX > x1 && mouseX < x1 + w1 && mouseY > y1 && mouseY < y1 + h1;
    boolean overSprite2 = mouseX > x2 && mouseX < x2 + w2 && mouseY > y2 && mouseY < y2 + h2;
    
    if (overSprite1 || overSprite2)
    {
      decisionTomada = true;
      decisionActoActual = overSprite1 ? 1 : 2;
      
      // Lógica para cambiar de acto según la decisión
      if (mostrarActo0)
      {
        if (decisionActoActual == 1)
        {
          iniciarActo1Incorrecto(); // Camino incorrecto
        }
        else
        {
          iniciarActo1(); // Camino correcto
        }
      } 
      else if (mostrarActo1) {
        if (decisionActoActual == 1) {
          iniciarActo2Incorrecto(); // Camino incorrecto
        } else {
          iniciarActo2(); // Camino correcto
        }
      }
      
      // Reinicia para la nueva decisión
      decisionTomada = false;
    }
  }
}

class curvaBezier {
  // Atributos
  PVector[] puntos_de_ctrl;

  // Constructor
  curvaBezier(PVector[] p) {
    puntos_de_ctrl = new PVector[4];
    for (int i = 0; i < 4; i++) {
      puntos_de_ctrl[i] = p[i].copy();
    }
  }

  // Métodos
  void pintar_curva() {
    float x, y;
    strokeWeight(5);
    stroke(255, 255, 0); // Amarillo

    for (float u = 0.0; u <= 1.0; u += 0.01) {
      // Fórmula de Bézier cúbica
      float oneMinusU = 1 - u;

      x = oneMinusU * oneMinusU * oneMinusU * puntos_de_ctrl[0].x +
          3 * oneMinusU * oneMinusU * u * puntos_de_ctrl[1].x +
          3 * oneMinusU * u * u * puntos_de_ctrl[2].x +
          u * u * u * puntos_de_ctrl[3].x;

      y = oneMinusU * oneMinusU * oneMinusU * puntos_de_ctrl[0].y +
          3 * oneMinusU * oneMinusU * u * puntos_de_ctrl[1].y +
          3 * oneMinusU * u * u * puntos_de_ctrl[2].y +
          u * u * u * puntos_de_ctrl[3].y;

      point(x, y);
    }
  }
}*/
