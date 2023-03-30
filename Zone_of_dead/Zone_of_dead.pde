PImage background, backgroundLevel2, backgroundTransition, mainMenu, instructions, instructions2, gameOver;

ArrayList<Zombie> zombies = new ArrayList<Zombie>();
ArrayList<Barrel> barrels = new ArrayList<Barrel>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<AmmoPacks> ammoBoxes = new ArrayList<AmmoPacks>();

Player playerModel;
MouseScope scope;
scoreboard scoreboard;

final String[] menuScreens = {"MAIN","INSTRUCTIONS","INSTRUCTIONS2","GAMEOVER"};
String currentMenu;

enum GAMEMODE{
  NEWGAME, LEVEL1, TRANSITION, LEVEL2, FINISHED
}

GAMEMODE currentGameMode = GAMEMODE.NEWGAME;

int backgroundY = 0, timeSeconds, lvlmulti = 1, lastSec;
boolean timePassedScore = true, timePassedZombie = true, timePassedBarrel = true, timePassedAmmoBox = true, levelChanged, transition, transition_started;

void setup(){
  
 size(640,900);
 
 uploadImages();
 
 scope = new MouseScope();
 scoreboard = new scoreboard();
 
 //Set up all variables to be ready for the game to start
 resetGame();
 
 //Game set to NEWGAME
 GAMEMODE currentGameMode = GAMEMODE.NEWGAME;
 
 //Menu set to Main screen
 currentMenu = menuScreens[0];
}

void draw(){

  //All MENU SCREENS(including instructions screens)
  if(currentGameMode == GAMEMODE.NEWGAME){
    if(currentMenu == menuScreens[0]){
      image(mainMenu,0,0);
    }
    if(currentMenu == menuScreens[1]){
      image(instructions,0,0);
    }
    if(currentMenu == menuScreens[2]){
      image(instructions2,0,0);
    }
  }
  
  //Game over screen and runs code for scoreboard
  if(currentGameMode == GAMEMODE.FINISHED){
    if(currentMenu == menuScreens[3]){
      image(gameOver,0,0);
      scoreboard.showData();
    }
  }
  
  //Transition between level 1 and level 2
    if(currentGameMode == GAMEMODE.LEVEL1 || currentGameMode == GAMEMODE.TRANSITION){
     
     //Level 1 background
     if(currentGameMode == GAMEMODE.LEVEL1 || transition == false){
        image(background, 0, backgroundY);
        image(background, 0, backgroundY+background.height);
          backgroundY -=1;
         if(backgroundY == -background.height){
             backgroundY=0; //wrap background
         }
             if(currentGameMode == GAMEMODE.TRANSITION && backgroundY == 0)
             transition_started = true;
    }
     //Transition screen and level 2 screen
   if(currentGameMode == GAMEMODE.TRANSITION && transition_started == true){
      transition = true;
        image(background, 0, backgroundY);
        image(backgroundTransition, 0, backgroundY+background.height);
        image(backgroundLevel2, 0, backgroundY+background.height*2);
          backgroundY -=1;
         if(backgroundY == -1800){
           backgroundY = 0;
           currentGameMode = GAMEMODE.LEVEL2;
         }
     }
   //Sets variables to change to LEVEL 2
   if(playerModel.kills == 15 && levelChanged == false){
      currentGameMode = GAMEMODE.TRANSITION;
      lvlmulti = 2;
      levelChanged = true;
   }
   
  }
  
  // LEVEL 2, background for LVL 2
  if(currentGameMode == GAMEMODE.LEVEL2){
   
  image(backgroundLevel2, 0, backgroundY);
  image(backgroundLevel2, 0, backgroundY+background.height);
    backgroundY -=1;
   if(backgroundY == -background.height){
       backgroundY=0; //wrap background
   }
  }
  
  //Main code for all LEVELS , updating classes( player, obstacles)
  if(currentGameMode == GAMEMODE.LEVEL1 || currentGameMode == GAMEMODE.TRANSITION || currentGameMode == GAMEMODE.LEVEL2){
    
    //Starts counting time, when game starts (in seconds)
    if(second()!= lastSec){
    timeSeconds += 1;
    lastSec = second();
  }
    
    if(timeSeconds % 5 == 0 && timePassedScore && playerModel.exploaded == false){
      playerModel.score += 5*lvlmulti;
      timePassedScore = false;
    }
    
    if(timeSeconds%5 != 0){
      timePassedScore = true;
    }
    
    for(int i = 0; i < ammoBoxes.size(); i++){
           if(ammoBoxes.get(i) != null){
             ammoBoxes.get(i).update();
             
             if(ammoBoxes.get(i).ammoBoxCollected == true){
             ammoBoxes.set(i, null);
            }
           }
       }
   
       for(int i = 0; i < zombies.size(); i++){
           if(zombies.get(i) != null && zombies.get(i).dead == true) {
             zombies.get(i).update();
           }
         
           if(zombies.get(i) != null && zombies.get(i).dead == false) {
             zombies.get(i).update();
           }
           if(zombies.get(i) != null && zombies.get(i).dead && zombies.get(i).y < -100){
             zombies.set(i, null);
            }
       }
       
       playerModel.update();
       
       for(int i = 0; i < bullets.size(); i++){
           if(bullets.get(i) != null && playerModel != null){
            bullets.get(i).update();
             
             if(bullets.get(i).hitTarget || bullets.get(i).outOfBounds()){
               bullets.set(i, null);
            }
           }
       }
       
       //Update barrels in LEVEL 2
       if(currentGameMode == GAMEMODE.LEVEL2){
         
               for(Barrel barrelModels: barrels){
                   if(barrelModels != null){
                     barrelModels.update();
                   }
               }
               
           if(barrels.size() <= 3){
            if(timeSeconds%30 == 0 && timePassedBarrel){
                barrels.add(new Barrel());
             timePassedBarrel = false;
               }
            }
            
            if(timeSeconds%30 != 0){
              timePassedBarrel = true;
            }
       }
     
    //Resets boolean variables for all objects, so more can be added in the game 
    if(timeSeconds%10 == 0 && timePassedZombie){
        zombies.add(new Zombie());
     timePassedZombie = false;
       }
    
     if(timeSeconds%80 == 0 && timePassedAmmoBox){
        ammoBoxes.add(new AmmoPacks());
     timePassedAmmoBox = false;
       }
    
    if(timeSeconds%10 != 0){
      timePassedZombie = true;
    }
    if(timeSeconds%40 != 0){
      timePassedAmmoBox = true;
    }
    
  }
  
  //Updates scope
  scope.update();
}

//Resets all variables, clears arraylists
void resetGame(){
 zombies.clear();
 barrels.clear();
 ammoBoxes.clear();
 bullets.clear();
  
 scoreboard.lastScore = 0;
 scoreboard.scoreCalculated = false;
  
 playerModel = new Player(400,50);
 
 spawnZombies();
 
 timeSeconds = 0;
 
 levelChanged = false;
 transition = false;
 transition_started = false;
}

//Uploading all images for game
void uploadImages(){

  background = loadImage("Images/background.png");
  backgroundLevel2 = loadImage("Images/bg_level2.png");
  backgroundTransition = loadImage("Images/bg_transition.png");
 
  zombieImg1 = loadImage("Images/zombie_layer1.png");
  zombieImg2 = loadImage("Images/zombie_layer2.png");
  zombieImg3 = loadImage("Images/zombie_layer3.png");
  zombieImg4 = loadImage("Images/zombie_layer4.png");
  zombieImg5 = loadImage("Images/zombie_layer5.png");
  
  zombieDead1 = loadImage("Images/zombie_dead_2.png");
  zombieDead2 = loadImage("Images/zombie_dead_3.png");
  zombieDead3 = loadImage("Images/zombie_dead_4.png");
  zombieDead4 = loadImage("Images/zombie_dead_5.png");
  
  hp100 = loadImage("Images/hp_100.png");
  hp75 = loadImage("Images/hp_75.png");
  hp50 = loadImage("Images/hp_50.png");
  hp25 = loadImage("Images/hp_25.png");
  hp0 = loadImage("Images/hp_0.png");
  
  player1 = loadImage("Images/player_0.png");
  
  barrel = loadImage("Images/barrel.png");
  
  bulletImg = loadImage("Images/bullet.png");
  
  ammoBg = loadImage("Images/ammo_background.png");
  ammoBgLarge = loadImage("Images/ammo_background_large.png");
  num0 = loadImage("Images/ammo_0.png");
  num1 = loadImage("Images/ammo_1.png");
  num2 = loadImage("Images/ammo_2.png");
  num3 = loadImage("Images/ammo_3.png");
  num4 = loadImage("Images/ammo_4.png");
  num5 = loadImage("Images/ammo_5.png");
  num6 = loadImage("Images/ammo_6.png");
  num7 = loadImage("Images/ammo_7.png");
  num8 = loadImage("Images/ammo_8.png");
  num9 = loadImage("Images/ammo_9.png");
  
  ammoBox = loadImage("Images/ammoBox.png");
  
  scopeImg = loadImage("Images/scope.png");
  defaultCursor = loadImage("Images/crosshair.png");
  
  mainMenu = loadImage("Images/main_menu.png");
  instructions = loadImage("Images/instructions.png");
  instructions2 = loadImage("Images/instructions_2.png");
  gameOver = loadImage("Images/game_over.png");
  
  killBg = loadImage("Images/kill_counter.png");
  killBgSmall = loadImage("Images/kill_counter_small.png");
  
  car1 = loadImage("Images/car_1.png");
  car2 = loadImage("Images/car_2.png");
  car3 = loadImage("Images/car_3.png");
  car4 = loadImage("Images/car_4.png");
  car5 = loadImage("Images/car_5.png");
  carOnFire = loadImage("Images/car_on_fire.png");
  
   exp1 = loadImage("Images/explosion_1.png");
   exp2 = loadImage("Images/explosion_2.png");
   exp3 = loadImage("Images/explosion_3.png");
   exp4 = loadImage("Images/explosion_4.png");
   exp5 = loadImage("Images/explosion_5.png");
   exp6 = loadImage("Images/explosion_6.png");
   exp7 = loadImage("Images/explosion_7.png");
   exp8 = loadImage("Images/explosion_8.png");
   
   scoreBg = loadImage("Images/score_bg.png");
   
  score0 = loadImage("Images/score_0.png");
  score1 = loadImage("Images/score_1.png");
  score2 = loadImage("Images/score_2.png");
  score3 = loadImage("Images/score_3.png");
  score4 = loadImage("Images/score_4.png");
  score5 = loadImage("Images/score_5.png");
  score6 = loadImage("Images/score_6.png");
  score7 = loadImage("Images/score_7.png");
  score8 = loadImage("Images/score_8.png");
  score9 = loadImage("Images/score_9.png");
  
  fire1 = loadImage("Images/fire_1.png");
  fire2 = loadImage("Images/fire_2.png");
  fire3 = loadImage("Images/fire_3.png");
  fire4 = loadImage("Images/fire_4.png");
  fire5 = loadImage("Images/fire_5.png");
}

//Spawns two zombies
void spawnZombies(){
  for(int i = 0; i < 2;i++){
     zombies.add(new Zombie());
   }
}
