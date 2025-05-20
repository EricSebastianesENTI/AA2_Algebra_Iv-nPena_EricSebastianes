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
