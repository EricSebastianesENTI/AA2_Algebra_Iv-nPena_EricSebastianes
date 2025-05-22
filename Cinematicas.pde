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
