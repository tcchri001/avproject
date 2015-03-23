//Function which governs conditions for when certain keys are pressed
void keyPressed(){
  
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
void keyReleased(){
 
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
  


