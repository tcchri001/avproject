//Variables for the X co-ordinates of the ground
int rectOneX = 50, rectTwoX = 300, rectThreeX = 600;
//Additional Varibles for the rectangles
int rectY = 400, rectHeight = 400;
//Velocity variables for moving groud
int xVel = 10;

void setup(){
  size(1000, 600);
}

void draw(){
  background(112);
  land();

}


void land(){
  //This chunk of code creates 3 rectangles on-screen
  rect(rectOneX, rectY, 200, rectHeight);
  rect(rectTwoX, rectY, 200, rectHeight);
  rect(rectThreeX, rectY, 200, rectHeight);
  
  //This affects the X position of each rectangle by the value of xVel
  rectOneX -= xVel;
  rectTwoX -= xVel;
  rectThreeX -= xVel;
  
  //These if statements cause the rectangles to reappear when they 
  //go off-screen
  if (rectOneX < -200){
    rectOneX = 1000;
  }
  
  if (rectTwoX < -200){
    rectTwoX = 1000;
  }
  
  if (rectThreeX < -200){
    rectThreeX = 1000;
  }
  
}

