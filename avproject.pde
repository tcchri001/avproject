Mainchar player;
PImage backdrop; 
Platforms [] mainPlats;

boolean moveR = false, moveL = false, idle = true;


int tlx = 0, platPoints = 0;

void setup() {
  size(750, 400);
  player = new Mainchar();
  backdrop = loadImage ("images/sky.png");
  mainPlats = new Platforms[3];

  mainPlats[0] = new Platforms(450,300, 100, 15);
  mainPlats[1] = new Platforms(550,300, 100, 15);
  mainPlats[2] = new Platforms(650,300, 100, 15);
}

void draw() {

  backpic();  //scrolling background image based on the x coordinate
  level();
  currentScore();

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

//Custom function for the background image
void backpic ()
{
  image (backdrop, tlx, 0);

  tlx = tlx - mainPlats[0].rectVelocity;

  if (tlx <= -1500){ //background image is jumped to the right when it gets quite far off screen
    tlx = 0;
  }
}

//Function which displays the current accumulated platform points
void currentScore(){
  fill(200);
  textSize(15);
  text("Current platform Score: " + platPoints, 0, 25);
}

