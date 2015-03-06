pellet apellet; //Creates an instance of class: pellet called 'apellet'
PImage [] sprite;
int index = 1;

//boolean spawn = false;

float x;
float y;
int a = 250;
int b = 250;
float oldx, oldy;
float velocity = 0.05;

//Variables for the X co-ordinates of the ground
int rectOneX = 50, rectTwoX = 300, rectThreeX = 600;
//Additional Varibles for the rectangles
int rectY = 400, rectHeight = 400;
//Velocity variables for moving groud
int xVel = 10;

void setup(){
  size(1000, 600);
  
  File file = new File(dataPath("images")); //The following lines are from processing lab 4 
        //they create an array of images to use as the sprite

  String [] files = new String[8];

  for (int i=1; i<files.length; ++i)
  {
    files[i] =  "sprite" + i +".png";
  }

  sprite = new PImage[files.length];

  for (int i = 1; i < files.length; ++i)
  {
    sprite[i] = loadImage("images/sprite" +i + ".png");
  }
  
}

void draw(){
  background(112);
  land();
  player();
  boundaries();
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

