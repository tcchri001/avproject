import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.analysis.*; 
import ddf.minim.*; 

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
PImage sky, gameover, menu, settings, settingsmenu, homebutton, hard, medium, easy;

//Sets up the minim audio plugin for the program


Minim minim;
AudioPlayer menuSong, gameSong, deathSong, jumpSound;

int platspeed = 8; //speed of the platforms and background 
int gameState = 1; //Initial gameState for when the sketch is run

boolean gameon = true;
Platforms [] mainPlats;

boolean moveR = false, moveL = false, idle = true;


int tlx = 0, platPoints = 0;

public void setup() {
  size(750, 400, P2D);

  //Sets up the minim variables and loads the specific audio files
  minim = new Minim(this);
  menuSong = minim.loadFile("data/audio/Menu.mp3");
  gameSong = minim.loadFile("data/audio/Game.mp3");
  deathSong = minim.loadFile("data/audio/gameOver.mp3");
  jumpSound = minim.loadFile("data/audio/Jump.mp3");


  //Sets up the 'player' object form the Mainchar class
  player = new Mainchar();

  //Loads the images that are used for the menus in the game
  sky = loadImage ("data/images/sky.png");
  gameover = loadImage ("data/images/gameover.png");
  settingsmenu = loadImage ("data/images/settingsmenu.png");
  homebutton = loadImage ("data/images/homebutton.png");
  settings = loadImage ("data/images/settings.png");
  menu = loadImage ("data/images/menu.png");
  hard = loadImage ("data/images/Hard.png");
  medium = loadImage ("data/images/Medium.png");
  easy = loadImage ("data/images/Easy.png");

  //Sets up the number of platform objects in the Platform class and initialises their positions
  mainPlats = new Platforms[3];
  mainPlats[0] = new Platforms(450, 300, 120, 15);
  mainPlats[1] = new Platforms(550, 300, 120, 15);
  mainPlats[2] = new Platforms(650, 300, 120, 15);
}

public void draw() {
  gameStateMaster();
  characterDeath();

}

public void mousePressed() { //If user clicks within the "start" image, changes gamestate to 1. Runs all the time, not only if mouse clicked
  if (gameState == 1) {
    if (mouseX >= width/2-100 && mouseX <= width/2+100 && mouseY >= height/2 && mouseY <= height/2+100) {
      gameState = 3; //Above line is play button on main menu
      gameSong.rewind();
    } else if (mouseX >= width/2-170 && mouseX <= width/2+140 && mouseY >= height/2+100 && mouseY <= height/2+150) {
      gameState = 2; //Above line is settings button on main menu
    }
  } else if (gameState == 4) {
    if (mouseX >= width/2-180 && mouseX <= width/2+190  && mouseY >= height/2-10 && mouseY <= height/2+50) {
      gameState = 1; //Above line is main menu button from gameover screen
      platPoints = 0; //Resets the points counter when any button on gameover screen is clicked
      deathSong.pause();
      menuSong.rewind();
    } else if (mouseX >= 250 && mouseX <= 500 && mouseY >= 255 && mouseY <= 315) {
      gameState = 3; //Above line is replay button from gameover screen
      platPoints = 0;
      deathSong.pause();
      gameSong.rewind();
    }
  } else if (gameState == 2 ) {
    if (mouseX >= width/2-110 && mouseX <= width/2+110 && mouseY >= height-80 && mouseY <= height) {
      gameState = 1; //Home button in settings menu
    } else if (mouseX >= 275  && mouseX <= 475 && mouseY >= 150 && mouseY <= 200) {
      platspeed = 8; //Hard setting
      gameState = 1;
    } else if (mouseX >= 225 && mouseX <= 525 && mouseY >= 200 && mouseY <= 250) {
      platspeed = 7; //Medium setting
      gameState = 1;
    } else if (mouseX >= 275 && mouseX <= 475 && mouseY >= 250 && mouseY <= 300) {
      platspeed = 6; //Easy setting
      gameState = 1;
    }
  }
}

class Mainchar {
  PImage [] run;
  PImage idle;

  int imgIDX = 1;

  int cycleRate, time, speed = 105;

  float velocity = 3, gravity = 4.5f, jump = 130, jumpCheck;

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
    if (charY<=0) {
      charY = 20;
    }
  }
}

class Platforms {
  PImage platform;
  int rectX, rectY, rectWidth, rectHeight;
  int rectXset = 750;

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

    if (person.charX > rectX && person.charX < rectX + rectWidth && person.charY < rectY && person.charY > rectY - rectHeight - (rectHeight/2)) {
      person.charY = rectY-rectHeight-(rectHeight/2);
      platPoints += 1;
      person.jumpCheck = 0;
    }
  }

  public void platMove(int z) {
    rectX -= z;
  }

  public void platTransition(Platforms plats) {
    if (rectX < -100) {
      rectX = plats.rectX + 250;
      rectY = (PApplet.parseInt(random(200, 300)));
    }
  }
}


public void characterState() {
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
  mainPlats[0].platMove(platspeed);
  mainPlats[0].platTransition(mainPlats[2]);


  //This is the code for the second platform
  mainPlats[1].displayPlat(player);
  mainPlats[1].platMove(platspeed);
  mainPlats[1].platTransition(mainPlats[0]);


  //This is the code for the third platform
  mainPlats[2].displayPlat(player);
  mainPlats[2].platMove(platspeed);
  mainPlats[2].platTransition(mainPlats[1]);
}

//Custom function for the background image
public void backpic ()
{
  image (sky, tlx, 0);

  tlx = tlx - platspeed;

  if (tlx <= -1500) { //background image is jumped to the right when it gets quite far off screen
    tlx = 0;
  }
}

//Function which displays the current accumulated platform points
public void currentScore() {
  fill(200);
  textSize(15);
  text("Current platform Score: " + platPoints, 0, 25);
}

public void settingsmenu() { //The settings menu
  imageMode(CORNER);
  image (settingsmenu, 0, 0, width, height); //The background on settings screen
  image (homebutton, width/2-100, height-80, 200, 80); //The home button in the  settings menu
  image (hard, width/2-100, height/2-50, 200, 50);
  image (medium, width/2-150, height/2, 300, 50);
  image (easy, width/2-100, height/2+50, 200, 50);
}

public void menuScreen () {
  imageMode(CORNER);
  image (menu, 0, 0, width, height); //Displays the background and the game name
  image (settings, width/2-165, height/2+100, 300, 50); //Displays the settings button/image
}

public void gameover () {
  image (gameover, 0, 0, 750, 400);

  fill (255, 0, 0);
  textSize (34);
  text (platPoints, 425, 155); //Displays the final score at the end of the game
  player.charY = 0;
  player.charX = 100;
}

public void characterDeath() {
  if (player.charY >=height) {
    gameState = 4;
    deathSong.rewind();
    player.jumpCheck = 0;
  }
}
public void gameStateMaster(){
  if (gameState == 1) {
      menuScreen();
      menuSong.play();
    } else if (gameState == 2) {
      settingsmenu();
    } else if (gameState == 3) { //If game state = 4, which it starts off at, display the menu screen
      backpic();
      level();
      characterState();
      currentScore();
      menuSong.pause();
      gameSong.play();
    } else if (gameState == 4) {
      gameover();
      gameSong.pause();
      deathSong.play();
    }
}    
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
      if (player.jumpCheck < 2 && gameState == 3){
        player.charY = player.charY - player.jump;
        player.jumpCheck +=1;
        jumpSound.play();
        jumpSound.rewind();
      }
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
  


/*-----------------
The sources that we used for the creation of the project can be seen below:

Main menu & gameplay audio: http://freemusicarchive.org/music/sawsquarenoise/RottenMage_SpaceJacked/
'Game Over' screen audio: https://www.youtube.com/watch?v=CnTjnBCrVwA
Jumping sound effect (custom-generated): http://www.bfxr.net/

Images used for sprites: https://learn.gold.ac.uk/mod/resource/view.php?id=246989
Images for platforms: http://www.spriters-resource.com/snes/smarioworld/sheet/4587/
Game over screen text: http://www.dafont.com/8bit-wonder.font
Hard, medium and easy settings (text generated in website): http://textcraft.net/

-----------------*/
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "avproject" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
