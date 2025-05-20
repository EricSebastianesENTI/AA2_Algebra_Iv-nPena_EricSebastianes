PImage characterSprite;
PVector position;
PMatrix3D transformMatrix;
float movementSpeed = 5.0;
float rotationSpeed = 0.08;
boolean isJumping = false;
float jumpProgress = 0;
float jumpHeight = 80;
float currentScale = 1.0;
PVector facingDirection = new PVector(0, 0, -1);
PVector upDirection = new PVector(0, -1, 0);
w
void setup() {
  size(1800, 900, P3D);
  
  // Configuración inicial
  float groundLevel = height/2;
  position = new PVector(width/2, groundLevel - 50, 0);
  
  // Cargar sprite
  characterSprite = loadImage("character.png");
  if (characterSprite == null) {
    characterSprite = createImage(100, 200, ARGB);
    characterSprite.loadPixels();
    for (int i = 0; i < characterSprite.pixels.length; i++) {
      characterSprite.pixels[i] = color(255, 0, 0, 150);
    }
    characterSprite.updatePixels();
  }
  
  transformMatrix = new PMatrix3D();
  resetTransform();
  
  // Configuración de cámara
  cameraSetup();
}

void cameraSetup() {
  camera(width/2, height/2 - 150, (height/2) / tan(PI*30.0 / 180.0),
         width/2, height/2, 0,
         0, 1, 0);
}

void resetTransform() {
  transformMatrix.reset();
  transformMatrix.translate(position.x, position.y, position.z);
  applyOrientation();
}

void applyOrientation() {
  PVector right = facingDirection.cross(upDirection);
  right.normalize();
  
  transformMatrix.m00 = right.x;
  transformMatrix.m10 = right.y;
  transformMatrix.m20 = right.z;
  
  transformMatrix.m01 = upDirection.x;
  transformMatrix.m11 = upDirection.y;
  transformMatrix.m21 = upDirection.z;
  
  transformMatrix.m02 = -facingDirection.x;
  transformMatrix.m12 = -facingDirection.y;
  transformMatrix.m22 = -facingDirection.z;
}

void draw() {
  background(135, 206, 235);
  
  // Iluminación.
  lights();
  directionalLight(200, 200, 200, 0, -1, -0.5);
  ambientLight(100, 100, 100);
  
  // Dibujar elementos.
  drawGround();
  drawCharacter();
  
  // Actualizar salto.
  if (isJumping) {
    updateJump();
  }
  
  // Dibujar HUD.
  drawHUD();
}

void drawGround() {
  pushMatrix();
  translate(width/2, height/2, 0);
  
  fill(100, 200, 100);
  beginShape(QUADS);
  for (int x = -400; x < 400; x += 50) {
    for (int z = -400; z < 400; z += 50) {
      vertex(x, 0, z);
      vertex(x + 50, 0, z);
      vertex(x + 50, 0, z + 50);
      vertex(x, 0, z + 50);
    }
  }
  endShape();
  popMatrix();
}

void drawCharacter() {
  pushMatrix();
  applyMatrix(transformMatrix);
  scale(currentScale);
  
  beginShape(QUAD);
  texture(characterSprite);
  noStroke();
  vertex(-30, -60, 0, 0, 0);
  vertex(30, -60, 0, characterSprite.width, 0);
  vertex(30, 0, 0, characterSprite.width, characterSprite.height);
  vertex(-30, 0, 0, 0, characterSprite.height);
  endShape();
  
  popMatrix();
}

void drawHUD() {

  pushStyle();
  hint(DISABLE_DEPTH_TEST);
  camera();
  
  // Configurar estilo HUD.
  fill(0, 150);
  noStroke();
  rect(10, 10, 300, 120);
  
  // Texto informativo.
  fill(255);
  textSize(14);
  textAlign(LEFT, TOP);
  
  // Obtener ángulos de rotación
  float yaw = atan2(facingDirection.x, facingDirection.z);
  float pitch = -asin(facingDirection.y);
  float roll = atan2(upDirection.x, upDirection.y);
  
  // Mostrar información.
  text("Posición: " + nfp(position.x, 1, 1) + ", " + 
                   nfp(position.y, 1, 1) + ", " + 
                   nfp(position.z, 1, 1), 20, 20);
  
  text("Rotación (Yaw): " + nfp(degrees(yaw), 1, 1) + "°", 20, 40);
  text("Rotación (Pitch): " + nfp(degrees(pitch), 1, 1) + "°", 20, 60);
  text("Rotación (Roll): " + nfp(degrees(roll), 1, 1) + "°", 20, 80);
  
  text("Controles: WASD-QE para rotar, Flechas para mover", 20, 100);
  text("R/F: Arriba/Abajo, ESPACIO: Saltar", 20, 120);
  
  // Restaurar estado.
  hint(ENABLE_DEPTH_TEST);
  popStyle();
}
void rotateCharacterX(float angle) {
  // Rotar alrededor del eje X (perpendicular a dirección y arriba)
  PVector right = facingDirection.cross(upDirection);
  right.normalize();
  
  PMatrix3D rot = new PMatrix3D();
  rot.rotate(angle, right.x, right.y, right.z);
  rot.mult(facingDirection, facingDirection);
  facingDirection.normalize();
  
  rot = new PMatrix3D();
  rot.rotate(angle, right.x, right.y, right.z);
  rot.mult(upDirection, upDirection);
  upDirection.normalize();
  
  resetTransform();
}

void rotateCharacterZ(float angle) {
  // Rotar alrededor del eje Z (roll)
  PMatrix3D rot = new PMatrix3D();
  rot.rotate(angle, facingDirection.x, facingDirection.y, facingDirection.z);
  rot.mult(upDirection, upDirection);
  upDirection.normalize();
  
  resetTransform();
}

void moveForward(float speed) {
  PVector movement = facingDirection.copy();
  movement.mult(speed);
  position.add(movement);
  resetTransform();
}

void moveSideways(float speed) {
  PVector right = facingDirection.cross(upDirection);
  right.normalize();
  right.mult(speed);
  position.add(right);
  resetTransform();
}

void moveVertical(float speed) {
  position.y += speed;
  resetTransform();
}
void rotateCharacterY(float angle) {
  // Rotar alrededor del eje Y (horizontal)
  PMatrix3D rot = new PMatrix3D();
  rot.rotateY(angle);
  rot.mult(facingDirection, facingDirection);
  facingDirection.normalize();
  
  rot = new PMatrix3D();
  rot.rotateY(angle);
  rot.mult(upDirection, upDirection);
  upDirection.normalize();
  
  resetTransform();
}
void keyPressed() {
  if (key == 'a' || key == 'A') rotateCharacterY(-rotationSpeed);
  if (key == 'd' || key == 'D') rotateCharacterY(rotationSpeed);
  if (key == 'w' || key == 'W') rotateCharacterX(-rotationSpeed);
  if (key == 's' || key == 'S') rotateCharacterX(rotationSpeed);
  if (key == 'q' || key == 'Q') rotateCharacterZ(rotationSpeed);
  if (key == 'e' || key == 'E') rotateCharacterZ(-rotationSpeed);
  
  if (keyCode == UP) moveForward(movementSpeed);
  if (keyCode == DOWN) moveForward(-movementSpeed);
  if (keyCode == LEFT) moveSideways(-movementSpeed);
  if (keyCode == RIGHT) moveSideways(movementSpeed);
  
  if (key == 'r' || key == 'R') moveVertical(movementSpeed);
  if (key == 'f' || key == 'F') moveVertical(-movementSpeed);
  
  if (key == ' ' && !isJumping) startJump();
}
void startJump() {
  isJumping = true;
  jumpProgress = 0;
}

void updateJump() {
  jumpProgress += 0.04;
  
  if (jumpProgress <= 1.0) {
    // Salto parabólico desde la posición actual exacta.
    float currentJumpHeight = jumpHeight * sin(jumpProgress * PI);
    position.y = (height/2 - 50) - currentJumpHeight; // Salto hacia arriba (Y negativo)
    
    // Efecto de escalado sutil.
    currentScale = map(sin(jumpProgress * PI), 0, 1, 1.0, 1.1);
    
    resetTransform();
  } else {
    isJumping = false;
    position.y = height/2 - 50; // Volver a altura base
    currentScale = 1.0;
    resetTransform();
  }
}
