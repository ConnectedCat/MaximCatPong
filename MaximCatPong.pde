int scWidth = 1000;
int scHeight = 600;
boolean direction = true;
PVector location;
PVector velocity;

Field playField;
Ball b;
Paddle lP;
Paddle rP;
int rightPos;
int leftPos;

void setup() {
  size (scWidth, scHeight);

  playField = new Field();
  b = new Ball();
  lP = new Paddle();
  rP = new Paddle();
  rightPos = (height/2) - 40;
  leftPos = (height/2) - 40;
  location = new PVector(100,100);
  velocity = new PVector(10, 15);

}

void draw() {
  if(location.x > 0 && location.x < width){
  playField.renderField();
  location.add(velocity);

  if (location.x >= width - 150) {
    if(location.y >= rightPos && location.y <= rightPos+116){
    velocity.x = velocity.x * -1;
    //velocity.y = velocity.y * -1;
    direction = !direction;
    } 
  }
  if(location.x <= width - (width - 100)){
    if(location.y >= leftPos && location.y <= leftPos+116){
    velocity.x = velocity.x * -1;
    //velocity.y = velocity.y * -1;
    direction = !direction;
    }
  }
  if ((location.y >= height-10) || (location.y < 0)) {
    velocity.y = velocity.y * -1;
  }
  
  rP.renderPaddle(1, rightPos);
  lP.renderPaddle(2, leftPos);
  //smooth();
  b.renderBall(location.x,location.y, direction);
  
  velocity.x +=0.4;
  velocity.y +=0.2;
  }
  if(location.x > width || location.x < 0){
    playField.renderLost();
  }
}

void keyPressed(){
  if (key == CODED) {
    if (keyCode == UP) {
      rightPos-=40;
    } 
    if (keyCode == DOWN) {
      rightPos+=40;
    }
  }
  if (key == 'w'){
    leftPos-=40;
  }
  if (key == 's'){
    leftPos+=40;
  }
  if (key == 'r') {
      rightPos = (height/2) - 40;
      leftPos = (height/2) - 40;
      location.x = 100;
      location.y = 100;
      velocity.x = 10;
      velocity.y = 15;
      playField.renderField();
    }
}

class Field {
  Field() {
  }
  
  void renderField() {
    image(loadImage("nyancat.jpg"), 0, 0, width, height);
  }
  void renderLost() {
    image(loadImage("loser.jpg"), 0, 0, width, height);
  }
}

class Ball {
  PImage cat;
  PImage reverseCat;
  Ball(){
    cat = loadImage("nyan-cat.gif");
    reverseCat = loadImage("nyan-revCat.gif");
  }
  
  void renderBall(float coordX, float coordY, boolean direction){
    if(direction){
    image(cat, coordX, coordY, 40, 28);
    }
    else {
    image(reverseCat, coordX, coordY, 40, 28);
    }
  }
}

class Paddle {
  PImage longCat;
  PImage leftCat;
  Paddle(){
    longCat = loadImage("simple-longcat.jpg");
    leftCat = loadImage("left-longcat.jpg");
  }
  
  void renderPaddle(int side, int Ypos){
    if(side == 1){
    image(longCat, width - 100, Ypos, 50, 116);
    }
    if(side == 2){
    image(leftCat, width - (width - 50), Ypos, 50, 116);  
    }
  }
}
