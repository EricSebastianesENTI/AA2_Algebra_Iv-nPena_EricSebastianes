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
void mostrarTextoProgresivo() {
  int ahora = millis();
  if (letraActual < textoActual.length() && ahora - tiempoAnterior > velocidad) {
    letraActual++;
    tiempoAnterior = ahora;
  }

  String visible = textoActual.substring(0, letraActual);
  fill(255, 255, 255, 255);
  text(visible, 100, 600, 1600, 250);
  
  // Solo mostrar opciones si se ha completado el texto
  if(textoActual.length() == letraActual) {
    boolean overSprite1 = mouseX > x1 && mouseX < x1 + w1 && mouseY > y1 && mouseY < y1 + h1;
    boolean overSprite2 = mouseX > x2 && mouseX < x2 + w2 && mouseY > y2 && mouseY < y2 + h2;
    
    // Efecto hover
    if (overSprite1) {
      image(DecisionSprite, x1, y1, w1 + 10, h1 + 10);
      image(DecisionSprite, x2, y2, w2, h2);
    } 
    else if (overSprite2) {
      image(DecisionSprite, x1, y1, w1, h1);
      image(DecisionSprite, x2, y2, w2 + 10, h2 + 10);
    } 
    else {
      image(DecisionSprite, x1, y1, w1, h1);
      image(DecisionSprite, x2, y2, w2, h2);
    }
    
    // Mostrar texto de decisiones según el acto actual
    fill(255);
    textSize(24);
    if (mostrarActo0) {
      text("secuestrar", x1 + w1/2 - 60, y1 + h1/2);
      text("Escuchar a Kaishu", x2 + w2/2 - 80, y2 + h2/2);
    } 
    else if (mostrarActo1) {
      text("Mostrar armas occidentales", x1 + w1/2 - 120, y1 + h1/2);
      text("Mostrar documentos", x2 + w2/2 - 90, y2 + h2/2);
    }
    // Añade más condiciones para otros actos según necesites
  }
}
