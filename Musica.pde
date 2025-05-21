import ddf.minim.*;


Minim minim;
AudioPlayer player;

int numOndas = 7;       // Número de ondas
float separacion = 40;  // Separación vertical entre ondas
float alturaBase = 625;  // Valores más bajos = más arriba; más altos = más abajo

color[] colores;

void stop() {
  player.close();
  minim.stop();
  super.stop();
}
void colores() 
{
   // Crear una paleta de colores
  colores = new color[numOndas];
  for (int i = 0; i < numOndas; i++) {
    colores[i] = color(random(30, 70), random(30, 70), random(30, 70));
  }
}

void generacionOndas()
{
    noFill();
  
  // Dibujar varias ondas una encima de otra
  for (int j = 0; j < numOndas; j++) {
    stroke(colores[j]);
    beginShape();
    for (int i = 0; i < player.bufferSize(); i++) {
      float x = map(i, 0, player.bufferSize(), 0, width);
      float y = alturaBase + j * separacion + player.left.get(i) * 100;
      vertex(x, y);
    }
    endShape();
  }

}
