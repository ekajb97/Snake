// Jake Byrne 
import processing.sound.*;

// Audio
SoundFile file;
// Insert files 
String bgMusic="";
String gameOver="";
String bite="";
String path;

// Variables
int direction=0;
int snakesize=4;
int[] headx= new int[1600];
int[] heady= new int[1600];
int applex=(round(random(37))+1)*10;
int appley=(round(random(37))+1)*10;
boolean play=false;
boolean stop=false;
int highscore=0;

void setup()
{
  frameRate(20);// speed of the game
  fill(255);
  restart();
  size(400,450);
  textAlign(CENTER);
  
  if (play == true)
  {
    path = sketchPath(bgMusic);
    file = new SoundFile(this, path);
    file.loop();
  }
}

void draw()
{  delay(100);
   fill(0,150,180);
   rect(0, 400, width, height);
   // Draw score box
   fill(255);
   rect(20, 405, 360, 40);
   textSize(26);
   fill(0);
   text("SCORE:", 70, 440);
   text(snakesize-1, 135, 440);
   text("HIGH-SCORE:", 260, 440);
   text(highscore, 360, 440);
      
   fill(0);
   if (stop==true)
   {
     // stops the game when you die
   }
   else
   {    
     // draws the game
     fill(255,0,0);
     stroke(0);
     rect(applex,appley,10,10);
     fill(0,150,180);
     stroke(0);
     rect(0,0,width,10);
     rect(0,height-60,width,10);
     rect(0,0,10,height-60);
     rect(width-10,0,10,height-60);
     travel();
     eat();
     dead();
    }
  } 

// controls
void keyPressed()
{
  if (key == CODED)
  {
    if (keyCode == UP && direction!=270 && (heady[1]-10)!=heady[2])
    {
      direction=90;
    }
    if (keyCode == DOWN && direction!=90 && (heady[1]+10)!=heady[2])
    {
      direction=270;
    }
    if (keyCode == LEFT && direction!=0 && (headx[1]-10)!=headx[2])
    {
      direction=180;
    }
    if (keyCode == RIGHT && direction!=180 && (headx[1]+10)!=headx[2])
    {
      direction=0;
    }
    if (keyCode == SHIFT)
    {
      // restart the game by pressing shift
      restart();
    } 
    if (keyCode == ALT)
    {
      // pause the game by pressing alt
      stop = true;
    }
    if (keyCode == CONTROL)
    {
      // pause the game by pressing alt
      stop = false;
    }
  }
}

// creates the movement of the snake
void travel()
{
  for(int i=snakesize;i>0;i--)
  {
    if (i!=1)
    {
      //shift all the coordinates back one array
      headx[i]=headx[i-1];
      heady[i]=heady[i-1];
    }
    else
    {
      //move the new spot for the head of the snake, which is
      //always at headx[1] and heady[1].
      switch(direction)
      {
        case 0:
        headx[1]+=10;
        break;
        case 90:
        heady[1]-=10;
        break;
        case 180:
        headx[1]-=10;
        break;
        case 270:
        heady[1]+=10;
        break;
      }
    }
  }  
}

// checks to see if the snake ate the apple 
// creates a new apple at a random location
void eat()
{
  // does the snake's head eat the apple?
  if (headx[1]==applex && heady[1]==appley)
  {
    path = sketchPath(bite);
    file = new SoundFile(this, path);
    file.play();

    snakesize++;
    
    // create new apple
    play=true;
    while(play)
    {
      applex=(round(random(37))+1)*10;
      appley=(round(random(37))+1)*10;
      for(int i=1;i<snakesize;i++)
      {
        if (applex==headx[i] && appley==heady[i])
        {
          play=true;
        }
        else
        {
          play=false;
          i=1000;
        }
      }
    }
  }
  // Snake
  fill(0,200,50);
  rect(headx[1],heady[1],10,10);
  fill(0);
  rect(headx[snakesize],heady[snakesize],10,10);
}

// checks when the snake bites itself or hits the wall
void dead()
{
  for(int i=2;i<=snakesize;i++)
  {
    // is the head of the snake occupying the same spot as any of the snake chunks?
    if (headx[1]==headx[i] && heady[1]==heady[i])
    {
      // death sound effect
      path = sketchPath(gameOver);
      file = new SoundFile(this, path);
      file.play();
      // death message
      fill(200,0,0);
      rect(125,125,160,150);
      fill(0);
      textSize(14);
      text("GAME OVER",200,150);
      text("Don't Bite Yourself",200,175);
      text("Score:  "+(snakesize-1),200,200);
      text("High-Score:  "+highscore,200,225);
      text("To restart, press Shift",205,250);
      if((snakesize-1)>highscore)
      {
        highscore=(snakesize-1);
      }
      stop=true;
    }
    // is the head of the snake hitting the walls?
    if (headx[1]>=(width-10) || heady[1]>=(height-60) || headx[1]<=0 || heady[1]<=0)
    { 
      // death sound effect
      path = sketchPath(gameOver);
      file = new SoundFile(this, path);
      file.play();
      // death message
      fill(200,0,0);
      rect(125,125,160,150);
      fill(0);
      textSize(14);
      text("GAME OVER",200,150);
      text("Mind Your Head",200,175);
      text("Score:  "+(snakesize-1),200,200);
      text("High-Score:  "+highscore,200,225);
      text("To restart, press Shift",205,250);
      if((snakesize-1)>highscore)
      {
        highscore=(snakesize-1);
      }
      stop=true;
    }
  }
}

// resets the game when shift is pressed
void restart()
{
  // by pressing shift, all of the main variables reset to their defaults.
  background(0);
  headx[1]=200;
  heady[1]=200;
  for(int i=2;i<1000;i++)
  {
    headx[i]=0;
    heady[i]=0;
  }
  stop=false;
  applex=(round(random(37))+1)*10;
  appley=(round(random(37))+1)*10;
  snakesize=5;
  direction=0;
  play=true;
}