void setup()
{
      minim = new Minim(this);
  player = minim.loadFile("RyomaMusic.mp3");
  player.loop();
   colores();
  
  size(1800, 900, P3D);
  startTime = millis();
  background(0);
  textSize(20);
  fill(255);
  frameRate(60);
  
  //Curva Interpolacion
  PVector[] p = new PVector[4];
  p[0] = new PVector(1200, 150);   // Posición inicial de Ryoma
  p[1] = new PVector(1000, 200);   // Control intermedio
  p[2] = new PVector(800, 180);    // Control intermedio
  p[3] = new PVector(600, 150);    // Posición final
  
  trayectoria = new curva(p);
  trayectoria.calcular_coefs();
  
  posicionRyoma = p[0].copy();
  
  //Curva de Bezier
 puntosBezier = new PVector[]
 {
  new PVector(200, 150),
  new PVector(400, 200),
  new PVector(posicionRyoma.x, posicionRyoma.y),
  new PVector(posicionRyoma.x +30, posicionRyoma.y)
  };

  //curvaKatsu = new curvaBezier(puntosBezier);
  
  iniciarActo0();
  
  //Cargar todas las imagenes
  SakamotoSprite = loadImage("RyomaSakamoto.png");
  KatsuSprite = loadImage("Katsu.png");
  DecisionSprite = loadImage("Decision.png");
  CasaSprite = loadImage("Casa.png");
  TemploSprite = loadImage("templo.png");
  SakamotoAttackSprite = loadImage("RyomaAttack.png");
  SakamotoTeaSprite = loadImage("RyomaTe.png");
  Bowser = loadImage("Bowser.png");
  KatsuBowser = loadImage("KatsuBowser.png");
  MarioShogunSprite = loadImage("Kido.png");
    KatsuIdle = loadImage("KatsuIdle.png");
  KidoSprite = loadImage("Kido.png");
  SaigoSprite = loadImage("Saigo.png");
    
   botonOriginal = loadImage("Decision.png"); 
   botonConLUT = aplicarLUTBotones(botonOriginal); 

  ShogunSprite = loadImage("RyomaSakamoto.png");
  shogunQuemado = loadImage("RyomaSakamoto.png");
  WarioSprite = loadImage("wario.png");
  ExclamacionSprite = loadImage("RyomaSakamoto.png");
  fondoScroll = loadImage("Casa.png");
  fondoTemplo = loadImage("Casa.png");
  fondoCalleWario = loadImage("Casa.png");
  escenaFinal1 = loadImage("Casa.png");
  escenaFinal2 = loadImage("Casa.png");
  escenaFinal3 = loadImage("Casa.png");
  
  SakamotoSprite = loadImage("RyomaSakamoto.png");
MercenarioSprite = loadImage("RyomaSakamoto.png");
fondoCampo = loadImage("Casa.png");
SakamotoHeridoSprite = loadImage("RyomaSakamoto.png");

estrellaSprite = loadImage("wario.png");

Iemochi = loadImage("Iemochi.png");
Consejero = loadImage("Iemochi.png");
}

void draw() {
  background(0);
  
  if (mostrarActo0) {
    image(CasaSprite, 0, 0, 1800, 590);
    Acto1();
  }
  else if (mostrarActo1 || mostrarActo1Incorrecto) {
    image(CasaSprite, 0, 0, 1800, 590);
    if (mostrarActo1) {
      Acto2();
    } else {
      BowserSecuestraKatsu();
    }
  } 
  else if (mostrarActo2) {
    image(TemploSprite, 0, 0, 1800, 590);
    Acto3();
  }
  else if (mostrarHistoriaActo2Final) {
    image(TemploSprite, 0, 0, 1800, 590);
    CinematicaActo3();
  }
  else if (mostrarActo3) {
    image(TemploSprite, 0, 0, 1800, 590);
    Acto4();
  }
    else if (iniciarhistoriaActo3Final) 
    {
      CinematicaFinalCorrecta();    
    }
  
  else if (mostraracto2Incorrecto2) {
    image(fondoScroll, 0, 0, 1800, 590);
    Wario();
  }
  else if (mostraracto2WarioDinero) {
    image(fondoCalleWario, 0, 0, 1800, 590);
    WarioDinero();
  }
  else if (warioFinalIniciado) {
    image(fondoCalleWario, 0, 0, 1800, 590);
    WarioFinal();
  }

  // Dibujar ondas y texto siempre al final
  generacionOndas();
  mostrarTextoProgresivo();

  // Transiciones automáticas
  if (mostrarActo1 && textoActual.length() == letraActual && !decisionTomada) {
    delay(1000);
    iniciarHistoriaActo2();  
  }
  
  if (mostraracto2Incorrecto2 && textoActual.length() == letraActual && !decisionTomada) {
    delay(1000);
    mostrarOpciones = true;
  }

  if (mostrarHistoriaActo2Final && textoActual.length() == letraActual && !decisionTomada) {
    delay(1000);
    iniciarActo3();  
  }
}



/*
void draw() {
  background(0);
  if (mostrarActo0) {
    image(CasaSprite, 0, 0, 1800, 590);
    Acto1();
    generacionOndas();
    mostrarTextoProgresivo();
  }
  else if (mostrarActo1 || mostrarActo1Incorrecto) {
    if(mostrarActo1) {
      image(CasaSprite, 0, 0, 1800, 590);
      Acto2();
      generacionOndas();
      mostrarTextoProgresivo();
    }
    else {
      image(CasaSprite, 0, 0, 1800, 590);
      BowserSecuestraKatsu();
      generacionOndas();
      mostrarTextoProgresivo();
    }
  } 
  else if (mostrarActo2) 
  {
      image(TemploSprite, 0, 0, 1800, 590);
      Acto3();
      generacionOndas();
      mostrarTextoProgresivo();
  }
  else if (mostrarHistoriaActo2Final) {
  image(TemploSprite, 0, 0, 1800, 590);
  CinematicaActo3();
  generacionOndas();
  mostrarTextoProgresivo();
}

    else if (mostrarActo3) 
  {
      image(TemploSprite, 0, 0, 1800, 590);
      Acto4();
      generacionOndas();
      mostrarTextoProgresivo();
  }
  else if (mostrarHistoriaActo2Final) 
  {
  generacionOndas();
  mostrarTextoProgresivo();
}
  else if (mostraracto2Incorrecto2) 
  {
    image(fondoScroll, 0, 0, 1800, 590);
    Wario();
    generacionOndas();
    mostrarTextoProgresivo();
  }
  else if (mostraracto2WarioDinero) {
    image(fondoCalleWario, 0, 0, 1800, 590);
    WarioDinero();
    generacionOndas();
    mostrarTextoProgresivo();
  }
  else if (warioFinalIniciado) { // Nueva condición
    image(fondoCalleWario, 0, 0, 1800, 590);
    WarioFinal();
    generacionOndas();
    mostrarTextoProgresivo();
  }
  else if (mostrarActo3 || mostrarActo3Incorrecto) {
    generacionOndas();
    mostrarTextoProgresivo();
  }
  
  // Transiciones automáticas
  if (mostrarActo1 && textoActual.length() == letraActual && !decisionTomada) {
    delay(1000);
    iniciarHistoriaActo2();  
  }
  
  if (mostraracto2Incorrecto2 && textoActual.length() == letraActual && !decisionTomada) {
    delay(1000);
    mostrarOpciones = true;
  }
  
    if (mostrarHistoriaActo2Final && textoActual.length() == letraActual && !decisionTomada)
    {
    delay(1000);
    iniciarActo3();  
  }
}*/




//Codigo antiguo, lo comentamos por si al hacer el merge se perdio algo

/*void setup()
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
  
  //Curva Interpolacion
  PVector[] p = new PVector[4];
  p[0] = new PVector(1200, 150);   // Posición inicial de Ryoma
  p[1] = new PVector(1000, 200);   // Control intermedio
  p[2] = new PVector(800, 180);    // Control intermedio
  p[3] = new PVector(600, 150);    // Posición final
  
  trayectoria = new curva(p);
  trayectoria.calcular_coefs();
  
  posicionRyoma = p[0].copy();
  
  //Curva de Bezier
 puntosBezier = new PVector[]
 {
  new PVector(200, 150),
  new PVector(400, 200),
  new PVector(posicionRyoma.x, posicionRyoma.y),
  new PVector(posicionRyoma.x +30, posicionRyoma.y)
  };

  curvaKatsu = new curvaBezier(puntosBezier);
  
  iniciarActo0();
  
  //Cargar todas las imagenes
  SakamotoSprite = loadImage("RyomaSakamoto.png");
  KatsuSprite = loadImage("Katsu.png");
  DecisionSprite = loadImage("Decision.png");
  CasaSprite = loadImage("Casa.png");
  SakamotoAttackSprite = loadImage("RyomaAttack.png");
  SakamotoTeaSprite = loadImage("RyomaTe.png");
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
   else if (mostrarActo1 || mostrarActo1Incorrecto)
   {
     if(mostrarActo1)
     {
        //cinemática del acto 1
        Acto2();
        generacionOndas();
        mostrarTextoProgresivo();
     }
     else
     {
         generacionOndas();
        mostrarTextoProgresivo();
     }
   } 
  else if (mostrarActo2 || mostrarActo2Incorrecto)
  {
    // Cinemática del acto 2
    Acto2();
    generacionOndas();
    mostrarTextoProgresivo();
  } 
  else if (mostrarActo3 || mostrarActo3Incorrecto)
  {
    // Cinemática del acto 3
    generacionOndas();
    mostrarTextoProgresivo();
  }
}*/

/*
void draw() {
  background(0);
  // Lógica de visualización de actos
  if (mostrarActo0) {
    image(CasaSprite, 0, 0, 1800, 590);
    Acto1();
      //WarioFinal();
    generacionOndas();
    mostrarTextoProgresivo();
    //EscenaEstrellaFinal();
  }
  else if (mostrarActo1 || mostrarActo1Incorrecto) {
    if(mostrarActo1) {
      image(CasaSprite, 0, 0, 1800, 590);
      Acto2();
      generacionOndas();
      mostrarTextoProgresivo();
    }
    else {
      image(CasaSprite, 0, 0, 1800, 590);
      BowserSecuestraKatsu();
      generacionOndas();
      mostrarTextoProgresivo();
    }
  } 
  else if (mostrarActo2 || mostrarActo2Incorrecto) {
    if(mostrarActo2) {
      image(TemploSprite, 0, 0, 1800, 590);
      Acto3();
      generacionOndas();
      mostrarTextoProgresivo();
    }
    else {
      
    }
  }
  else if (mostraracto2Incorrecto2) {
    // Mostrar la animación de Wario cuando corresponde
    image(fondoScroll, 0, 0, 1800, 590);
    Wario();
    generacionOndas();
    mostrarTextoProgresivo();
  }
  else if (mostrarActo3 || mostrarActo3Incorrecto) {
    generacionOndas();
    mostrarTextoProgresivo();
  }
  
  // Transiciones automáticas
  if (mostrarActo1 && textoActual.length() == letraActual && !decisionTomada) {
    delay(1000);
    iniciarHistoriaActo2();  
  }
  
/*  if (mostrarActo1Incorrecto && textoActual.length() == letraActual && !decisionTomada) {
    delay(1000);
    // Solo iniciar acto2Incorrecto2 si no estamos ya en él
    if (!mostraracto2Incorrecto2) {
      iniciaracto2Incorrecto2();
    }
  }*/
  //////////////////////////////////////////////////////////////
 /* // Añade esta condición para manejar la transición desde acto2Incorrecto2
  if (mostraracto2Incorrecto2 && textoActual.length() == letraActual && !decisionTomada) {
    delay(1000);
    mostrarOpciones = true; // Mostrar opciones para continuar
  }
}


*/
/*void draw() {
  background(0);
  // Lógica de visualización de actos
  if (mostrarActo0) 
  {
    image(CasaSprite, 0, 0, 1800, 590);
    Acto1();
   //WarioDinero();
    generacionOndas();
    mostrarTextoProgresivo();
  }
   else if (mostrarActo1 || mostrarActo1Incorrecto)
   {
     if(mostrarActo1)
     {
       image(CasaSprite, 0, 0, 1800, 590);
        //cinemática del acto 1
        Acto2();
        generacionOndas();
        mostrarTextoProgresivo();
     }
     else
     {
       image(CasaSprite, 0, 0, 1800, 590);
       BowserSecuestraKatsu();
         generacionOndas();
        mostrarTextoProgresivo();
     }
   } 
  else if (mostrarActo2 || mostrarActo2Incorrecto)
  {
    if(mostrarActo2)
     {
       image(TemploSprite, 0, 0, 1800, 590);
        // Cinemática del acto 2
        Acto3();
        generacionOndas();
        mostrarTextoProgresivo();
     }
     else
     {
     
     }
  } 
  else if (mostrarActo3 || mostrarActo3Incorrecto)
  {
    // Cinemática del acto 3
    generacionOndas();
    mostrarTextoProgresivo();
  }
  
 // Transiciones automáticas
  if (mostrarActo1 && textoActual.length() == letraActual && !decisionTomada)
  {
    delay(1000);
    iniciarHistoriaActo2();  
  }
  
  if (mostrarActo1Incorrecto && textoActual.length() == letraActual && !decisionTomada)
  {
    delay(1000);
    iniciaracto2Incorrecto2();
  }
}*/
