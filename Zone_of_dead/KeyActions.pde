void keyPressed(){

  if(key == 'W' || key == 'w'){
     playerModel.moveUP = true;
  }
  
  if(key == 'S' || key == 's'){
    playerModel.moveDown = true;
  }
  
   if(key == 'A' || key == 'a'){
    playerModel.moveLeft = true;
  }
  
  if(key == 'D' || key == 'd'){
    playerModel.moveRight = true;
  }
}

void keyReleased(){

  if(key == 'W' || key == 'w'){
    playerModel.moveUP = false;
  }
  
  if(key == 'S' || key == 's'){
    playerModel.moveDown = false;
  }
  
   if(key == 'A' || key == 'a'){
    playerModel.moveLeft = false;
  }
  
  if(key == 'D' || key == 'd'){
    playerModel.moveRight = false;
  }
}

void mousePressed(){

  //Shooting
  if(mouseButton == LEFT){
    if(playerModel.direction != null && mouseY >= playerModel.playerCoordY+220 && playerModel.ammo != 0){
    bullets.add(new Bullet());
    playerModel.ammo -= 1;
    }
  }
  
  //Menu Screen, START button
  if(currentMenu == menuScreens[0] && currentGameMode == GAMEMODE.NEWGAME){
    if(mouseX >= 175 && mouseY >= 505 && mouseX <= 476 && mouseY <= 594){
      resetGame();
      currentGameMode = GAMEMODE.LEVEL1;
    }
    
    //Menu Screen, INSTRUCTIONS button
    if(mouseX >= 146 && mouseY >= 647 && mouseX <= 504 && mouseY <= 736){
      currentMenu = menuScreens[1];
    }
  }
  
  //INSTRUCTIONS Screen, BACK button
  if(currentMenu == menuScreens[1] && currentGameMode == GAMEMODE.NEWGAME){
    if(mouseX >= 5 && mouseY >= 826 && mouseX <= 160 && mouseY <= 897){
      currentMenu = menuScreens[0];
    }
    
    //NEXT button
    if(mouseX >= 479 && mouseY >= 825 && mouseX <= 634 && mouseY <= 897){
      currentMenu = menuScreens[2];
    }
  }
  
  //INSTRUCTIONS_2 Screen, BACK button
  if(currentMenu == menuScreens[2] && currentGameMode == GAMEMODE.NEWGAME){
    if(mouseX >= 5 && mouseY >= 826 && mouseX <= 160 && mouseY <= 897){
      currentMenu = menuScreens[1];
    }
  }
  
  //GAME OVER Screen, RESTART button
  if(currentMenu == menuScreens[3] && currentGameMode == GAMEMODE.FINISHED){
    if(mouseX >= 185 && mouseY >= 589 && mouseX <= 486 && mouseY <= 678){
      resetGame();
      currentGameMode = GAMEMODE.LEVEL1;
    }
  
    //MAIN MENU button
    if(mouseX >= 155 && mouseY >= 731 && mouseX <= 513 && mouseY <= 820){
      currentMenu = menuScreens[0];
      currentGameMode = GAMEMODE.NEWGAME;
    }
  }
  
}
