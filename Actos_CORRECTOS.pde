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

void iniciarHistoriaActo2() {
  textoActual = historiaActo2;
  letraActual = 0;
  tiempoAnterior = millis();
  mostrarActo1 = false;
  mostrarActo2 = true;
  decisionTomada = false;
}

void iniciarHistoriaActo2Final() {
  textoActual = historiaActo2Final;
  letraActual = 0;
  tiempoAnterior = millis();
  mostrarActo2 = false;
  mostrarHistoriaActo2Final = true;
}

void iniciarActo3() {
  textoActual = historiaActo3;
  letraActual = 0;
  tiempoAnterior = millis();
  mostrarHistoriaActo2Final = false;
  mostrarActo3 = true;
}
void iniciarHistoriaActo3Final() {
  textoActual = historiaActo3Final;
  letraActual = 0;
  tiempoAnterior = millis();
  mostrarActo3 = false;
  iniciarhistoriaActo3Final = true;
}

//Funcion que escribe el texto
void mostrarTextoProgresivo()
{
  int ahora = millis();
  if (letraActual < textoActual.length() && ahora - tiempoAnterior > velocidad) {
    letraActual++;
    tiempoAnterior = ahora;
  }

  String visible = textoActual.substring(0, letraActual);
  fill(255, 255, 255, 255);
  text(visible, 100, 600, 1600, 250);
  
  if(textoActual.length() == letraActual && !mostrarActo1)
  {
    boolean overSprite1 = mouseX > x1 && mouseX < x1 + w1 && mouseY > y1 && mouseY < y1 + h1;
    boolean overSprite2 = mouseX > x2 && mouseX < x2 + w2 && mouseY > y2 && mouseY < y2 + h2;
    
    if (overSprite1) {
      image(DecisionSprite, x1, y1, w1 + 10, h1 + 10);
      image(DecisionSprite, x2, y2, w2, h2);
    } else if (overSprite2) {
      image(DecisionSprite, x1, y1, w1, h1);
      image(DecisionSprite, x2, y2, w2 + 10, h2 + 10);
    } else {
      image(DecisionSprite, x1, y1, w1, h1);
      image(DecisionSprite, x2, y2, w2, h2);
    }
    
    fill(0);
    textSize(24);
    if (mostrarActo0) {
      text("Tomar té", x1 + w1/2 - 40, y1 + h1/2);
      text("Escuchar", x2 + w2/2 - 40, y2 + h2/2);
    } 
    else if (mostrarActo2) {
      text("", x1 + w1/2 - 70, y1 + h1/2);
      text("", x2 + w2/2 - 90, y2 + h2/2);
    }
    else if (mostrarActo2 && textoActual.equals(historiaActo2Final)) {
     /* text("Con reservas", x1 + w1/2 - 50, y1 + h1/2);
      text("Sin reservas", x2 + w2/2 - 50, y2 + h2/2);*/
      text("Mostrar armas", x1 + w1/2 - 70, y1 + h1/2);
      text("Mostrar documentos", x2 + w2/2 - 90, y2 + h2/2);
    }
    else if (mostraracto2Incorrecto2) {
      text("Dinero", x1 + w1/2 - 30, y1 + h1/2);
      text("Comida", x2 + w2/2 - 30, y2 + h2/2);
    }
    else if (mostrartextoPreActo3Elefante) {
      text("Sí", x1 + w1/2 - 10, y1 + h1/2);
      text("No", x2 + w2/2 - 10, y2 + h2/2);
    }
  }
}
