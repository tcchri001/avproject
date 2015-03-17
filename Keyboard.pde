
//void mouseClicked () //When the mouse is clicked (and released) the pellet is called in
//{
//  //spawn = true;
//  apellet = new pellet();
//  apellet.create(x, y); //x and y are used as the float perameters needed in 'void create' for xpos and ypos
//  //x and y give 'create' the x and y coordinates of the user so the ellipse spawns at the user
//  apellet.move(x, y); //This part isn't working yet!!!!!!!!
//}

//void mouseReleased() //Experimenting with using mousePressed and mouseReleased to call a pellet in
//{
//  spawn = false;
//}



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
      player.charY = player.charY - player.jump;
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
  


