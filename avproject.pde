//Initialises the object for the game's main character
Mainchar player;

//Initialises the image objects for the PImage class
PImage sky, gameover, menu, settings, settingsmenu, homebutton, hard, medium, easy;

//Sets up the minim audio plugin for the program
import ddf.minim.analysis.*;
import ddf.minim.*;
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

void setup() {
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

void draw() {
  gameStateMaster();
  characterDeath();

}

void mousePressed() { //If user clicks within the "start" image, changes gamestate to 1. Runs all the time, not only if mouse clicked
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

