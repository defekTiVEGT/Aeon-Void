class GameObject
{
  //Position 
  PVector position;
  //Direction of movement
  PVector velocity;
  //Speed of object
  float speed;
  //Color of object
  color c;
  //Radius of object
  float r;
  
  boolean isAlive;

  GameObject(PVector tempPosition, PVector tempVelocity, float tempSpeed, color tempC, float tempR )
  {
    position = tempPosition;
    velocity = tempVelocity;
    speed = tempSpeed;
    c = tempC;
    r = tempR;
    isAlive = true;
  }
  void update()
  {
  }
  
  void display()
  {
  }
}

