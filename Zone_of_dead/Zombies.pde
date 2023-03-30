PImage zombieImg1, zombieImg2, zombieImg3, zombieImg4, zombieImg5, zombieDead1, zombieDead2, zombieDead3, zombieDead4;

class Zombie extends obstacle{

int speedX = 1;
boolean moveLeft, moveRight, hitByBullet, dead, resetTimeOnce;

Zombie(){
  
  speedY = 2;
  x = (int)random(100,500);
}

  void update(){
    
     render();
     move();
     respawn();
     moveLeft = false;
     moveRight = false;
     
     //Checks collision with barrels
     for(Barrel barrelModels: barrels){
     collisionWithBarrel(barrelModels);
    }
     
     //Checks collision other zombies
     for(Zombie zombieModels: zombies){
     selfCollision(zombieModels);
    }
    
    //Checks collision with bullets
    for(Bullet bulletModels: bullets){
     bulletCollision(bulletModels);
    }
  }

//Renders animation for zombies
  void render(){
    
     if(dead == false){
       
          if(imgSpeed <= speedY*5){
          image(zombieImg1,x,y);
        }else if(imgSpeed <= speedY*10){
          image(zombieImg2,x,y);
        }else if(imgSpeed <= speedY*15){
          image(zombieImg3,x,y);
        }else if(imgSpeed <= speedY*20){
          image(zombieImg2,x,y);
        }else if(imgSpeed <= speedY*25){
          image(zombieImg1,x,y);
        }else if(imgSpeed <= speedY*30){
          image(zombieImg4,x,y);
        }else if(imgSpeed <= speedY*35){
          image(zombieImg5,x,y);
        }else if(imgSpeed <= speedY*40){
          image(zombieImg4,x,y);
        }else if(imgSpeed <= speedY*45){
          image(zombieImg1,x,y);
          imgSpeed = 0;
        }
     }
  
  //Renders death animation
  if(dead){
    if(resetTimeOnce == false){
      imgSpeed = 0;
      resetTimeOnce = true;
    }
    speedY = 1;
    
    if(imgSpeed <= 8){
      image(zombieImg1,x,y);
    }else if(imgSpeed <= 16){
      image(zombieDead1,x,y);
    }else if(imgSpeed <= 24){
      image(zombieDead2,x,y);
    }else if(imgSpeed <= 32){
      image(zombieDead3,x,y);
    }else if(imgSpeed >= 32){
      image(zombieDead4,x,y);
    }
  }
   imgSpeed += 1;
 }
  
  @Override
  void move(){
   
    super.move();
    
    if(moveLeft){
     x = x - speedX;
    }
    
    if(moveRight){
     x = x + speedX;
    }
  }
  
  //Resets zombies position when it goes out of screen
  void respawn(){
    
  if(dead == false){
    if(y < -60){
        y = (int)random(920,background.height+500);
        x = (int)random(100,500);
    }
   }
  }
 
 //Checks collision other zombies
  void selfCollision(Zombie other){
    
   if(other != null && other.dead == false && this.dead == false){
    if(abs(this.x-other.x) < 64 && abs(this.y - other.y) < 64 && abs(this.x-other.x) != 0 && abs(this.y - other.y) != 0){
         y = (int)random(920,background.height+500);
         x = (int)random(100,500);
    }
   }
  }
  
  //Checks collision with bullets
   void bulletCollision(Bullet bullets){
   if(bullets != null && dead == false){
    if(abs(this.x+30-bullets.startPoint.x) <= 20 && abs(this.y+30 - bullets.startPoint.y) <= 20){
      bullets.hitTarget = true;
      hitByBullet = true;
      dead = true;
      playerModel.kills += 1;
      playerModel.score += 20*lvlmulti;
    }
   }
  }
  
  //Checks collision with barrels
  void collisionWithBarrel(Barrel barrelModels){
    
   if(barrelModels != null && dead == false){ 
    if(abs(this.x+30 - (barrelModels.x+25)) < 50  && abs(this.y+30 - (barrelModels.y+50)) < 100){
        if((this.x+30 - (barrelModels.x+25)) < 25){
         this.moveLeft = true;
        }else{
         this.moveRight = true;
        }
    }
   }
  }
  
}
