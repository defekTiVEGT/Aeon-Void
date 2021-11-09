class Player extends GameObject
{
  
  int lives;
  int cooldown;
  int fireRate;
  
  Player(PVector tempPosition, PVector tempVelocity, float tempSpeed, color tempC, float tempR, int tempLives)
  {
    super(tempPosition, tempVelocity, tempSpeed, tempC, tempR);
    lives = tempLives;
    cooldown = 0;
    fireRate = 15;
  }
  
  void update()
  {
    for( int i = 0; i < objectList.size() ; i++)
    {
      GameObject tempObject = objectList.get(i);
      if(tempObject.r < 5)
      {
        if(((Bullet)tempObject).playerBullet == false)
        {
          if(checkCircleCollision(tempObject.position.x, tempObject.position.y, tempObject.r*2, position.x, position.y, r))
          {
           lives--;
           tempObject.isAlive = false;
           print(lives);
          }
        }
      }
    }
    
    if(lives == 3)
    {
      port.write('A');
      port.write('B');
      port.write('C');
    }
    
    if(lives == 2)
    {
      port.write('a');
      port.write('B');
      port.write('C');
    }
    
    if(lives == 1)
    {
      port.write('a');
      port.write('b');
      port.write('C');
    }
    
    if(lives <= 0)
    {
      isAlive = false;
    }
    
    if(isAlive == false)
    {
      port.write('a');
      port.write('b');
      port.write('c');
      
      lose = true;
    }
    
    velocity.set(0,0);
    
    if(inputArray[0] !=null)
    {
      if(inputArray[2].equals("1"))
      {
        velocity.y = -1;
      }
      if(inputArray[3].equals("1"))
      {
        velocity.y = 1;
      }
      if(inputArray[4].equals("1"))
      {
        velocity.x = -1;
      }
      if(inputArray[5].equals("1")) 
      {
        velocity.x = 1;
      }
      if( position.x > width - 25)
      {
        position.x = width - 25;
      }
      if(position.x < 25)
      {
        position.x = 25;
      } 
      if( position.y > height - 12.5)
      {
        position.y = height - 12.5;
      }
      if(position.y < 100 )
      {
        position.y = 100;
      }
      if(inputArray[0].equals("1") && cooldown >= fireRate)
      {
        shoot();
        cooldown = 0;
      }
      if(cooldown < fireRate)
      {
        port.write('l');
      }
    }
    
    velocity.normalize();
    
    cooldown++;
    
    position = PVector.add(position, PVector.mult(velocity, speed));
  }


  void display()
  {
    fill(c);
    ellipseMode(CENTER);
    ellipse(position.x, position.y, r*2, r*2);
  }
  
  void shoot()
  {
    objectList.add(new Bullet(position, new PVector( 0, -1), 8, color(255, 0, 0), 2, true)); 
    port.write('L');
  }
    
  
}


