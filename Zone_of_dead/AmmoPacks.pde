PImage ammoBox;

class AmmoPacks extends obstacle{

boolean ammoBoxCollected;

void update(){
  
   render();
   move();
   out();
   
   //Checks collision with other ammo boxes
   for(AmmoPacks ammoBoxModels: ammoBoxes){
     selfCollision(ammoBoxModels);
  }
  
  //Checks collision with barrels
  for(Barrel barrelModels: barrels){
     barrelCollision(barrelModels);
     }
}

void render(){
  
   image(ammoBox,x,y);
}

//Respawns ammoBox when gous out of screen
void out(){
  
  if(y <= -50){
    y = (int)random(920,background.height+500);
  }
 }
 
 //Checks collision with other ammo boxes
 void selfCollision(AmmoPacks other){
    
   if(other != null){
    if(abs(this.x-other.x) < 100 && abs(this.y - other.y) < 100 && abs(this.x-other.x) != 0 && abs(this.y - other.y) != 0){
         y = (int)random(920,background.height+500);
         x = (int)random(100,500);
    }
   }
  }
  
  //Checks collision with barrels
  void barrelCollision(Barrel barrels){
    
   if(barrels != null){
    if(abs(this.x+20-barrels.x+25) < 50 && abs(this.y+15 - barrels.y+25) < 50){
        y = (int)random(920,background.height+500);
        x = (int)random(100,500);
    }
   }
  }
 
 }
