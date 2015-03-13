Mainchar player;

Platforms [] mainPlats;

boolean moveR = false, moveL = false, idle = true;


void setup(){
  size(750, 400);
  player = new Mainchar();
  
  mainPlats = new Platforms[3];
  
}

void draw(){
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


void level(){
  
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
