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



void iniciarhistoriaActo3Final() {
  textoActual = historiaActo3Final;
  letraActual = 0;
  tiempoAnterior = millis();
  mostrarActo3Incorrecto = false;
  mostrarhistoriaActo3Final = true;
}
void iniciaracto2Incorrecto2() {
  textoActual = acto2Incorrecto2;
  letraActual = 0;
  tiempoAnterior = millis();
  mostrarActo1Incorrecto = false;
  mostraracto2Incorrecto2 = true;
    warioIniciado = false;
}
void iniciaracto2WarioComida() {
  textoActual = acto2WarioComida;
  letraActual = 0;
  tiempoAnterior = millis();
  mostraracto2Incorrecto2 = false;
  mostraracto2WarioComida = true;
}
void iniciaracto2WarioDinero() {
  textoActual = acto2WarioDinero;
  letraActual = 0;
  tiempoAnterior = millis();
  mostraracto2Incorrecto2 = false;
  mostraracto2WarioDinero = true;
}
void iniciartextoPreActo3Elefante() {
  textoActual = textoPreActo3Elefante;
  letraActual = 0;
  tiempoAnterior = millis();
  mostrarActo2 = false;
  mostrartextoPreActo3Elefante = true;
}

void iniciaracto3Incorrecto3() {
  textoActual = acto3Incorrecto3;
  letraActual = 0;
  tiempoAnterior = millis();
  mostrarActo2 = false;
  mostraracto3Incorrecto3 = true;
}
void iniciarActo3Incorrecto() {
  textoActual = acto3Incorrecto; 
  letraActual = 0;
  tiempoAnterior = millis();
  mostrartextoPreActo3Elefante = false;
  mostrarActo3Incorrecto = true;
}

void iniciaracto3Incorrecto2() {
  textoActual = acto3Incorrecto2;
  letraActual = 0;
  tiempoAnterior = millis();
  mostrartextoPreActo3Elefante = false;
  mostraracto3Incorrecto2 = true;
}
