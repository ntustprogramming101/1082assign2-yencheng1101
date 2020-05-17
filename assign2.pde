PImage bg, soil, life, soldier, cabbage, groundhogIdle, groundhogDown, groundhogLeft, groundhogRight, title, gameover, startNormal, startHovered, restartNormal, restartHovered;

final int Game_Start=0;
final int Game_Run=1;
final int Game_Lose=2;
int gameState = Game_Start;

final int Button_Top =360;
final int Button_Bottom =420;
final int Button_Left =248;
final int Button_Right =392;

float lifeCount=2;
float centerX = width/2;
float soldierX = 0;
float soldierY = floor(random(2,6))*80;
float soldierWidth = 80;
float speed=80;
float cabbageX=floor(random(0,8))*80;
float cabbageY=floor(random(2,6))*80;
float groundhogIdleX=320,groundhogIdleY=80;
float groundhogLestX, groundhogLestY;
float groundhogWidth=80,groundhogHeight=80;
float cabbageWidth=80,cabbageHeight=80;
float newTime,lastTime;
float ONE_BLOCK=80;

int actionFrame;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;


void setup() {
	size(640, 480, P2D);
	// Enter Your Setup Code Here
  bg= loadImage("img/bg.jpg");
  soil= loadImage("img/soil.png");
  groundhogIdle= loadImage("img/groundhogIdle.png");
  life= loadImage("img/life.png");
  soldier= loadImage("img/soldier.png");
  cabbage= loadImage("img/cabbage.png");
  groundhogIdle= loadImage("img/groundhogIdle.png");
  groundhogDown= loadImage("img/groundhogDown.png");
  groundhogLeft= loadImage("img/groundhogLeft.png");
  groundhogRight= loadImage("img/groundhogRight.png");
  title= loadImage("img/title.jpg");
  gameover= loadImage("img/gameover.jpg");
  startNormal= loadImage("img/startNormal.png");
  startHovered= loadImage("img/startHovered.png");
  restartNormal= loadImage("img/restartNormal.png");
  restartHovered= loadImage("img/restartHovered.png");
  frameRate(60);
  gameState = Game_Start;
  lastTime = millis();
}

void draw() {
  
  // Switch Game State
  switch(gameState){
  
  // Game Start
  case Game_Start:
  
  background(title);
  imageMode(CORNER);
  image(startNormal,248,360);
  groundhogIdleX=-80;
  groundhogIdleY=-80;
  if(mouseX>Button_Left && mouseX< Button_Right && mouseY>Button_Top && mouseY<Button_Bottom){
  image(startHovered,248,360);
    if(mousePressed){
      gameState=Game_Run;
    }
  }
  break;
  
  // Game Run
  case Game_Run:
  
  background(bg);
  imageMode(CENTER);
  image(soil,width/2,height*2/3);
  
  //grass
    noStroke();
    colorMode(RGB);
    fill(124,204,25);
    rectMode(CORNERS);
    rect(0,145,640,160);
  
  //sun
    stroke(255,255,0);
    strokeWeight(5);
    fill(253,184,19);
    ellipse(590,50,120,120);
  
  //groundhog
    imageMode(CORNER);
    
   if(groundhogIdleX < 0){
        groundhogIdleX= 0 ;
      }
      
    if(groundhogIdleX >= width-groundhogWidth){
        groundhogIdleX= width-groundhogWidth ;
    }
    
    if(groundhogIdleY+groundhogHeight>= height){
        groundhogIdleY= height-groundhogHeight ;
      }
      
    if(groundhogIdleY <= height/6){
        groundhogIdleY= height/6 ;
      }
     if (downPressed == false && leftPressed == false && rightPressed == false) {
      image(groundhogIdle, groundhogIdleX, groundhogIdleY, groundhogWidth, groundhogHeight);
    }
    //draw the groundhogDown image between 1-14 frames
    if (downPressed) {
      actionFrame++;
      if (actionFrame > 0 && actionFrame < 15) {
        groundhogIdleY += ONE_BLOCK / 15.0;
        image(groundhogDown, groundhogIdleX, groundhogIdleY, groundhogWidth, groundhogHeight);
      } else {
        groundhogIdleY = groundhogLestY + ONE_BLOCK;
        downPressed = false;
      }
    }
    //draw the groundhogLeft image between 1-14 frames
    if (leftPressed) {
      actionFrame++;
      if (actionFrame > 0 && actionFrame < 15) {
        groundhogIdleX -= ONE_BLOCK / 15.0;
        image(groundhogLeft, groundhogIdleX, groundhogIdleY, groundhogWidth, groundhogHeight);
      } else {
        groundhogIdleX = groundhogLestX - ONE_BLOCK;
        leftPressed = false;
      }
    }
    //draw the groundhogRight image between 1-14 frames
    if (rightPressed) {
      actionFrame++;
      if (actionFrame > 0 && actionFrame < 15) {
        groundhogIdleX += ONE_BLOCK / 15.0;
        image(groundhogRight, groundhogIdleX, groundhogIdleY, groundhogWidth, groundhogHeight);
      } else {
        groundhogIdleX = groundhogLestX + ONE_BLOCK;
        rightPressed = false;
      }
    }
      
  //life
    if(lifeCount==2){
      
      image(life,10,10);
      image(life,80,10);
      
    }else if(lifeCount==3){
      
      image(life,10,10);
      image(life,80,10);
      image(life,150,10);
      
    }else if(lifeCount==1){
      
      image(life,10,10);
      
    }else if(lifeCount==0){
     gameState=Game_Lose;
    }    
    
    
  //soldier
    image(soldier,soldierX,soldierY);
    soldierX++;
    if(soldierX >= width){
    soldierX = -soldierWidth;  
    }else{
     soldierX++;
     } 
  //groundhog crash soldier
    if(groundhogIdleX+groundhogWidth>soldierX && groundhogIdleX<soldierX+soldierWidth && groundhogIdleY+groundhogHeight>soldierY && groundhogIdleY<soldierY + soldierWidth){
    lifeCount-=1;
    groundhogIdleX=400;
    groundhogIdleY=80;
    }
  
  //cabbage
    image(cabbage,cabbageX,cabbageY);
    if(groundhogIdleX+groundhogWidth>cabbageX && groundhogIdleX<cabbageX+cabbageWidth && groundhogIdleY+groundhogHeight>cabbageY && groundhogIdleY<cabbageY + cabbageHeight){
      cabbageX=-80;
      cabbageY=-80;
      lifeCount+=1;
    } 

  if(lifeCount == 0){
    gameState=Game_Lose;
  }
  break;

		

		// Game Lose
  case Game_Lose:
  
  background(gameover);
  image(restartNormal,248,360);
  groundhogIdleX=-80;
  groundhogIdleY=-80;
  if(mouseX>Button_Left && mouseX< Button_Right && mouseY>Button_Top && mouseY<Button_Bottom){
    image(restartHovered,248,360);
    lifeCount=2;
    cabbageX=floor(random(0,8))*80;
    cabbageY=floor(random(2,6))*80;
    if(mousePressed){
    gameState=Game_Run; 
    }
  } 
  
  break;

  }
}

void keyPressed(){
  float newTime = millis(); //time when the groundhog started moving
  if (key == CODED) {
    switch (keyCode) {
    case DOWN:
      if (newTime - lastTime > 250) {
        downPressed = true;
        actionFrame = 0;
        groundhogLestY = groundhogIdleY;
        lastTime = newTime;
      }
      break;
    case LEFT:
      if (newTime - lastTime > 250) {
        leftPressed = true;
        actionFrame = 0;
        groundhogLestX = groundhogIdleX;
        lastTime = newTime;
      }
      break;
    case RIGHT:
      if (newTime - lastTime > 250) {
        rightPressed = true;
        actionFrame = 0;
        groundhogLestX = groundhogIdleX;
        lastTime = newTime;
      }
      break;
    }
  }
}
////////
void keyReleased(){
  
  image(groundhogIdle,groundhogIdleX,groundhogIdleY);
  
}
