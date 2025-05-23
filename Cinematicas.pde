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

  image(fondoScroll, 0, 0,  1800, 590);


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
      image(WarioSprite, posWario.x-100, posWario.y - offset, 220, 370);  // No flippado
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
