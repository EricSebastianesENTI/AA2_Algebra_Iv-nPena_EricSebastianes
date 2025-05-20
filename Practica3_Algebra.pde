void setup()
{
  size(1800, 900, P3D);
  startTime = millis();
  background(0);
  textSize(20);
  fill(255);
  frameRate(60);
  
  PVector[] p = new PVector[4];
  p[0] = new PVector(1200, 150);   // Posición inicial de Ryoma
  p[1] = new PVector(1000, 200);   // Control intermedio
  p[2] = new PVector(800, 180);    // Control intermedio
  p[3] = new PVector(600, 150);    // Posición final

  trayectoria = new curva(p);
  trayectoria.calcular_coefs();
  
  posicionRyoma = p[0].copy();
  
  iniciarActo0();
  SakamotoSprite = loadImage("RyomaSakamoto.png");
  KatsuSprite = loadImage("Katsu.png");
  DecisionSprite = loadImage("Decision.png");
  CasaSprite = loadImage("Casa.png");
}

void draw()
{
  background(0);
  image(CasaSprite, 0, 0, 1800, 590);
  if (mostrarActo0) 
  {
    mostrarTextoProgresivo();
    Acto1();
  }
}
