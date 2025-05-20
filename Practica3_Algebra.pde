void setup()
{
  size(800, 600);
  background(0);
  textSize(20);
  fill(255);
  frameRate(60);
  
  iniciarActo0();
}

void draw()
{
  background(0);
  if (mostrarActo0) 
  {
    mostrarTextoProgresivo();
  }
}
