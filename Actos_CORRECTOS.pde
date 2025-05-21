//Funciones de los actos CORRECTOS

void iniciarActo0()
{
  textoActual = historiaActo0;
  letraActual = 0;
  tiempoAnterior = millis();
  mostrarActo0 = true;
}

void iniciarActo1()
{
  textoActual = historiaActo1;
  letraActual = 0;
  tiempoAnterior = millis();
  mostrarActo0 = false;
  mostrarActo1 = true;
}

void iniciarActo2()
{
  textoActual = historiaActo2;
  letraActual = 0;
  tiempoAnterior = millis();
  mostrarActo1 = false;
  mostrarActo2 = true;
}

void iniciarActo3()
{
  textoActual = historiaActo3;
  letraActual = 0;
  tiempoAnterior = millis();
  mostrarActo2 = false;
  mostrarActo3 = true;
}

//Funcion que escribe el texto
void mostrarTextoProgresivo()
{
  int ahora = millis();
  if (letraActual < textoActual.length() && ahora - tiempoAnterior > velocidad)
  {
    letraActual++;
    tiempoAnterior = ahora;
  }

  String visible = textoActual.substring(0, letraActual);
  //fill(255, 220);
  //text(visible, 50, 50, 700, 500);
  //text(visible, 100, 600, 1600, 250);
  for (int i = 6; i > 0; i--) {
    fill(255, 255, 255, 255);  // color cálido con transparencia
    text(visible, 100, 600, 1600, 250);
  }
  if(textoActual.length() == letraActual)
  {
    image(DecisionSprite, 400, 500, 250, 90);
    image(DecisionSprite, 1100, 500, 250, 90);
  }
}
