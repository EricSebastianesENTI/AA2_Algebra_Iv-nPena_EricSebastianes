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
  if (flipped && u < 1.0) {
    u += 0.01; // velocidad
    posicionRyoma.x = trayectoria.coefs[0].x + trayectoria.coefs[1].x * u + trayectoria.coefs[2].x * u * u + trayectoria.coefs[3].x * u * u * u;
    posicionRyoma.y = trayectoria.coefs[0].y + trayectoria.coefs[1].y * u + trayectoria.coefs[2].y * u * u + trayectoria.coefs[3].y * u * u * u;
  }

  // Dibujar a Ryoma
  image(SakamotoSprite, posicionRyoma.x, posicionRyoma.y, 220, 370);
}
