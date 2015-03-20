void gameStateMaster(){
  if (gameState == 1) {
      menuScreen();
      menuSong.play();
    } else if (gameState == 2) {
      settingsmenu();
    } else if (gameState == 3) { //If game state = 4, which it starts off at, display the menu screen
      backpic();
      level();
      characterState();
      currentScore();
      menuSong.pause();
      gameSong.play();
    } else if (gameState == 4) {
      gameover();
      gameSong.pause();
      deathSong.play();
    }
}    