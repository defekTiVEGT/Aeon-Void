class Enemy extends GameObject
{
  int cooldown;
  float fireRate;
  int type;
  int lives;
  
  Enemy(PVector tempPosition, PVector tempVelocity, float tempSpeed, color tempC, float tempR, int tempFireRate, int tempType)
  {
    super(tempPosition, tempVelocity, tempSpeed, tempC, tempR);
    fireRate = tempFireRate;
    type = tempType;
    cooldown = 0;
    if(type == 1)
    {
      velocity.set(1,0);
      fireRate = 12.5;
      lives = 25;
    }
  }
  
  void update()
  {
    for( int i = 0; i < objectList.size() ; i++)
    {
      GameObject tempObject = objectList.get(i);
      if(tempObject.r < 5)
      {
        if(((Bullet)tempObject).playerBullet)
        {
          if(checkCircleCollision(tempObject.position.x, tempObject.position.y, tempObject.r*2, position.x, position.y, r))
          {
           lives--;
           if(lives == 0)
            {
              isAlive = false;
              if(isAlive == false)
              {
                win = true;
              }
            }
           tempObject.isAlive = false;
          }
        }
      }
    }
    
    
    
    if(type == 1)
    {
      if(position.x + r >= width)
      {
        velocity.x = -1;
        position.y += r;
      }
      else if( position.x - r <= 0)
      {
        velocity.x = 1;
        position.y += r;
      }
    }
    
   if(cooldown >= fireRate)
   {
     cooldown = 0;
     shoot();
   }
   
    velocity.normalize();
    
    cooldown++;
    
    position = PVector.add(position, PVector.mult(velocity, speed));
  }
  
  void display()
  {
    if(type == 1)
    {
      fill(c);
      ellipseMode(CENTER);
      ellipse(position.x, position.y, r*2, r*2);
    }
    
  }
  
  void shoot()
  {
    if(type == 1) 
    {
    objectList.add(new Bullet(position, new PVector( 0, 1), 4, color(158, 255, 220), 2, false));
  
    }
  }  
}

