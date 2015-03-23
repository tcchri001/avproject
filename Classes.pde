//Sets up the main character class
class Mainchar {
  //PImage array for the set of sprite images used to display the character's running animation
  PImage [] run;
  
  //PImage variable for the character's idle sprite image
  PImage idle;

  //General variable for an array index
  int imgIDX = 1;

  //Sets up the variables which determine the rate at which the program cycles through the array
  //to display the character's running animation
  int cycleRate, time, speed = 105;

  //Variables used to apply to the movement of the character, the gravity which affects its midair position
  //the value by which it jumps, and check the number of times a character has jumped before touching a platform
  float velocity = 3, gravity = 4.5, jump = 130, jumpCheck;

  //Variables used to adjust the width, height and position of the main character object
  float charX = 100, charY = 100, charWid = 25, charHi = 25;

  //Constructor for the class, which sets up the appropriate array(s) and loads the images used for the object
  Mainchar() {

    run = new PImage[6];

    idle = loadImage("images/sprite1.png");

    for (int i = 0; i < run.length; i++) {
      run[i] = loadImage("images/sprite" + (i+2) + ".png");
    }
  }

  //Member function for displaying the appropriate images for when the object is idle
  void displayIdle() {
    image(idle, charX, charY, charWid, charHi);
  }

  //Member function for displaying the appropriate images for when the object is running
  void displayRun() {
    image(run[imgIDX], charX, charY, charWid, charHi);
  }

  //Member function moves the position of the character steadily to the right, and cycles
  //through the initialised sprite images appropriately to display an animation
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

  //Member function moves the position of the character steadily to the left, and cycles
  //through the initialised sprite images appropriately to display an animation
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
    if (charY<=0) {
      charY = 20;
    }
  }
}

//Class which governs the objects used as platforms
class Platforms {

  //Initialises the general image used for the platform
  PImage platform;

  //Initialises the variables used to adjust the width, height and position of the platforms
  int rectX, rectY, rectWidth, rectHeight;

  //Constructor for the class, which can later be used to adjust the setup position of the object
  Platforms(int x, int y, int w, int h) {
    rectX = x; 
    rectY = y;
    rectWidth = w;
    rectHeight = h;
  }

  //Member function which displays the platform on-screen, and produces the collision detection 
  //between the platform and the main character object, referenced in function's parameter
  void displayPlat(Mainchar person) {
    imageMode(CORNER);
    platform = loadImage ("images/tiles.png");
    image(platform, rectX, rectY, rectWidth, rectHeight); //rectangle platforms replaced with images

    if (person.charX > rectX && person.charX < rectX + rectWidth && person.charY < rectY && person.charY > rectY - rectHeight - (rectHeight/2)) {
      person.charY = rectY-rectHeight-(rectHeight/2);
      platPoints += 1;
      person.jumpCheck = 0;
    }
  }

  //Member funciton which produces the constant movement of the platform object
  void platMove(int z) {
    rectX -= z;
  }

  //Member function which references it's own class in the parameter section to adjust the position
  //of the platform after it passes through the screen boundary by the other platform object
  void platTransition(Platforms plats) {
    if (rectX < -100) {
      rectX = plats.rectX + 250;
      rectY = (int(random(200, 300)));
    }
  }
}

