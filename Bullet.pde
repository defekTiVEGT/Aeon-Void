class Bullet extends GameObject
{
  
  boolean  playerBullet;
  
  Bullet(PVector tempPosition, PVector tempVelocity, float tempSpeed, color tempC, float tempR, boolean tempBullet)
  {
    super(tempPosition, tempVelocity, tempSpeed, tempC, tempR);
    playerBullet = tempBullet;
  }
  
  void update()
  {
    velocity.normalize();
  
    position = PVector.add(position, PVector.mult(velocity, speed));
    
    if(position.x > 768 || position.x < 0 || position.y > 1024 || position.y < 0)
    {
      isAlive = false;
    }
    
  }
  void display()
  {
    fill(c);
    ellipseMode(CENTER);
    ellipse(position.x, position.y, r*2, r*2);
  }
  
  
}
