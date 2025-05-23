PImage applyBurnLUT(PImage original) {
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
