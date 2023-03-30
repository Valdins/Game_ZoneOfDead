PImage scoreBg, car1, car2, car3, car4, car5, hp100, hp75, hp50, hp25, hp0, player1, ammoBg, ammoBgLarge, num0, num1, num2, num3, num4, num5, num6, num7, num8, num9, fire1, fire2, fire3, fire4, fire5, carOnFire, killBg, killBgSmall;
 
class Player{

int playerCoordX, playerCoordY, speedX = 3, speedY = 2, carHealth = 4, ammo = 5, kills = 0, imgSpeed, score = 0, delaySeconds;
boolean moveUP, moveDown, moveLeft, moveRight, outOfRight, outOfLeft, outOfUp, outOfDown, contactWithObject, exploaded, delayStarted;
PVector startPoint, direction, endPoint;
float angle, lastAngle;

Player(int x, int y){

  this.playerCoordX = x;
  this.playerCoordY = y;
}

void update(){
  if(exploaded == false){
   render();
   checkCollision();
   checkBarrelCollision();
   outOfStreet();
   rotatePlayer();
  }
   move();
   carExploaded();
   ammoBar();
   healthBar();
   killCounter();
   checkAmmoBoxes();
   playerScore();
}

//Renders animation for the player
void render(){
 
if(imgSpeed <= speedY*5){
    image(car1,playerCoordX,playerCoordY);
  }else if(imgSpeed <= speedY*10){
    image(car2,playerCoordX,playerCoordY);
  }else if(imgSpeed <= speedY*15){
    image(car3,playerCoordX,playerCoordY);
  }else if(imgSpeed <= speedY*20){
    image(car4,playerCoordX,playerCoordY);
  }else if(imgSpeed <= speedY*25){
    image(car5,playerCoordX,playerCoordY);
  }else if(imgSpeed <= speedY*30){
    image(car1,playerCoordX,playerCoordY);
    imgSpeed = 0;
  }
  
  imgSpeed++;
}

//Checks collision with zombies
void checkCollision(){
  for(Zombie zombieModels: zombies){
   if(zombieModels != null && zombieModels.dead == false){ 
    if(abs(playerCoordX+60 - (zombieModels.x+25)) < 65  && abs(playerCoordY+132 - (zombieModels.y+30)) < 120){
      zombieModels.dead = true;
        
      carHealth -=1;
      kills += 1;
      
      //Changes GAMEMODE to Finished, if player runs out of health
      if(carHealth == 0){
        exploaded = true;
      }
    }
   }
  }
}

//Checks collision with barrels
void checkBarrelCollision(){
   for(int i = 0; i < barrels.size(); i++){
   if(barrels.get(i) != null){ 
    if(abs(playerCoordX+60 - (barrels.get(i).x+25)) < 65  && abs(playerCoordY+132 - (barrels.get(i).y+25)) < 120){
      barrels.get(i).hit = true;
     if(barrels.get(i).exploded){
      barrels.set(i, null);
      score -= 50*lvlmulti;
      carHealth -=1;
     }
      
      //Changes GAMEMODE to Finished, if player runs out of health
      if(carHealth == 0){
        exploaded = true;
     }
    }
   }
  }
}

//Checks collision with ammoBoxes
//Adds five ammo, when player collects ammo box
void checkAmmoBoxes(){
   for(int i = 0; i < ammoBoxes.size(); i++){
   if(ammoBoxes.get(i) != null){ 
    if(abs(playerCoordX+60 - (ammoBoxes.get(i).x+20)) < 65  && abs(playerCoordY+132 - (ammoBoxes.get(i).y+15)) < 120){
      ammoBoxes.get(i).ammoBoxCollected = true;
      ammoBoxes.set(i, null);
      
      ammo += 5;
    }
   }
  }
}

void move(){
  
  if(exploaded == false){
    
  if(moveUP && !outOfUp){
    playerCoordY -= speedY;
  }
  
  if(moveDown && !outOfDown){
  playerCoordY += speedY;
  }
  
  if(moveLeft && !outOfLeft){
  playerCoordX -= speedX;
  }
  
  if(moveRight && !outOfRight){
  playerCoordX += speedX;
  }
 }else{
   playerCoordY -= 1;
 }
 
}

//Sets bounds, so player can't move out of screen
void outOfStreet(){

  if(playerCoordX <= 83){
    outOfLeft = true;
  }else{
   outOfLeft = false;
  }
  
   if(playerCoordX >= 435){
    outOfRight = true;
  }else{
    outOfRight = false;
  }
  
  if(playerCoordY <= -100){
     outOfUp = true;
  }else{
    outOfUp = false;
  }
  
  if(playerCoordY >= 410){
    outOfDown = true;
  }else{
    outOfDown = false;
  }
}

//Displays health bar
void healthBar(){

  //hp
 switch(carHealth){
 case 4:
   image(hp100,30,15);
   break;
 case 3:
   image(hp75,30,15);
   break;
 case 2:
   image(hp50,30,15);
   break;
  case 1:
   image(hp25,30,15);
   break;
 default:
   image(hp0,30,15);
 break;
 }
}

//Displays kill counter
void killCounter(){
if(kills <= 9){
   image(killBgSmall,30,55);
}else{
  image(killBg,30,55);
}
  
  String killsString = Integer.toString(kills);
  int xImgKill = 35;
  for(int i = 0; i < killsString.length(); i++){
      char first = killsString.charAt(i);
      int firstNum = Integer.parseInt(String.valueOf(first));
      
          switch(firstNum){
             case 0:
             image(num0,xImgKill,55);
             break;
             case 1:
             image(num1,xImgKill,55);
             break;
             case 2:
             image(num2,xImgKill,55);
             break;
             case 3:
             image(num3,xImgKill,55);
             break;
             case 4:
             image(num4,xImgKill,55);
             break;
             case 5:
             image(num5,xImgKill,55);
             break;
             case 6:
             image(num6,xImgKill,55);
             break;
             case 7:
             image(num7,xImgKill,55);
             break;
             case 8:
             image(num8,xImgKill,55);
             break;
             case 9:
             image(num9,xImgKill,55);
             break;
             default:
             image(num0,xImgKill,55);
            }
            
            xImgKill += 20;
  }
}

//Displays score
void playerScore(){

   image(scoreBg,315,15);

  String playerScore = Integer.toString(score);
  int xImgScore = 333;
  if(score >= 0){
  for(int i = 0; i < playerScore.length(); i++){
      char first = playerScore.charAt(i);
      int firstNum = Integer.parseInt(String.valueOf(first));
      
          switch(firstNum){
             case 0:
             image(num0,xImgScore,15);
             break;
             case 1:
             image(num1,xImgScore,15);
             break;
             case 2:
             image(num2,xImgScore,15);
             break;
             case 3:
             image(num3,xImgScore,15);
             break;
             case 4:
             image(num4,xImgScore,15);
             break;
             case 5:
             image(num5,xImgScore,15);
             break;
             case 6:
             image(num6,xImgScore,15);
             break;
             case 7:
             image(num7,xImgScore,15);
             break;
             case 8:
             image(num8,xImgScore,15);
             break;
             case 9:
             image(num9,xImgScore,15);
             break;
             default:
             image(num0,xImgScore,15);
            }
            
            xImgScore += 20;
  }
  }else{
    score = 0;
  }
}

//Rotates person(on top of the car) to the mouse position
void rotatePlayer(){
  
  startPoint = new PVector(playerCoordX,playerCoordY);
  endPoint = new PVector(mouseX, mouseY);
  
  direction = PVector.sub(endPoint, startPoint);
  
  angle = (atan2(direction.y, direction.x));
  
  if(mouseY >= playerCoordY+100){
    
    pushMatrix();
    translate(playerCoordX+60,playerCoordY+145);
    rotate(angle + radians(-83));
    image(player1, -30, -40);
    popMatrix();
    lastAngle = angle;
  
  }else{
    
    pushMatrix();
    translate(playerCoordX+60,playerCoordY+145);
    rotate(lastAngle + radians(-83));
    image(player1,-30,-40);
    popMatrix();
  }
}

//Displays ammo bar
 void ammoBar(){
   
   if(ammo <= 9){
   image(ammoBg,230,15);
   }else{
  image(ammoBgLarge,230,15);
   }
  
  String ammoString = Integer.toString(ammo);
  int xAmmo = 230;
  for(int i = 0; i < ammoString.length(); i++){
      char first = ammoString.charAt(i);
      int firstNum = Integer.parseInt(String.valueOf(first));
      
          switch(firstNum){
             case 0:
             image(num0,xAmmo,15);
             break;
             case 1:
             image(num1,xAmmo,15);
             break;
             case 2:
             image(num2,xAmmo,15);
             break;
             case 3:
             image(num3,xAmmo,15);
             break;
             case 4:
             image(num4,xAmmo,15);
             break;
             case 5:
             image(num5,xAmmo,15);
             break;
             case 6:
             image(num6,xAmmo,15);
             break;
             case 7:
             image(num7,xAmmo,15);
             break;
             case 8:
             image(num8,xAmmo,15);
             break;
             case 9:
             image(num9,xAmmo,15);
             break;
             default:
             image(num0,xAmmo,15);
            }
            xAmmo += 20;
  }
 }
 
 //Runs Car On Fire animation and holds it for 3 seconds, after that GAMEMODE is changed and GAMEOVER screen is shown to a player
 void carExploaded(){
 
   if(exploaded){
     
     if(delayStarted == false){
       
       delaySeconds = timeSeconds+4;
       delayStarted = true;
     }
     
     image(carOnFire,playerCoordX,playerCoordY);
        if(imgSpeed <= speedY*5){
          image(fire1,playerCoordX+45,playerCoordY+185);
        }else if(imgSpeed <= speedY*10){
          image(fire2,playerCoordX+45,playerCoordY+185);
        }else if(imgSpeed <= speedY*15){
          image(fire3,playerCoordX+45,playerCoordY+185);
        }else if(imgSpeed <= speedY*20){
          image(fire4,playerCoordX+45,playerCoordY+185);
        }else if(imgSpeed <= speedY*25){
          image(fire5,playerCoordX+45,playerCoordY+185);
          imgSpeed = 0;
        }
        imgSpeed++;
      
      if(delaySeconds == timeSeconds){
      scoreboard.lastScore = score;
      currentGameMode = GAMEMODE.FINISHED;
      currentMenu = menuScreens[3];
      }
     }
    }
}
