PImage score0, score1, score2, score3, score4, score5, score6, score7, score8, score9;

class scoreboard{

Integer[] scoreHistory = {0,0,0,0};
int lastScore;
boolean scoreCalculated;


void showData(){
  
    lastScore();
    topScores();
}

//Orders all data in (scoreHistory) Array in descending order
void scoreboardOrder(){
  
  if(scoreCalculated == false){
  
  scoreHistory[3] = lastScore;
  
    for(int i = 0; i < scoreHistory.length-1; i++){
      for(int a = 0; a < scoreHistory.length-i-1; a++){
        if(scoreHistory[a] < scoreHistory[a+1]){
          int temp = scoreHistory[a+1];
          scoreHistory[a+1] = scoreHistory[a];
          scoreHistory[a] = temp;
        }
      }
    }
  }
    scoreCalculated = true;
}

//Displays last score in Scoreboard
void lastScore(){
  
  String lastScoreString = Integer.toString(lastScore);
  int xlastScore = 282;
  for(int i = 0; i < lastScoreString.length(); i++){
      char first = lastScoreString.charAt(i);
      int firstNum = Integer.parseInt(String.valueOf(first));
      
          switch(firstNum){
             case 0:
             image(score0,xlastScore,305);
             break;
             case 1:
             image(score1,xlastScore,305);
             break;
             case 2:
             image(score2,xlastScore,305);
             break;
             case 3:
             image(score3,xlastScore,305);
             break;
             case 4:
             image(score4,xlastScore,305);
             break;
             case 5:
             image(score5,xlastScore,305);
             break;
             case 6:
             image(score6,xlastScore,305);
             break;
             case 7:
             image(score7,xlastScore,305);
             break;
             case 8:
             image(score8,xlastScore,305);
             break;
             case 9:
             image(score9,xlastScore,305);
             break;
             default:
             image(score0,xlastScore,305);
            }
            xlastScore += 45;
    }
}

//Displays top three score in Scoreboard
void topScores(){
  
   scoreboardOrder();
  
  int xTopScore = 260, yTopScore = 400;
  for(int a = 0; a < scoreHistory.length-1; a++){
    String scoreString = Integer.toString(scoreHistory[a]);
    for(int i = 0; i < scoreString.length(); i++){
        char first = scoreString.charAt(i);
        int firstNum = Integer.parseInt(String.valueOf(first));
        
            switch(firstNum){
               case 0:
               image(score0,xTopScore,yTopScore);
               break;
               case 1:
               image(score1,xTopScore,yTopScore);
               break;
               case 2:
               image(score2,xTopScore,yTopScore);
               break;
               case 3:
               image(score3,xTopScore,yTopScore);
               break;
               case 4:
               image(score4,xTopScore,yTopScore);
               break;
               case 5:
               image(score5,xTopScore,yTopScore);
               break;
               case 6:
               image(score6,xTopScore,yTopScore);
               break;
               case 7:
               image(score7,xTopScore,yTopScore);
               break;
               case 8:
               image(score8,xTopScore,yTopScore);
               break;
               case 9:
               image(score9,xTopScore,yTopScore);
               break;
               default:
               image(score0,xTopScore,yTopScore);
              }
              xTopScore += 45; 
        }
          xTopScore = 260;
          yTopScore += 49;
       }
  }
}
