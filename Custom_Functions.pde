
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

void gameover () {
  image (gameover, 0, 0, 750, 400);

  fill (255, 0, 0);
  textSize (34);
  text (platPoints, 425, 155); //Displays the final score at the end of the game
  player.charY = 0;
  player.charX = 100;
}

void characterDeath() {
  if (player.charY >=height) {
    gameState = 4;
    deathSong.rewind();
    player.jumpCheck = 0;
  }
}