Mainchar player;
PImage sky; 
PImage gameover;
PImage menu;
PImage settings;
PImage settingsmenu;
PImage homebutton;
PImage hard;
PImage medium;
PImage easy;

int platspeed = 8; //speed of the platforms and background 
int gameState = 4;

boolean gameon = true;
Platforms [] mainPlats;

boolean moveR = false, moveL = false, idle = true;


int tlx = 0, platPoints = 0;

void setup() {
  size(750, 400, P2D);
  player = new Mainchar();
  sky = loadImage ("images/sky.png");
  gameover = loadImage ("images/gameover.png");
  settingsmenu = loadImage ("images/settingsmenu.png");
  homebutton = loadImage ("images/homebutton.png");
  settings = loadImage ("images/settings.png");
  menu = loadImage ("images/menu.png");
  hard = loadImage ("images/Hard.png");
  medium = loadImage ("images/Medium.png");
  easy = loadImage ("images/Easy.png");

  mainPlats = new Platforms[3];
  mainPlats[0] = new Platforms(450, 300, 120, 15);
  mainPlats[1] = new Platforms(550, 300, 120, 15);
  mainPlats[2] = new Platforms(650, 300, 120, 15);
}

void gameover () {
  image (gameover, 0, 0, 750, 400);

  fill (255, 0, 0);
  textSize (34);
  text (platPoints, 425, 155); //Displays the final score at the end of the game
  player.charY = 0;
  player.charX = 100;
}

void draw() {

  if (player.charY >=height) {
    gameState = 2;
  }

  if (gameState == 1) {
    backpic();
    level();
    characterState();
    currentScore();
  } else if (gameState == 2) {
    gameover();
  } else if (gameState == 4) { //If game state = 4, which it starts off at, display the menu screen
    menuScreen();
  } else if (gameState == 5) {
    settingsmenu();
  }
}

void characterState() {
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


void level() {
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
void backpic ()
{
  image (sky, tlx, 0);

  tlx = tlx - platspeed;

  if (tlx <= -1500) { //background image is jumped to the right when it gets quite far off screen
    tlx = 0;
  }
}

//Function which displays the current accumulated platform points
void currentScore() {
  fill(200);
  textSize(15);
  text("Current platform Score: " + platPoints, 0, 25);
}

void settingsmenu() { //The settings menu
  imageMode(CORNER);
  image (settingsmenu, 0, 0, width, height); //The background on settings screen
  image (homebutton, width/2-100, height-80, 200, 80); //The home button in the  settings menu
  image (hard, width/2-100, height/2-50, 200, 50);
  image (medium, width/2-150, height/2, 300, 50);
  image (easy, width/2-100, height/2+50, 200, 50);
}

void menuScreen () {
  imageMode(CORNER);
  image (menu, 0, 0, width, height); //Displays the background and the game name
  image (settings, width/2-165, height/2+100, 300, 50); //Displays the settings button/image
}

void mousePressed() { //If user clicks within the "start" image, changes gamestate to 1. Runs all the time, not only if mouse clicked
  if (gameState == 4) {
    if (mouseX >= width/2-100 && mouseX <= width/2+100 && mouseY >= height/2 && mouseY <= height/2+100) {
      gameState = 1; //Above line is play button on main menu
    } else if (mouseX >= width/2-170 && mouseX <= width/2+140 && mouseY >= height/2+100 && mouseY <= height/2+150) {
      gameState = 5; //Above line is settings button on main menu
    }
  } else if (gameState == 2) {
    if (mouseX >= width/2-180 && mouseX <= width/2+190  && mouseY >= height/2-10 && mouseY <= height/2+50) {
      gameState = 4; //Above line is main menu button from gameover screen
      platPoints = 0; //Resets the points counter when any button on gameover screen is clicked
    } else if (mouseX >= 250 && mouseX <= 500 && mouseY >= 255 && mouseY <= 315) {
      gameState = 1; //Above line is replay button from gameover screen
      platPoints = 0;
    }
  } else if (gameState == 5 ) {
    if (mouseX >= width/2-110 && mouseX <= width/2+110 && mouseY >= height-80 && mouseY <= height) {
      gameState = 4; //Home button in settings menu
    } else if (mouseX >= 275  && mouseX <= 475 && mouseY >= 150 && mouseY <= 200) {
      platspeed = 8; //Hard setting
      gameState = 4;
    } else if (mouseX >= 225 && mouseX <= 525 && mouseY >= 200 && mouseY <= 250) {
      platspeed = 7; //Medium setting
      gameState = 4;
    } else if (mouseX >= 275 && mouseX <= 475 && mouseY >= 250 && mouseY <= 300) {
      platspeed = 6; //Easy setting
      gameState = 4;
    }
  }
}

