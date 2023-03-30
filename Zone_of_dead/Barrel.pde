PImage barrel, exp1, exp2, exp3, exp4, exp5, exp6, exp7, exp8;
 
class Barrel extends obstacle{

boolean hit, exploded, disappear;

void update(){
  
   render();
   move();
   out();
   explosion();
   
   //Checks collision with other barrels
   for(Barrel barrelModels: barrels){
     selfCollision(barrelModels);
   }
     
     //Checks collision with bullets
     for(Bullet bulletModels: bullets){
     bulletCollision(bulletModels);
     }
}

void render(){
  if(disappear == false){
   image(barrel,x,y);
  }
}

void out(){
  
  //Respawns ammoBox when gous out of screen
  if(y <= -50){
  y = (int)random(920,background.height+500);
        x = (int)random(100,500);
  }
 }
 
 //Checks collision with other barrels
 void selfCollision(Barrel other){
    
   if(other != null){
    if(abs(this.x-other.x) < 100 && abs(this.y - other.y) < 100 && abs(this.x-other.x) != 0 && abs(this.y - other.y) != 0){
         y = (int)random(920,background.height+500);
         x = (int)random(100,500);
    }
   }
  }
  
  //Shows explosion animation, when barrel is hit by a car
  void explosion(){
    if(hit){
        if(imgSpeed <= 5){
        image(exp1,x-85,y-87);
      }else if(imgSpeed <= 10){
        image(exp2,x-85,y-87);
      }else if(imgSpeed <= 15){
        image(exp3,x-85,y-87);
      }else if(imgSpeed <= 20){
        image(exp4,x-85,y-87);
      }else if(imgSpeed <= 25){
        image(exp5,x-85,y-87);
        disappear = true;
      }else if(imgSpeed <= 30){
        image(exp6,x-85,y-87);
      }else if(imgSpeed <= 35){
        image(exp7,x-85,y-87);
      }else if(imgSpeed <= 40){
        image(exp8,x-85,y-87);
        exploded = true;
      }
      imgSpeed++;
    }
    
  }
  
  //Checks collision with bullets
  void bulletCollision(Bullet bullet){
    
   if(bullet != null){
    if(abs(this.x+25-bullet.startPoint.x) < 25 && abs(this.y+25 - bullet.startPoint.y) < 25){
      bullet.hitTarget = true;
    }
   }
  }

}
