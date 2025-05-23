void Acto1()
{
  int elapsed = millis() - startTime;

  // Mostrar Katsu, aplicar flip después de 3 segundos
  if (elapsed < 3000)
  {
    image(KatsuSprite, 200, 150, 250, 400);
  }
  else
  {
    if (!flipped) flipped = true;
    pushMatrix();
    translate(200 + 250, 150);
    scale(-1, 1);
    image(KatsuSprite, 0, 0, 250, 400);
    popMatrix();
  }

  // Mover a Ryoma usando interpolación después de 3 segundos
  if (flipped && u < 1.0)
  {
    u += 0.01; // velocidad
    posicionRyoma.x = trayectoria.coefs[0].x + trayectoria.coefs[1].x * u + trayectoria.coefs[2].x * u * u + trayectoria.coefs[3].x * u * u * u;
    posicionRyoma.y = trayectoria.coefs[0].y + trayectoria.coefs[1].y * u + trayectoria.coefs[2].y * u * u + trayectoria.coefs[3].y * u * u * u;
  }

 if (flipped)
 {
    image(SakamotoAttackSprite, posicionRyoma.x, posicionRyoma.y, 270, 370);
  }
  else
  {
    image(SakamotoSprite, posicionRyoma.x, posicionRyoma.y, 220, 370);
  }  
    noFill();
}

void Acto2()
{
  int elapsed = millis() - startTime;

  if (progresoKatsu < 0.6)
  {
    // Aún no pasó Katsu, Ryoma mira a la derecha
    image(SakamotoTeaSprite, posicionRyoma.x, posicionRyoma.y, 220, 370);
  }
  else
  {
    //flipX en Ryoma
    pushMatrix();
    translate(posicionRyoma.x + 220, posicionRyoma.y);
    scale(-1, 1);
    image(SakamotoTeaSprite, 0, 0, 220, 370);
    popMatrix();
  }

  //Mover a Katsu con la curva de Bezier
  if (progresoKatsu <= 1.0)
  {
    float u = progresoKatsu;
    float oneMinusU = 1 - u;

    float x = oneMinusU * oneMinusU * oneMinusU * puntosBezier[0].x +
              3 * oneMinusU * oneMinusU * u * puntosBezier[1].x +
              3 * oneMinusU * u * u * puntosBezier[2].x +
              u * u * u * puntosBezier[3].x;

    float y = oneMinusU * oneMinusU * oneMinusU * puntosBezier[0].y +
              3 * oneMinusU * oneMinusU * u * puntosBezier[1].y +
              3 * oneMinusU * u * u * puntosBezier[2].y +
              u * u * u * puntosBezier[3].y;

    pushMatrix();
    translate(x + 220, y);
    scale(-1, 1);
    image(KatsuSprite, 0, 0, 220, 370);
    popMatrix();

    progresoKatsu += 0.003; // Velocidad de avance
    progresoKatsu = min(progresoKatsu + 0.003, 1.0);
  }
}
void Acto3()
{
textSize(20);
  image(TemploSprite, 0, 0, 1800, 590);
  
 image(KidoSprite,1100, 230, 200, 350);
 image(SaigoSprite,1300, 230, 250, 350);
  
  pushMatrix();
    translate(200 + 250, 150);
    scale(-1, 1);
    image(KatsuIdle, -500, 17, 250, 410);
    popMatrix();
    
    pushMatrix();
    translate(200 + 250, 150);
    scale(-1, 1);
    image(SakamotoSprite, -250, 30, 230, 400);
    popMatrix();
}


void CinematicaActo3()
{
    if(mostrarHistoriaActo2Final == true)
      {
      image(KidoSprite,1100, 230, 200, 350);
     image(SaigoSprite,1300, 230, 250, 350);
      
      pushMatrix();
        translate(200 + 250, 150);
        scale(-1, 1);
        image(KatsuIdle, -500, 17, 250, 410);
        popMatrix();
        
        pushMatrix();
        translate(200 + 250, 150);
        scale(-1, 1);
        image(SakamotoSprite, -250, 30, 230, 400);
        popMatrix();
      }

}

void Acto4()
{
  image(TemploSprite, 0, 0, 1800, 590); // Usa la imagen adecuada
    
  if(textoActual.length() == letraActual && mostrarHistoriaActo2Final == true)
  {
    iniciarActo3();  
  }
  else
  {
    // Iemochi con un FlipX
    pushMatrix();
    translate(200 + 250, 150);
    scale(-1, 1);
    image(Iemochi, -250, 30, 230, 400);
    popMatrix();
    
    // Mover Consejero suavemente hacia su objetivo
    if (animarConsejero) {
      float dx = objetivoX - xConsejero;
      xConsejero += dx * easing;
    
      // Si está muy cerca, detén la animación
      if (abs(dx) < 1) {
        xConsejero = objetivoX;
        animarConsejero = false;
      }
    }
    
    // Dibujar Consejero
    image(Consejero, xConsejero, yConsejero, 230, 400);
  }
}

void CinematicaFinalCorrecta()
{
  image(TemploSprite, 0, 0, 1800, 590);
    pushMatrix();
    translate(200 + 250, 150);
    scale(-1, 1);
    image(SakamotoHeridoSprite, -250, 30, 300, 370);
    popMatrix();
}


void ElefanteEscena() {
  image(TemploSprite, 0, 0, 1800, 590);
  if (!elefanteEscenaIniciada) {
    elefanteEscenaIniciada = true;
    tiempoElefante = millis();
    posElefante = new PVector(800, 500);
    posCaparazon = new PVector(width + 100, 100); 
    estadoElefante = 0;
    elefanteVolando = false;
    elefanteFlipEscala = 1;
    anguloCaparazon = 0;
  }

  background(0); 
  imageMode(CENTER);

  if (estadoElefante == 0) {
    // --- Estado 0: Elefante hace flips durante 2 segundos ---
    float duracion = millis() - tiempoElefante;

    elefanteFlipEscala = sin(radians(frameCount * 15)) > 0 ? 1 : -1;

    pushMatrix();
    translate(posElefante.x, posElefante.y);
    scale(elefanteFlipEscala, 1);
    image(ElefanteSprite, 0, 0, 260, 370);
    popMatrix();

    if (duracion > 2000) {
      estadoElefante = 1;
      tiempoElefante = millis();
    }

  } else if (estadoElefante == 1) {
    // --- Estado 1: Caparazón entra desde la derecha y se coloca sobre el elefante ---
    if (posCaparazon.x > posElefante.x) {
      posCaparazon.x -= 15;  // Se desplaza horizontalmente hacia el elefante
    } else {
      estadoElefante = 2;
      tiempoElefante = millis();
    }

    image(ElefanteSprite, posElefante.x, posElefante.y, 260, 370);
    image(CaparazonSprite, posCaparazon.x, posCaparazon.y, 80, 80);

  } else if (estadoElefante == 2) {
    // --- Estado 2: Caparazón gira sobre el elefante ---
    anguloCaparazon += 0.3;
    if (millis() - tiempoElefante > 1500) {
      estadoElefante = 3;
      tiempoElefante = millis();
    }

    image(ElefanteSprite, posElefante.x, posElefante.y, 260, 370);
    pushMatrix();
    translate(posElefante.x, posElefante.y - 100);
    rotate(anguloCaparazon);
    image(CaparazonSprite, 0, 0, 80, 80);
    popMatrix();

  } else if (estadoElefante == 3) {
    // --- Estado 3: El caparazón cae en picado ---
    posCaparazon.y += 20;

    image(ElefanteSprite, posElefante.x, posElefante.y, 260, 370);
    image(CaparazonSprite, posElefante.x, posCaparazon.y, 80, 80);

    if (posCaparazon.y >= posElefante.y) {
      estadoElefante = 4;
      tiempoElefante = millis();
    }

  } else if (estadoElefante == 4) {
    // --- Estado 4: Elefante sale volando tras el impacto ---
    posElefante.x += 20;
    posElefante.y -= 12;

    pushMatrix();
    translate(posElefante.x, posElefante.y);
    rotate(radians(frameCount * 10));
    image(ElefanteSprite, 0, 0, 260, 370);
    popMatrix();

    if (posElefante.x > width || posElefante.y < -200) {
      estadoElefante = 5;
      tiempoElefante = millis();
    }

    // Caparazón queda quieto en el punto de impacto
    image(CaparazonSprite, posElefante.x - 50, posElefante.y + 50, 80, 80);

  } else if (estadoElefante == 5) {
    // --- Estado final: texto de cierre ---
    fill(255);
    textAlign(CENTER);
    textSize(30);
    text("¡El elefante ha sido eliminado!", width / 2, height / 2);
  }
}


int tiempoInicioSecuestro = -1;
int delayBowserStart = 2000; // 2 segundos de espera antes de iniciar el secuestro


PVector posicionBowser;
PVector destinoKatsu = new PVector(400, 200);
PVector posicionRyomas = new PVector(200, 200);
PVector posicionRyomaPersecucion;

float progresoBowser = 0.0;
float progresoPersecucion = 0.0;
float thetaTambaleo = 0;

boolean secuestroIniciado = false;
boolean katsuSecuestrado = false;
boolean bowserEmpezadoAMoverse = false;
boolean mostrarRyoma = true;
boolean mostrarKatsu = true;




void BowserSecuestraKatsu() {
  if (!secuestroIniciado) {
    posicionRyomaPersecucion = new PVector(posicionRyomas.x, posicionRyomas.y);
    posicionBowser = new PVector(width + 200, 300);  // Bowser entra desde la derecha
    secuestroIniciado = true;
    tiempoInicioSecuestro = millis();
  }

  thetaTambaleo += 0.05;
  float desplazamiento = sin(thetaTambaleo) * 5;
  PVector katsuPos = new PVector(destinoKatsu.x, destinoKatsu.y + desplazamiento);

  // Mostrar Katsu flippeado
  if (mostrarKatsu) {
    pushMatrix();
    translate(katsuPos.x + 110, katsuPos.y);
    scale(1, 1);
    rotate(sin(thetaTambaleo) * 0.03);
    image(KatsuSprite, -110, 0, 220, 370);
    popMatrix();
  }

  // Mostrar Ryoma en espera (flippeado)
  if (mostrarRyoma) {
    pushMatrix();
    translate(posicionRyomas.x + 110, posicionRyomas.y + desplazamiento);
    scale(-1, 1);
    rotate(sin(thetaTambaleo) * 0.03);
    image(SakamotoTeaSprite, -110, -desplazamiento, 220, 370);
    popMatrix();
  }

  // Esperar antes de mover a Bowser
  if (!katsuSecuestrado && millis() - tiempoInicioSecuestro >= delayBowserStart) {
    bowserEmpezadoAMoverse = true;
  }

  if (!katsuSecuestrado && bowserEmpezadoAMoverse) {
    if (progresoBowser < 1.0) {
      progresoBowser += 0.01;  // Velocidad original
      posicionBowser.x = lerp(width + 200, katsuPos.x, progresoBowser);
      posicionBowser.y = lerp(300, katsuPos.y, progresoBowser);
      image(Bowser, posicionBowser.x, posicionBowser.y, 380, 380);
    } else {
      katsuSecuestrado = true;
      progresoBowser = 0.0;
      mostrarKatsu = false;
      mostrarRyoma = false;
    }
  }

  // Bowser huye con Katsu
  if (katsuSecuestrado) {
    if (progresoBowser <= 1.0) {
      float u = progresoBowser;
      float curvaY = -300 * u * u;
      float x = lerp(katsuPos.x, width + 300, u);
      float y = katsuPos.y + curvaY;

      pushMatrix();
      translate(x + 220, y);
      scale(-1, 1);
      image(KatsuBowser, 0, 0, 420, 420);
      popMatrix();

      progresoBowser += 0.01;
    }

    // Ryoma empieza a perseguir con retraso, pero sigue visible mientras espera
    if (progresoBowser > 0.3 && progresoPersecucion < 0.5) {
      progresoPersecucion += 0.01;
      posicionRyomaPersecucion.x = lerp(posicionRyomas.x, width + 200, progresoPersecucion);
    }

    // Mostrar sprite de Ryoma corriendo (flippeado)
    pushMatrix();
    translate(posicionRyomaPersecucion.x + 110, posicionRyomas.y);
    scale(-1, 1);
    image(SakamotoSprite, -110, 0, 220, 370);
    popMatrix();   
  }
}





float scrollX = 0;
int estadoWario = 0;

boolean shogunCalcinado = false;

PVector posBowser = new PVector(width/2 - 125, height/2 - 190);
PVector posShogun = new PVector(width - 300, height/2 - 190);
PVector posRyoma = new PVector(-220, height - 370);
PVector posWario = new PVector(width - 300, height - 370);

//PVector posBowser, posShogun, posRyoma, posWario;
PVector bezierA, bezierB, bezierC, bezierD;
float bezierT = 0;
boolean warioIniciado = false;
boolean bowserRiendo = false;

void iniciarWario() {
  //textoActual = acto2Incorrecto2;
  warioIniciado = true;
  estadoWario = 0;
  tiempoEvento = millis();
  shogunCalcinado = false;

  // Posiciones iniciales
  posBowser = new PVector(width/2 - 125, height/2 - 250);
  posShogun = new PVector(width - 300, height/2 - 250);
  posRyoma = new PVector(-220, height - 750);
  posWario = new PVector(width - 300, height - 750);

  // Puntos Bézier para KatsuBowser
  bezierA = new PVector(100, height/2 - 190);
  bezierB = new PVector(200, 100);
  bezierC = new PVector(width - 200, 100);
  bezierD = new PVector(width - 1000, height/2 - 190);
  bezierT = 0;
}

void drawFlippedX(PImage img, float x, float y, float w, float h) {
  pushMatrix();
  translate(x + w, y);  // Desplaza al borde derecho
  scale(-1, 1);         // Invierte horizontalmente
  image(img, 0, 0, w, h);
  popMatrix();
}


void Wario() {
  if (!warioIniciado) {
    iniciarWario();
  }
  
    // Dibujar la escena actual según el estado
  switch(estadoWario) {
    case 0:
      // Escena 0: Movimiento en curva
      image(fondoScroll, 0, 0, 1800, 590);
      // Resto del código para esta escena...
      break;
      
    case 1:
      // Escena 1: Templo - Bowser quema al Shogun
      image(fondoTemplo, 0, 0, 1800, 590);
      // Resto del código para esta escena...
      break;
      
    case 2:
      // Escena 2: Ryoma encuentra a Wario
      image(fondoCalleWario, 0, 0, 1800, 590);
      // Resto del código para esta escena...
      break;
  }


  // ESCENA 0: Movimiento en curva de KatsuBowser con exclamación
  if (estadoWario == 0) {
    float u = bezierT;
    float oneMinusU = 1 - u;

    float x = oneMinusU * oneMinusU * oneMinusU * bezierA.x +
              3 * oneMinusU * oneMinusU * u * bezierB.x +
              3 * oneMinusU * u * u * bezierC.x +
              u * u * u * bezierD.x;

    float y = oneMinusU * oneMinusU * oneMinusU * bezierA.y +
              3 * oneMinusU * oneMinusU * u * bezierB.y +
              3 * oneMinusU * u * u * bezierC.y +
              u * u * u * bezierD.y;

    drawFlippedX(KatsuBowser, x, y, 380, 420);  // Flippado horizontalmente
    bezierT += 0.003;
    bezierT %= 1.0;

    // Mostrar exclamación después de 1 segundo
    if (millis() - tiempoEvento > 1000) {
      image(ExclamacionSprite, x + 130, y - 30, 50, 50);
    }

    // Cambiar de escena tras 3 segundos
    if (millis() - tiempoEvento > 4000) {
      estadoWario = 1;
      tiempoEvento = millis();
    }

  } else if (estadoWario == 1) {
    // ESCENA 1: Templo – Bowser quema al Shogun
    image(fondoTemplo, 0, 0,  1800, 590);

    // Mostrar a Bowser si aún no está riéndose
    if (!bowserRiendo) {
      drawFlippedX(Bowser, posBowser.x, posBowser.y, 380, 380);
    }

    // Mostrar a Katsu al lado de Bowser, siempre flippado
    drawFlippedX(KatsuBowser, posBowser.x - 200, posBowser.y, 220, 320);

    // Mostrar Shogun o su versión quemada
    if (!shogunCalcinado) {
      image(ShogunSprite, posShogun.x, posShogun.y, 220, 370);
    } else {
      image(shogunQuemado, posShogun.x, posShogun.y, 220, 370);
    }

    // Calcinado del Shogun tras 1.5 segundos
    if (millis() - tiempoEvento > 1500 && !shogunCalcinado) {
      shogunQuemado = applyBurnLUT(ShogunSprite);  // Aplicar LUT de fuego
      shogunCalcinado = true;
      tiempoEvento = millis();  // Reiniciar para animación de risa
    }

    // Mostrar animación de risa de Bowser
    if (shogunCalcinado && millis() - tiempoEvento > 1500) {
      bowserRiendo = true;

      pushMatrix();
      translate(posBowser.x + 190, posBowser.y + 190);  // Centro del sprite
      scale(-1, 1);  // Flip en X
      rotate(sin(frameCount * 0.1) * 0.1);  // Oscilación leve
      image(Bowser, -190, -190, 380, 380);  // Mismo tamaño
      popMatrix();

      // Ir a escena 2 después de 3 segundos
      if (millis() - tiempoEvento > 3000) {
        estadoWario = 2;
        tiempoEvento = millis();
      }
    }

  } else if (estadoWario == 2) {
    // ESCENA 2: Ryoma se encuentra con Wario en la calle
    image(fondoCalleWario, 0, 0,  1800, 590);

    // Ryoma avanza hacia el centro de la pantalla
    if (posRyoma.x < width / 2 - 250) {
      posRyoma.x += 4;
      drawFlippedX(SakamotoSprite, posRyoma.x, posRyoma.y, 220, 370);
    } else {
      // Conversación: ambos se mueven ligeramente como si hablaran
      float offset = sin(frameCount * 0.1) * 5;
      drawFlippedX(SakamotoSprite, posRyoma.x, posRyoma.y + offset, 220, 370);
      drawFlippedX(WarioSprite, posWario.x-100, posWario.y - offset, 370, 370);  // No flippado
    
  }
  }
}



boolean warioDineroIniciado = false;
int estadoWarioDinero = 0;
int tiempoEvento = 0;

// Variables de animación específicas
float ryomaRotacion = 0;
boolean ryomaCayendo = false;
float posBowserX = 100;
float posWarioX = 800;
float posRyomaX;
float posRyomaY = 600;
float ryomaCaidaY = 300;
PImage escenaFinal1, escenaFinal2, escenaFinal3; // Asegúrate de cargarlas antes

void WarioDinero() {
  if (!warioDineroIniciado) {
    warioDineroIniciado = true;
    estadoWarioDinero = 0;
    tiempoEvento = millis();
    posBowserX = 100;
    posWarioX = 800;
    posRyomaX = 600;
    ryomaRotacion = 0;
    ryomaCayendo = false;
    ryomaCaidaY = 300;
  }

  background(0);

  if (estadoWarioDinero == 0) {
    // ---------- ESCENA PRINCIPAL ----------
    image(fondoCalleWario, 0, 0, 1800, 590);

    // Bowser se acerca a Ryoma
    if (posBowserX < posRyomaX - 120) {
      posBowserX += 2;
    } else {
      ryomaCayendo = true;
    }

    // Wario se va completamente fuera de la pantalla
    if (posWarioX < width + 300) {
      posWarioX += 3.5;
    }

    // Ryoma cae rotando más abajo
    if (ryomaCayendo && ryomaCaidaY < height - 50) {
      ryomaCaidaY += 5;
      ryomaRotacion += 0.1;
    }

    // Dibujar Wario
    image(WarioSprite, posWarioX, 150, 370, 370);

    // Dibujar Bowser flipeado horizontalmente
    pushMatrix();
    translate(posBowserX + 190, 300);
    scale(-1, 1);
    image(Bowser, -125, -190, 380, 380);
    popMatrix();

    // Dibujar Ryoma rotando mientras cae
    pushMatrix();
    translate(posRyomaX + 110, ryomaCaidaY + 185);
    rotate(ryomaRotacion);
    image(SakamotoSprite, -110, -250, 220, 370);
    popMatrix();

    // Espera para pasar a las escenas finales
    if (millis() - tiempoEvento > 6000) {
      estadoWarioDinero = 1;
      tiempoEvento = millis();
    }

  } else if (estadoWarioDinero == 1) {
    image(escenaFinal1, 0, 0, 1800, 590);
    if (millis() - tiempoEvento > 3000) {
      estadoWarioDinero = 2;
      tiempoEvento = millis();
    }

  } else if (estadoWarioDinero == 2) {
    image(escenaFinal2, 0, 0, 1800, 590);
    if (millis() - tiempoEvento > 3000) {
      estadoWarioDinero = 3;
      tiempoEvento = millis();
    }

  } else if (estadoWarioDinero == 3) {
    image(escenaFinal3, 0, 0, 1800, 590);
    // Fin de animación
  }
}






PVector posRyomaFinal, posWarioFinal, posBowserFinal;
boolean warioFinalIniciado = false;
int estadoWarioFinal = 0;
int tiempoEventoFinal = 0;
float warioRotacionFinal = 0;
boolean warioGirandoFinal = false;
float velocidadWarioFinal = 0;

PImage imagenFinal1, imagenFinal2;


void iniciarWarioFinal() {
  posRyomaFinal = new PVector(50, 200);
  posWarioFinal = new PVector(-400, 200);
  posBowserFinal = new PVector(width - 650, 380);

  warioFinalIniciado = true;
  estadoWarioFinal = 0;
  tiempoEventoFinal = millis();
  warioRotacionFinal = 0;
  warioGirandoFinal = false;
  velocidadWarioFinal = 0;
}
void WarioFinal() {
if (!warioFinalIniciado) {
    // Inicialización de variables para la animación final
    warioFinalIniciado = true;
    tiempoEventoFinal = millis();
  }
  background(0);
  image(fondoCalleWario, 0, 0, 1800, 590);

  if (estadoWarioFinal == 0) {
    // ESCENA 0: Entrada
    if (posRyomaFinal.x < width / 2 - 100) posRyomaFinal.x += 3;
    if (posWarioFinal.x < width / 2 - 250) posWarioFinal.x += 3;

    pushMatrix();
    translate(posRyomaFinal.x + 220, posRyomaFinal.y);
    scale(-1, 1);
    image(SakamotoSprite, 0, 0, 220, 370);
    popMatrix();

    image(WarioSprite, posWarioFinal.x, posWarioFinal.y, 370, 370);

   
    translate(posBowserFinal.x + 190, posBowserFinal.y);
   
    image(Bowser, -125, -190, 380, 380);
   
    if (millis() - tiempoEventoFinal > 3000) {
      estadoWarioFinal = 1;
      tiempoEventoFinal = millis();
    }

  } else if (estadoWarioFinal == 1) {
    // ESCENA 1: Conversación
    float offset = sin(frameCount * 0.1) * 5;

    pushMatrix();
    translate(posRyomaFinal.x + 220, posRyomaFinal.y + offset);
    scale(-1, 1);
    image(SakamotoSprite, 0, 0, 220, 370);
    popMatrix();

    image(WarioSprite, posWarioFinal.x, posWarioFinal.y - offset, 370, 370);


    translate(posBowserFinal.x + 190, posBowserFinal.y);

    image(Bowser, -125, -190, 380, 380);


    if (millis() - tiempoEventoFinal > 3000) {
      estadoWarioFinal = 2;
      tiempoEventoFinal = millis();
      warioGirandoFinal = true;
    }

  } else if (estadoWarioFinal == 2) {
    // ESCENA 2: Giro y embestida
    pushMatrix();
    translate(posRyomaFinal.x + 220, posRyomaFinal.y);
    scale(-1, 1);
    image(SakamotoSprite, 0, 0, 220, 370);
    popMatrix();

    if (warioGirandoFinal && warioRotacionFinal < 8 * TWO_PI) {
      warioRotacionFinal += 0.4;
      posWarioFinal.y -= 1.2;
      pushMatrix();
      translate(posWarioFinal.x + 110, posWarioFinal.y + 185);
      rotate(warioRotacionFinal);
      imageMode(CENTER);
      image(WarioSprite, 0, 0, 370, 370);
      imageMode(CORNER);
      popMatrix();
    } else {
      warioGirandoFinal = false;
      velocidadWarioFinal = 10;
      posWarioFinal.x += velocidadWarioFinal;
      image(WarioSprite, posWarioFinal.x, posWarioFinal.y, 370, 370);

      if (posWarioFinal.x + 220 >= posBowserFinal.x) {
        estadoWarioFinal = 3;
        tiempoEventoFinal = millis();
      }
    }

    pushMatrix();
    translate(posBowserFinal.x + 190, posBowserFinal.y);
    scale(-1, 1);
    image(Bowser, -125, -190, 380, 380);
    popMatrix();

  } else if (estadoWarioFinal == 3) {
    // ESCENA 3: Bowser sale volando
    pushMatrix();
    translate(posRyomaFinal.x + 220, posRyomaFinal.y);
    scale(-1, 1);
    image(SakamotoSprite, 0, 0, 220, 370);
    popMatrix();

    image(WarioSprite, posWarioFinal.x, posWarioFinal.y, 370, 370);

    posBowserFinal.y -= 12;
    posBowserFinal.x += 6;

    pushMatrix();
    translate(posBowserFinal.x + 190, posBowserFinal.y);
    scale(-1, 1);
    image(Bowser, -125, -190, 380, 380);
    popMatrix();

    if (millis() - tiempoEventoFinal > 1000) {
      estadoWarioFinal = 4;
      tiempoEventoFinal = millis();
    }

  } else if (estadoWarioFinal == 4) {
    // ESCENA 4: Imagen final 1
    image(CasaSprite, 0, 0, 1800, 590);

    if (millis() - tiempoEventoFinal > 3000) {
      estadoWarioFinal = 5;
      tiempoEventoFinal = millis();
    }

  } else if (estadoWarioFinal == 5) {
    // ESCENA 5: Imagen final 2
    image(CasaSprite, 0, 0, 1800, 590);
  }
}


boolean escenaEstrellaIniciada = false;
int estadoEstrella = 0;
int tiempoEventoEstrella = 0;

PVector posRyomaEstrella = new PVector(200, 300);
PVector posMercenario = new PVector(1000, 300);

boolean mercenarioGolpeado = false;

PImage sakamotoLUT;  // LUT de Ryoma con efecto de estrella
PImage MercenarioSprite;  // Sprite del mercenario con fusil
PImage fondoCampo;          // Fondo de la escena

PVector posEstrella;
boolean estrellaActiva = false;
PImage estrellaSprite;

void inicializarEscenaEstrellaFinal() {
  escenaEstrellaIniciada = true;
  estadoEstrella = 0;
  tiempoEventoEstrella = millis();
  letraActual = 0;
  textoActual = acto3Incorrecto3;

  posRyomaEstrella = new PVector(200, 1000);
  posMercenario = new PVector(1000, 100);
  mercenarioGolpeado = false;

  posEstrella = new PVector(posRyomaEstrella.x + 80, -100);  // Empieza arriba
  estrellaActiva = false;
}

void EscenaEstrellaFinal() {
  
  mostrarActo3 = false;
  letraActual = 0;
  textoActual = acto3Incorrecto3;
  
  if (!escenaEstrellaIniciada) {
    escenaEstrellaIniciada = true;
    tiempoEventoEstrella = millis();
    posEstrella = new PVector(posRyomaEstrella.x + 80, -100);  // Empieza desde arriba
    estrellaActiva = false;
  }

  background(0);
  image(CasaSprite, 0, 0, 1800, 590);

  if (estadoEstrella == 0) {
    // --- ESCENA INICIAL: RYOMA, MERCENARIO Y ESTRELLA ---
    image(SakamotoSprite, posRyomaEstrella.x, posRyomaEstrella.y-150, 220, 370);
    image(MercenarioSprite, posMercenario.x, posMercenario.y-150, 220, 370);

    if (posEstrella.y < posRyomaEstrella.y - 20) {
      posEstrella.y += 5;
    } else {
      estrellaActiva = true;
      estadoEstrella = 1;
      tiempoEventoEstrella = millis();
    }
    image(estrellaSprite, posEstrella.x, posEstrella.y, 60, 60);

  } else if (estadoEstrella == 1) {
    // --- RYOMA CON ESTRELLA (COLORINES) ---
    sakamotoLUT = generateColorfulLUT(SakamotoSprite);
    image(sakamotoLUT, posRyomaEstrella.x, posRyomaEstrella.y-150, 220, 370);
    image(MercenarioSprite, posMercenario.x, posMercenario.y-150, 220, 370);

    if (millis() - tiempoEventoEstrella > 1000) {
      estadoEstrella = 2;
      tiempoEventoEstrella = millis();
    }

  } else if (estadoEstrella == 2) {
    // --- EMBESTIDA DE RYOMA ---
    posRyomaEstrella.x += 45;

    if (!mercenarioGolpeado) {
      sakamotoLUT = generateColorfulLUT(SakamotoSprite);
      image(sakamotoLUT, posRyomaEstrella.x, posRyomaEstrella.y-150, 220, 370);
      image(MercenarioSprite, posMercenario.x, posMercenario.y-150, 220, 370);

      if (posRyomaEstrella.x + 180 >= posMercenario.x) {
        mercenarioGolpeado = true;
      }

    } else {
      // --- MERCENARIO SALE VOLANDO ROTANDO ---
      posMercenario.x += 12;
      posMercenario.y -= 6;

      sakamotoLUT = generateColorfulLUT(SakamotoSprite);
      image(sakamotoLUT, posRyomaEstrella.x, posRyomaEstrella.y-150, 220, 370);

      pushMatrix();
      translate(posMercenario.x + 110, posMercenario.y + 185);
      rotate(radians(frameCount * 12));
      image(MercenarioSprite, -110, posRyomaEstrella.y-150, 220, 370);
      popMatrix();

      if (posMercenario.x > width) {
        estadoEstrella = 3;
        tiempoEventoEstrella = millis();
      }
    }

  } else if (estadoEstrella == 3) {
    // --- FINAL: RYOMA VICTORIOSO ---
    sakamotoLUT = generateColorfulLUT(SakamotoSprite);
    image(sakamotoLUT, posRyomaEstrella.x, posRyomaEstrella.y, 220, 370);
    fill(255);
    textAlign(CENTER);
    textSize(30);
    text("¡Ryoma ha vencido con el poder de la estrella!", width / 2, 100);
  }
}
