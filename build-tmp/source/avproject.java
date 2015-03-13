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

Platforms [] mainPlats;

boolean moveR = false, moveL = false, idle = true;


public void setup(){
  size(750, 400);
  player = new Mainchar();
  
  mainPlats = new Platforms[3];
  
}

public void draw(){
  background(112);
  level();
  
  player.boundaries();
  if (moveR == true){
    player.displayRun();
    player.moveR();
  } else if (moveL == true){
    player.displayRun();
    player.moveL();
  } else if (idle == true){
    player.displayIdle();
  }
  
  
}


public void level(){
  
  //This is the code for the first platform
  mainPlats[0] = new Platforms(200, 200, 100, 15);
  mainPlats[0].displayPlat();
  mainPlats[0].platTransition();


  //This is the code for the second platform
  mainPlats[1] = new Platforms(420, 300, 100, 15);
  mainPlats[1].displayPlat();
  mainPlats[1].platTransition();
  

  //This is the code for the third platform
  mainPlats[2] = new Platforms(570, 350, 100, 15);
  mainPlats[2].displayPlat();
  mainPlats[2].platTransition();
  
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

  float velocity = 4, gravity = 5;

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
    if (charY>width-50) {
      charY -= velocity;
    }
    if (charY<0) {
      charY += velocity;
    }
  }
}

class Platforms {

  int rectX, rectY, rectWidth, rectHeight;
  int rectVelocity = 5;

  Platforms(int x, int y, int w, int h){
    rectX = x;
    rectY = y;
    rectWidth = w;
    rectHeight = h;
  }

  public void displayPlat(){
    rectMode(CENTER);

    rect(rectX, rectY, rectWidth, rectHeight);
  }

  public void platMove(){
    rectX -= rectVelocity;
  }

  public void platTransition(){
    if (rectX < -200){
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
