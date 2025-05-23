void Acto4()
{
  
/*  //Si se elige bien el acto 2
  String historiaActo2Final = 
  "Kaishū le dio unos documentos. El shōgun vende el arroz de Satsuma a cambio de opio, " +
  "y permite que Chōshū sea bombardeado por barcos extranjeros. ¿Realmente creen que Iemochi los protege?\n\n" +
  "En ese momento, ambos clanes dejaron de lado sus disputas y se aliaron para derrocar al shogunato. " +
  "Y firmaron el Pacto Satsuma-Choshu, con Ryoma como garante.";*/
  
/*    //Acto 3
  String historiaActo3 = 
  "En el castillo de Osaka, se encontraba el joven y enfermizo shogun Iemochi Tokugawa. " +
  "Su incompetencia a la hora de tratar con los extranjeros lo ha llevado a una poderosa rebelión.\n\n" +
  "Consejero: \"Majestad, Satsuma y Chōshū han unido fuerzas. El 70% de los daimios apoyan su rebelión.\"\n" +
  "Iemochi (tosiendo sangre): \"¿Y la armada? ¿Los franceses no prometieron ayuda?\"\n" +
  "Consejero: \"Katsu Kaishū saboteó los barcos. Solo nos quedan samuráis con espadas... contra cañones.\"\n\n" +
  "La conspiración: Iemochi ordena a la Mimawarigumi (policía secreta): Maten a Sakamoto. " +
  "Sin él, la alianza se romperá.\n\n" +
  "Unos días después, Ryoma Sakamoto se encontraba descansando en la posada Omiya.\n " ;*/
 
  while(mostrarHistoriaActo2Final)
  {
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
  
  iniciarActo3();
  
  pushMatrix();
    translate(200 + 250, 150);
    scale(-1, 1);
  image(Iemochi, -250, 30, 230, 400);
  popMatrix();
  
  if (animarConsejero) 
  {
  float dx = objetivoX - xConsejero;
  xConsejero += dx * easing;

  // Si está muy cerca, detén la animación
  if (abs(dx) < 1) {
    xConsejero = objetivoX;
    animarConsejero = false;
  }
}

// Dibujar Consejero
image(Consejero, xConsejero, yConsejero, 230, 400);
  

}
