class Bullet {
  PVector position; 
  PVector velocity;
  
  boolean using = false;

  Bullet()
  {
    velocity = new PVector(0, 0);
    position = new PVector(0, 0);
  }

  void display()
  {
    if (using)
    {
      position.add(velocity);
      strokeWeight(3);
      stroke(255);
      point(position.x, position.y);
      
      if (position.x > width || position.x < 0 ||
      position.y > height || position.y < 0)
      {
        using = false;
      }
    }
  }
}

