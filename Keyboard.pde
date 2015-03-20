void keyPressed (){ //Allows the user control over the rectangle
  
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

void keyReleased(){
 
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
  


