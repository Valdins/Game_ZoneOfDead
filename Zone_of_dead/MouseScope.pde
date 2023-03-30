PImage scopeImg, defaultCursor;

class MouseScope{

  void update(){
     render();
     noCursor();
  }
  
//Renders cursor in MENU SCREENS and SCOPE in levels
  void render(){
    if(currentGameMode == GAMEMODE.LEVEL1 || currentGameMode == GAMEMODE.TRANSITION || currentGameMode == GAMEMODE.LEVEL2){
   image(scopeImg,mouseX-32,mouseY-32);
    }else{
   image(defaultCursor,mouseX,mouseY);
    }
  }
}
