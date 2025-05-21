//Funciones de los actos INCORRECTOS

//Acto 1(1):
void iniciarActo1Incorrecto()
{
  textoActual = acto1Incorrecto;
  letraActual = 0;
  tiempoAnterior = millis();
  mostrarActo0 = false;
  mostrarActo1Incorrecto = true;
}
void iniciarActo2Incorrecto() {
  textoActual = acto2Incorrecto;
  letraActual = 0;
  tiempoAnterior = millis();
  mostrarActo1 = false;
  mostrarActo2Incorrecto = true;
}

void iniciarActo3Incorrecto() {
  textoActual = acto3Incorrecto;
  letraActual = 0;
  tiempoAnterior = millis();
  mostrarActo2 = false;
  mostrarActo3Incorrecto = true;
}
