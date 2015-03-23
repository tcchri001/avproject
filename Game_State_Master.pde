//Custom function which manages all of the gamestates for the game
void gameStateMaster(){
  //If the gamestate is 1, then the program will load the main menu and the background audio
  if (gameState == 1) {
      menuScreen();

      //Check to see if the song is currently playing and, if not, causes it to rewind the audio to it's
      //begin and start playing
      if (!menuSong.isPlaying()){
      menuSong.rewind();
      menuSong.play();
      }
      //If the gamestate is 2, the program will load the settings menu and continue playing the song
      //from the main menu
    } else if (gameState == 2) {
      settingsmenu();

      //If the gamestate is 3, the program will load the background image for the game, the main level,
      //the function for the different states of the character, the function for displaying the current 
      //score, pauses the main menu song, and plays the main game song
    } else if (gameState == 3) {
      backpic();
      level();
      characterState();
      currentScore();
      menuSong.pause();

      if (!gameSong.isPlaying()){
      gameSong.rewind();
      gameSong.play();
      }

      //If the gamestate is 4, the program will pause the audio from the main game, load the screen for the
      //when the player falls and loses, and plays the audio for the death screen
    } else if (gameState == 4) {
      gameover();
      gameSong.pause();

      if (!deathSong.isPlaying()){
      deathSong.rewind();
      deathSong.play();
      }
    }
}    