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

void setup ()
{
  size (600, 600);
  
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

void draw ()
{
  background (255);
  player(); 
  //mouseClicked();
  boundaries();

  //  if (spawn == true)
  // {

  // }
}

void player() //creates the user controlled rectangle
{
  fill (255);
  rectMode (CENTER); //Center of the rectangle is the reference point, not the top left corner 
  image (sprite[index], x, y); //User controlled object is a sprite (series of images)
  x = (1-velocity)*oldx+velocity*a;    //Gives it a smooth movement
  y = (1-velocity)*oldy+velocity*b;
  oldx = x; 
  oldy = y;
}

void mouseClicked () //When the mouse is clicked (and released) the pellet is called in
{
  //spawn = true;
  apellet = new pellet();
  apellet.create(x, y); //x and y are used as the float perameters needed in 'void create' for xpos and ypos
  //x and y give 'create' the x and y coordinates of the user so the ellipse spawns at the user
  apellet.move(x, y); //This part isn't working yet!!!!!!!!
}

//void mouseReleased() //Experimenting with using mousePressed and mouseReleased to call a pellet in
//{
//  spawn = false;
//}

void boundaries () //Stops the user going off the screen
{
  if (x>width-50) {
    a -= 50;
  }
  if (x<0) {
    a += 50;
  }
  if (y>width-50) {
    b -= 50;
  }
  if (y<0) {
    b += 50;
  }
}

void keyPressed () //Allows the user control over the rectangle
{
  if (key == CODED) {
    if (keyCode == RIGHT) { 
      a += 20;
      index += 1; //When right and left keys are used the image changes by changing the value of index
    }
    if (keyCode == LEFT) { 
      a -= 20;
      index -= 1;
    }
    if (keyCode == UP) {
      b -= 20;
    }
    if (keyCode == DOWN) { 
      b += 20;
    }
  }
  if (index >= sprite.length) //Stops the index going out of bounds (over or under)
  {
    index = 1;
  }
  if (index <= 0)
  {
    index = sprite.length -1;
  }
}

