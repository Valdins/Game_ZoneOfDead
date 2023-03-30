PImage bulletImg;

class Bullet{
  
PVector startPoint, direction, endPoint, test;
boolean hitTarget, shot = true;
float angleBullet;
final int bulletSpeed = 10;

Bullet(){
 
  angleBullet = playerModel.angle;
  
  float x = cos(angleBullet)*35 + playerModel.playerCoordX+60;
  float y = sin(angleBullet)*35 + playerModel.playerCoordY+145;
  
  this.startPoint = new PVector(x,y);
  this.endPoint = new PVector(mouseX, mouseY);
  
  direction = PVector.sub(endPoint, startPoint);

  direction.normalize();
}

  void update(){
    
     render();
     move();
     outOfBounds();
  }

  void render(){
    
    pushMatrix();
    translate(startPoint.x,startPoint.y);
    rotate(angleBullet + radians(-90));
    image(bulletImg,0,0);
    popMatrix();
  }
  
  void move(){
  
   startPoint.x += direction.x*bulletSpeed;
   startPoint.y += direction.y*bulletSpeed;
  }
  
  //Deletes bullet if it flies out of screen
  boolean outOfBounds(){
  
    if(startPoint.x >= 650 || startPoint.x <= -20 || startPoint.y >= 910 || startPoint.y <= -10){
      return true;
    }
  return false;
  }
  
}
