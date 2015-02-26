class Mover {
  PVector position;
  PVector velocity;
  PVector currentR;
  PVector acceleration;

  float accel = 0.1;
  float decel = 0.98;
  float maxSpeed = 15;  
  float timer = 0;
  int bulletNum = 0;

  boolean shooting = false;

  Bullet[] bullets = new Bullet[20];

  Mover() {
    position = new PVector(width/2 + 10, height/2);
    velocity = new PVector(0, 0);
    currentR = new PVector(1, 0);
    acceleration = new PVector(0, 0);

    for (int i = 0; i < bullets.length; i++)
    {
      bullets[i] = new Bullet();
    }
  }

  void updatePosition() {
    rotating();
    moving();
    wrap();
    position.add(velocity);
  }

  void moving()
  {
    if (!move) {
      velocity.mult(decel);
    }
    if (move) {
      acceleration = PVector.mult(currentR, accel);
      velocity.add(acceleration);
      velocity.limit(maxSpeed);
    }
  }

  void shoot()
  {
    timer = 25;

    bullets[bulletNum].position = position.get();
    bullets[bulletNum].velocity = PVector.mult(currentR, 5);
    bullets[bulletNum].using = true;

    bulletNum++;
    if (bulletNum > 19) {
      bulletNum = 0;
    }
  }

  void rotating()
  {
    if (turnRight) {
      currentR.rotate(radians(2));
    }
    if (turnLeft) {
      currentR.rotate(radians(-2));
    }
  }

  void wrap()
  {
    if (position.x > width) {
      position.x = 0;
    }
    if (position.x < 0) {
      position.x = width;
    }
    if (position.y > height) {
      position.y = 0;
    }
    if (position.y < 0) {
      position.y = height;
    }
  }

  void display() {
    noFill();
    stroke(255);
    strokeWeight(2);
    updatePosition();
    pushMatrix();
    translate(position.x, position.y);
    rotate(currentR.heading());
    triangle(-10, 10, 17, 0, -10, -10);
    popMatrix();
    if (timer > 0)
    {
      timer--;
    }
    if (shooting && timer == 0)
    {
      shoot();
    }
    for (Bullet b : bullets) {
      if (b.using)
      {
        b.display();
      }
    }
  }
}

