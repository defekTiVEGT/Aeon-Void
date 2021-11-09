import processing.serial.*;

PImage BG, Win, Lose, Start;
int Window_Height = 1024;
int Window_Width = 768;

Serial port;
String inputString;
String [] inputArray;

ArrayList<GameObject> objectList;

boolean lose;
boolean win;
boolean start;
Player player1;
int timer1 = 0;
int timer2 = 0;


void setup()
{
  size(Window_Width, Window_Height);
  
  frameRate(60);
  
  BG = loadImage("background.png");
  Win = loadImage("win.png");
  Lose = loadImage("lose.png");
  Start = loadImage("start.png");
 
  println(Serial.list());
  port = new Serial(this, Serial.list()[1], 9600);
  inputArray = new String[6];
  
  objectList = new ArrayList<GameObject>();
 
  player1 = new Player(new PVector(Window_Width / 2, 1000), new PVector(), 4, color(0, 255, 0), 12.5, 3);
  objectList.add(player1);
  objectList.add(new Enemy(new PVector(100, 100), new PVector(), 2, color(0, 0, 255), 25, 60, 1));
  start = true;

}

void draw()
{
  if(start == true)
  {
    image(Start, 0, 0);
    timer2++;
  }
  if(timer2 > 300)
  {
    start = false;
    timer2 = 0;
  }
  if(lose == false && win == false && start == false)
  {
    image(BG, 0, 0);
    for( int i = 0; i < objectList.size() ; i++)
    {
      GameObject tempObject = objectList.get(i);
      tempObject.update();
      tempObject.display();
      if(tempObject.isAlive == false)
      {
        objectList.remove(i);
      }
    }
  }
  
  if(lose == true)
  {
    image(Lose, 0 , 0);
    timer1++;
  }
  
  if(win == true)
  {
    image(Win, 0, 0);
    timer1++;
  }
  
  if(win == true || lose == true && timer1 > 60)
  {
      if(inputArray[0].equals("1"))
      {
        start = true; 
      }
   }
 } 

void serialEvent(Serial port)
{
  if(port.available() > 0)
  {
    inputString = port.readStringUntil('\n');
    if(inputString != null)
    {
      inputString = inputString.trim();
      if(inputString != null)
      {
        inputArray = inputString.split(",");
      }
    }
  }
}

boolean checkCircleCollision(float x1, float y1, float w1, float x2, float y2, float w2)
{
  float radiusSum = w1 / 2 + w2 / 2;
  println(radiusSum);
  float distance = distanceFormula(x1, x2, y1, y2);
  
  if (distance <= radiusSum)
    return true;
  else 
    return false;
}

float distanceFormula(float x1, float x2, float y1, float y2)
{
  return sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
}

