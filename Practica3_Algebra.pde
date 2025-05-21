void setup()
{

      minim = new Minim(this);
  player = minim.loadFile("kmk.mp3");
  player.play();
   colores();
  
  
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
   
    Acto1();

    generacionOndas();

    mostrarTextoProgresivo();
    
  }
   else if (mostrarActo1 || mostrarActo1Incorrecto) {
    // Aquí pondrías la cinemática del acto 1
    generacionOndas();
    mostrarTextoProgresivo();
  } 
  else if (mostrarActo2 || mostrarActo2Incorrecto) {
    // Cinemática del acto 2
    generacionOndas();
    mostrarTextoProgresivo();
  } 
  else if (mostrarActo3 || mostrarActo3Incorrecto) {
    // Cinemática del acto 3
    generacionOndas();
    mostrarTextoProgresivo();
  }
}
