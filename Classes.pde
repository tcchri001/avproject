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

  float velocity = 4, gravity = 5;

  float charX = 100, charY = 100, charWid = 25, charHi = 25;

  Mainchar() {
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
  int rectVelocity = 4;

  Platforms(int x, int y, int w, int h) {
    rectX = x; 
    rectY = y;
   // rectX = (int(random(600, 800))); //Tried to randomise start position, failed hilariously
   //rectY = (int(random(150, 350)));
    rectWidth = w;
    rectHeight = h;
  }

  void displayPlat() {
    platform = loadImage ("images/tiles.png");
    //imageMode(CENTER);

    image(platform, rectX, rectY, 100, 15); //rectangle platforms replaced with images
  }

  void platMove() {
    rectX -= rectVelocity;
  }

  void platTransition() {
    if (rectX < -200) {
      rectX = (int(random(700, 1000)));
      rectY = (int(random(150, 350)));
    }
  }
}

