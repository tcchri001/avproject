Mainchar player;
PImage sky; 
PImage gameover;
PImage menu;
//PImage restart;
PImage settings;
PImage settingsmenu;
PImage homebutton;
//PImage start;

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
  //restart = loadImage ("images/restart.png");
  //start = loadImage ("images/play.png");  

  mainPlats = new Platforms[3];

  mainPlats[0] = new Platforms(450, 300, 120, 15);
  mainPlats[1] = new Platforms(550, 300, 120, 15);
  mainPlats[2] = new Platforms(650, 300, 120, 15);
}

void gameover () {
  image (gameover, 0, 0, 750, 500);
  //image (regame, width/2-110, height/2-37, 200, 75);
  player.charY = 0;
  player.charX = 0;
}

void draw() {
  println(gameState);

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
  mainPlats[0].platMove();
  mainPlats[0].platTransition(mainPlats[2]);


  //This is the code for the second platform
  mainPlats[1].displayPlat(player);
  mainPlats[1].platMove();
  mainPlats[1].platTransition(mainPlats[0]);


  //This is the code for the third platform
  mainPlats[2].displayPlat(player);
  mainPlats[2].platMove();
  mainPlats[2].platTransition(mainPlats[1]);
}

//Custom function for the background image
void backpic ()
{
  image (sky, tlx, 0);

  tlx = tlx - mainPlats[0].rectVelocity;

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
}

void menuScreen () {
  imageMode(CORNER);
  image (menu, 0, 0, width, height); //Displays the background and the game name
  image (settings, width/2-165, height/2+100, 300, 50); //Displays the settings button/image
  //image (start, width/2, height/2+50, 200, 100); //Displays the play button/image
}

void mousePressed() { //If user clicks within the "start" image, changes gamestate to 1. Runs all the time, not only if mouse clicked
  if (gameState == 4) {
    if (mouseX >= width/2-100 && mouseX <= width/2+100 && mouseY >= height/2 && mouseY <= height/2+100) {
      gameState = 1; //Above line is play button on main menu
    } else if (mouseX >= width/2-170 && mouseX <= width/2+140 && mouseY >= height/2+100 && mouseY <= height/2+150)
    {
      gameState = 5; //Above line is settings button on main menu
    }
  } else if (gameState == 2) { //Restart button
    if (mouseX >= width/2-110 && mouseX <= width/2+110 && mouseY >= height/2-40 && mouseY <= height/2+40) {
      gameState = 4;
    }
  } else if (gameState == 5 ) { //Home button in settings
    if (mouseX >= width/2-110 && mouseX <= width/2+110 && mouseY >= height-80 && mouseY <= height) {
      gameState = 4;
    }
  }
}

