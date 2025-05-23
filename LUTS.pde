PImage botonOriginal;
PImage botonConLUT;
        
   //PImage botonProcesado = aplicarLUTBotones(DecisionSprite);


PImage applyBurnLUT(PImage original) 
{
  PImage result = createImage(original.width, original.height, ARGB);
  original.loadPixels();
  result.loadPixels();

  for (int y = 0; y < original.height; y++) {
    for (int x = 0; x < original.width; x++) {
      int loc = x + y * original.width;
      color c = original.pixels[loc];
      float alpha = alpha(c);

      if (alpha > 0) {
        // Obtenemos brillo de pixel
        float b = brightness(c);

        // Simulación de fuego con ruido animado
        float flame = sin((y + frameCount * 4) * 0.1 + x * 0.1) * 20 +
                      noise(x * 0.05, y * 0.05, frameCount * 0.03) * 40;

        // Aplicamos color de fuego dependiendo del brillo
        color fireColor;
        if (b > 200) {
          fireColor = color(255, 255, 150, alpha); // Amarillo
        } else if (b > 120) {
          fireColor = color(255, 120, 0, alpha); // Naranja
        } else {
          fireColor = color(180, 30, 0, alpha); // Rojo oscuro
        }

        // Combinar con efecto flameante animado
        float flicker = constrain(b + flame, 0, 255);
        fireColor = color(red(fireColor), green(fireColor), blue(fireColor), alpha);
        result.pixels[loc] = fireColor;
      } else {
        result.pixels[loc] = color(0, 0); // transparente
      }
    }
  }

  result.updatePixels();
  return result;
}

//Botones LUT
PImage aplicarLUTBotones(PImage img) {
  PImage out = createImage(img.width, img.height, ARGB);
  img.loadPixels();
  out.loadPixels();

  for (int i = 0; i < img.pixels.length; i++) {
    color c = img.pixels[i];
    
    float r = red(c);
    float g = green(c);
    float b = blue(c);
    float a = alpha(c);

    float rOut = constrain(r * 1.1 + 20, 0, 255);
    float gOut = constrain(g * 0.9, 0, 255);
    float bOut = constrain(b * 1.3 + 30, 0, 255);

    out.pixels[i] = color(rOut, gOut, bOut, a);
  }

  out.updatePixels();
  return out;
}


color colorHSB(float h, float s, float b, float a) {
  colorMode(HSB, 255);
  color c = color(h, s, b, a);
  colorMode(RGB, 255);  // Restaurar
  return c;
}



PImage generateColorfulLUT(PImage original) {
    PImage img = createImage(original.width, original.height, ARGB);
  original.loadPixels();
  img.loadPixels();

  // Oscilación sinusoidal de color en el eje hue
  float hueShift = (sin(radians(frameCount * 4)) * 127 + 128) % 255;

  for (int i = 0; i < original.pixels.length; i++) {
    color c = original.pixels[i];
    float alpha = alpha(c);

    if (alpha > 0) {
      img.pixels[i] = colorHSB(hueShift, 255, 255, alpha);
    } else {
      img.pixels[i] = color(0, 0);
    }
  }

  img.updatePixels();
  return img;
}  
