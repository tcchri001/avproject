
void setup(){
  size(1000, 600);
}

void draw(){
  background(112);
  land();
 
}

void land(){
  int rectOneX = 50, rectTwoX = 300, rectThreeX = 600;
  int rectY = 400, rectHeight = 400;
  int xVel = 1;
  
  rect(rectOneX, rectY, 200, rectHeight);
  rect(rectTwoX, rectY, 200, rectHeight);
  rect(rectThreeX, rectY, 200, rectHeight);
  
  rectOneX = xVel;
}

