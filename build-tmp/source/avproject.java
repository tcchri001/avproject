import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class avproject extends PApplet {

Mainchar player;
PImage backdrop; 
Platforms [] mainPlats;

boolean moveR = false, moveL = false, idle = true;

int tlx = 0;

public void setup() {
  size(750, 400);
  player = new Mainchar();
  backdrop = loadImage ("images/sky.png");
  mainPlats = new Platforms[3];

  mainPlats[0] = new Platforms(200, 200, 100, 15);
  mainPlats[1] = new Platforms(420, 300, 100, 15);
  mainPlats[2] = new Platforms(570, 350, 100, 15);
}

public void draw() {

  backpic();  //scrolling background image based on the x coordinate
  level();

  player.boundaries();
  if (moveR == true) {
    player.displayRun();
    player.moveR();
  } else if (moveL == true) {
    player.displayRun();
    player.moveL();
  } else if (idle == true) {
    player.displayIdle();
  }
}


public void level() {
  player.charY += player.gravity;

  //This is the code for the first platform
  mainPlats[0].displayPlat(player);
  mainPlats[0].platMove();
  mainPlats[0].platTransition();


  //This is the code for the second platform
  mainPlats[1].displayPlat(player);
  mainPlats[1].platMove();
  mainPlats[1].platTransition();


  //This is the code for the third platform
  mainPlats[2].displayPlat(player);
  mainPlats[2].platMove();
  mainPlats[2].platTransition();
}

public void backpic ()
{
  image (backdrop, tlx, 0);

  tlx = tlx - mainPlats[0].rectVelocity;

  if (tlx <= -1500){ //back ground image is jumped to the rtight when it gets quite far off screen
    tlx = 0;
  }

}

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

  float velocity = 3, gravity = 5, jump = 75;

  float charX = 100, charY = 100, charWid = 25, charHi = 25;

  Mainchar() {
    run = new PImage[6];

    idle = loadImage("images/sprite1.png");

    for (int i = 0; i < run.length; i++) {
      run[i] = loadImage("images/sprite" + (i+2) + ".png");
    }
  }

  public void displayIdle() {
    image(idle, charX, charY, charWid, charHi);
  }

  public void displayRun() {
    image(run[imgIDX], charX, charY, charWid, charHi);
  }

  public void moveR() {

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

  public void moveL() {

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
  public void boundaries() {
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
  int rectVelocity = 6;

  Platforms(int x, int y, int w, int h) {
    rectX = x; 
    rectY = y;
    rectWidth = w;
    rectHeight = h;
  }

  public void displayPlat(Mainchar person) {
    imageMode(CORNER);
    platform = loadImage ("images/tiles.png");
    image(platform, rectX, rectY, rectWidth, rectHeight); //rectangle platforms replaced with images

    if (person.charX > rectX && person.charX < rectX + rectWidth && person.charY < rectY){
      player.charY = rectY - rectHeight-7.5f;
    }
  }

  public void platMove() {
    rectX -= rectVelocity;
  }

  public void platTransition() {
    if (rectX < -200) {
      rectX = (PApplet.parseInt(random(700, 1000)));
      rectY = (PApplet.parseInt(random(150, 350)));
    }
  }
}


//void mouseClicked () //When the mouse is clicked (and released) the pellet is called in
//{
//  //spawn = true;
//  apellet = new pellet();
//  apellet.create(x, y); //x and y are used as the float perameters needed in 'void create' for xpos and ypos
//  //x and y give 'create' the x and y coordinates of the user so the ellipse spawns at the user
//  apellet.move(x, y); //This part isn't working yet!!!!!!!!
//}

//void mouseReleased() //Experimenting with using mousePressed and mouseReleased to call a pellet in
//{
//  spawn = false;
//}



public void keyPressed (){ //Allows the user control over the rectangle
  
  if (key == CODED) {
    
    if (keyCode == RIGHT) { 
      moveR = true;
      idle = false;
    }
      
    if (keyCode == LEFT) { 
      moveL = true;
      idle = false;
    }

    if (keyCode == UP){
      player.charY = player.charY - player.jump;
    }

  }

}

public void keyReleased(){
 
 if (key == CODED) {
   
   if (keyCode == RIGHT){
     moveR = false;
     idle = true;
   }
   
   if (keyCode == LEFT){
     moveL = false;
     idle = true;
   }
 }
}
  


  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "avproject" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
