class pellet {

  float speedx = 20;
  float speedy = 20;

  void create (float xpos, float ypos) { //2 values are required as parameters to define where the ellipse spawns
    fill (255, 0, 0);
    ellipse (xpos, xpos, 10, 10);
  }

  void move (float xpos, float ypos) { //This doesn't work yet either!!!!!
   // xpos += (mouseX / 10);
   // ypos += (mouseY / 10);
  }
}

