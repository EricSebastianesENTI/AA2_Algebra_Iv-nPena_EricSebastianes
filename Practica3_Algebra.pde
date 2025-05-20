void setup()
{
  size(1800, 900, P3D);
  background(0);
  textSize(20);
  fill(255);
  frameRate(60);
  
  iniciarActo0();
  SakamotoSprite = loadImage("RyomaSakamoto.png");
  KatsuSprite = loadImage("Katsu.png");
}

void draw()
{
  background(0);
  if (mostrarActo0) 
  {
    mostrarTextoProgresivo();
  }
}
