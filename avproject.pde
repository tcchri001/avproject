Mainchar player;
PImage backdrop; 
PImage ending;

int gameState = 1;

boolean gameon = true;
Platforms [] mainPlats;

boolean moveR = false, moveL = false, idle = true;


int tlx = 0, platPoints = 0;

void setup() {
  size(750, 400);
  player = new Mainchar();
  backdrop = loadImage ("images/sky.png");
  ending = loadImage ("images/over.png");
  mainPlats = new Platforms[3];

  mainPlats[0] = new Platforms(450, 300, 100, 15);
  mainPlats[1] = new Platforms(550, 300, 100, 15);
  mainPlats[2] = new Platforms(650, 300, 100, 15);
}

void gameover () {
  image (ending, 0, 0, 750, 500);
}


void draw() {

  backpic();  //scrolling background image based on the x coordinate
  if (player.charY >=height) {
    gameState = 2;
  }

  if (gameState == 1) {
    level();
    characterState();
    currentScore();
  } else if (gameState == 2) {
    gameover();
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

