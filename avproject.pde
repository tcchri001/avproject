Mainchar player;
PImage backdrop; 
PImage ending;
PImage menu;
//PImage start;

int gameState = 4;

boolean gameon = true;
Platforms [] mainPlats;

boolean moveR = false, moveL = false, idle = true;


int tlx = 0, platPoints = 0;

void setup() {
  size(750, 400, P2D);
  player = new Mainchar();
  backdrop = loadImage ("images/sky.png");
  ending = loadImage ("images/over.png");
  menu = loadImage ("images/newhome.png");
  //start = loadImage ("images/play.png");  

  mainPlats = new Platforms[3];

  mainPlats[0] = new Platforms(450, 300, 120, 15);
  mainPlats[1] = new Platforms(550, 300, 120, 15);
  mainPlats[2] = new Platforms(650, 300, 120, 15);
}

void gameover () {
  image (ending, 0, 0, 750, 500);
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
    mouseClicked();
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
  image (backdrop, tlx, 0);

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


void menuScreen () {
  image (menu, width/2, height/2, width, height); //Displays the background and the game name
 //image (start, width/2, height/2+50, 200, 100); //Displays the play button/image
}

void mouseClicked() { //If user clicks within the "start" image, changes gamestate to 1. Runs all the time, not only if mouse clicked
  if (gameState == 4) {
    if (mouseX >= width/2-100 && mouseX <= width/2+100 && mouseY >= height/2 && mouseY <= height/2+100) {
      gameState = 1;
    }
  }
}

