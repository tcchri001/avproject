// class pellet {

//   float speedx = 20;
//   float speedy = 20;

//   void create (float xpos, float ypos) { //2 values are required as parameters to define where the ellipse spawns
//     fill (255, 0, 0);
//     ellipse (xpos, xpos, 10, 10);
//   }

//   void move (float xpos, float ypos) { //This doesn't work yet either!!!!!
//     // xpos += (mouseX / 10);
//     // ypos += (mouseY / 10);
//   }
//}

class Mainchar {
  PImage [] run;
  PImage idle;

  int imgIDX = 1;

  int cycleRate, time, speed = 105;

  float velocity = 3, gravity = 4.5, jump = 130;

  float charX = 100, charY = 100, charWid = 25, charHi = 25;

  Mainchar() {
    imageMode(CENTER);
    run = new PImage[6];

    idle = loadImage("images/sprite1.png");

    for (int i = 0; i < run.length; i++) {
      run[i] = loadImage("images/sprite" + (i+2) + ".png");
    }
  }

  void displayIdle() {
    image(idle, charX, charY, charWid, charHi);
  }

  void displayRun() {
    image(run[imgIDX], charX, charY, charWid, charHi);
  }

  void moveR() {

    cycleRate = millis() - time;

    if (cycleRate > speed) {
      imgIDX++;
      if (imgIDX == run.length) {
        imgIDX = 2;
      }

      time = millis();
    }
    charX += velocity;
  }

  void moveL() {

    cycleRate = millis() - time;

    if (cycleRate > speed) { 
      imgIDX--;
      if (imgIDX < 2) {
        imgIDX = 5;
      }

      time = millis();
    }
    charX -= velocity;
  }

  //Stops the user going off the screen  
  void boundaries() {
    if (charX>width-50) {
      charX -= velocity;
    }
    if (charX<0) {
      charX += velocity;
    }
    if (charY>height-50) {
      charY -= velocity;
    }
    if (charY<0) {
      charY += velocity;
    }
  }
}

class Platforms {
  PImage platform;
  int rectX, rectY, rectWidth, rectHeight;
  int rectVelocity = 10;

  Platforms(int x, int y, int w, int h) {
    rectX = x; 
    rectY = y;
    rectWidth = w;
    rectHeight = h;
  }

  void displayPlat(Mainchar person) {
    imageMode(CORNER);
    platform = loadImage ("images/tiles.png");
    image(platform, rectX, rectY, rectWidth, rectHeight); //rectangle platforms replaced with images

    if (person.charX > rectX && person.charX < rectX + rectWidth && person.charY < rectY && person.charY > rectY - rectHeight - (rectHeight/2)){
      player.charY = rectY-rectHeight-(rectHeight/2);
      platPoints += 1;
    }
  }

  void platMove() {
    rectX -= rectVelocity;
  }

  void platTransition() {
    if (rectX < -100) {
      rectX = 750;
      rectY = (int(random(150, 350)));
    }
  }
}

