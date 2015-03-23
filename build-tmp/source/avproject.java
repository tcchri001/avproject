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

//Initialises the object for the game's main character
Mainchar player;

//Initialises the image objects for the PImage class
PImage sky, gameover, menu, settings, settingsmenu, homebutton, hard, medium, easy;

//Sets up the minim audio plugin for the program


Minim minim;
AudioPlayer menuSong, gameSong, deathSong, jumpSound;

int platspeed = 8; //speed of the platforms and background 
int gameState = 1; //Initial gameState for when the sketch is run

Platforms [] mainPlats;

//Booleans used to change the different states of the character based on the keys being currently pressed 
boolean moveR = false, moveL = false, idle = true;

//Initialid variables which hold the value of the X position of the background, and the number of platform
//points currently accumulated
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
  float velocity = 3, gravity = 4.5f, jump = 130, jumpCheck;

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
  public void displayIdle() {
    image(idle, charX, charY, charWid, charHi);
  }

  //Member function for displaying the appropriate images for when the object is running
  public void displayRun() {
    image(run[imgIDX], charX, charY, charWid, charHi);
  }

  //Member function moves the position of the character steadily to the right, and cycles
  //through the initialised sprite images appropriately to display an animation
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

  //Member function moves the position of the character steadily to the left, and cycles
  //through the initialised sprite images appropriately to display an animation
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

  //Member funciton which produces the constant movement of the platform object
  public void platMove(int z) {
    rectX -= z;
  }

  //Member function which references it's own class in the parameter section to adjust the position
  //of the platform after it passes through the screen boundary by the other platform object
  public void platTransition(Platforms plats) {
    if (rectX < -100) {
      rectX = plats.rectX + 250;
      rectY = (PApplet.parseInt(random(200, 300)));
    }
  }
}


//Custom function which utilises the earlier-initialised booleans to apply different member functions
//of the main character's class
public void characterState() {
  //Prevents the character from travelling beyond any of the program's screen boundaries
  player.boundaries();

  //if moveR is true, it will display the character sprites according to display the object as
  //though it is running, and move it to the right
  if (moveR == true) {
    player.displayRun();
    player.moveR();

    //Similar to what happens if moveR is true, though it applies the principles based on the character
    //moving to the left
  } else if (moveL == true) {
    player.displayRun();
    player.moveL();

    //Simply displays the character's idle image
  } else if (idle == true) {
    player.displayIdle();
  }
}


public void level() {
  //Code which applies the gravity onto the character
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
//Custom function which manages all of the gamestates for the game
public void gameStateMaster(){
  //If the gamestate is 1, then the program will load the main menu and the background audio
  if (gameState == 1) {
      menuScreen();

      //Check to see if the song is currently playing and, if not, causes it to rewind the audio to it's
      //begin and start playing
      if (!menuSong.isPlaying()){
      menuSong.rewind();
      menuSong.play();
      }
      //If the gamestate is 2, the program will load the settings menu and continue playing the song
      //from the main menu
    } else if (gameState == 2) {
      settingsmenu();

      //If the gamestate is 3, the program will load the background image for the game, the main level,
      //the function for the different states of the character, the function for displaying the current 
      //score, pauses the main menu song, and plays the main game song
    } else if (gameState == 3) {
      backpic();
      level();
      characterState();
      currentScore();
      menuSong.pause();

      if (!gameSong.isPlaying()){
      gameSong.rewind();
      gameSong.play();
      }

      //If the gamestate is 4, the program will pause the audio from the main game, load the screen for the
      //when the player falls and loses, and plays the audio for the death screen
    } else if (gameState == 4) {
      gameover();
      gameSong.pause();

      if (!deathSong.isPlaying()){
      deathSong.rewind();
      deathSong.play();
      }
    }
}    
//Function which governs conditions for when certain keys are pressed
public void keyPressed(){
  
  if (key == CODED) {
    
    //When the right-arrow key is pressed, it will move the character right and cycle through
    //a set of sprite images to display the object as though it is running
    if (keyCode == RIGHT) { 
      moveR = true;
      idle = false;
    }
      
    //when the left-arrow key is pressed, it will move the character to the left and cycle through
    //a set of sprite images to display the object as through it is running backwards  
    if (keyCode == LEFT) { 
      moveL = true;
      idle = false;
    }

    //when the up-arrow key is pressed, it will make the character jump up and addition a value of 1 
    //to the jumpCheck variable from the maincharacter class, and it will play a jump sound before rewinding
    //the audio file
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

//Function which governs conditions for when certain keyboard keys are released
public void keyReleased(){
 
 if (key == CODED) {
   
   //When the right-arrow key is released, it will cause the character to stand still and display its
   //idle sprite image
   if (keyCode == RIGHT){
     moveR = false;
     idle = true;
   }
   
   //When the left-arrow key is released, it will cause the character to stand still and display its
   //idle sprite image
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
