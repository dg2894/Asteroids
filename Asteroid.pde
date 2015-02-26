class Asteroid {
  PVector velocity;
  PVector position;

  boolean active = false;
  boolean newShape = false;
  int kind;
  float theSize;

  PShape[]asteroids = new PShape[2];

  Asteroid(int k, float s) {
    kind = k;
    theSize = s;
    velocity = new PVector(0, 0);
    position = new PVector(0, 0);
    createAsteroids();
  }

  void createAsteroids() {
    asteroids[0] = new PShape();
    asteroids[0] = createShape();
    asteroids[0].beginShape();
    asteroids[0].noFill();
    asteroids[0].stroke(255);
    asteroids[0].vertex(0, -20);
    asteroids[0].vertex(10, -15);
    asteroids[0].vertex(15, -10);
    asteroids[0].vertex(15, 0);
    asteroids[0].vertex(20, 5);
    asteroids[0].vertex(10, 20);
    asteroids[0].vertex(5, 20);
    asteroids[0].vertex(-5, 20);
    asteroids[0].vertex(-10, 10);
    asteroids[0].vertex(-15, 10);
    asteroids[0].vertex(-20, 0);
    asteroids[0].vertex(-20, -10);
    asteroids[0].vertex(-10, -15);
    asteroids[0].vertex(-5, -15);
    asteroids[0].scale(theSize);
    asteroids[0].endShape(CLOSE);

    asteroids[1] = new PShape();
    asteroids[1] = createShape();
    asteroids[1].beginShape();
    asteroids[1].noFill();
    asteroids[1].stroke(255);
    asteroids[1].vertex(20, 20);
    asteroids[1].vertex(30, 0);
    asteroids[1].vertex(10, -10);
    asteroids[1].vertex(10, -20);
    asteroids[1].vertex(0, -20);
    asteroids[1].vertex(-15, -15);
    asteroids[1].vertex(-20, 10);
    asteroids[1].vertex(-10, 20);
    asteroids[1].scale(theSize);
    asteroids[1].endShape(CLOSE);
  }

  void display()
  {
    position.add(velocity);
    pushMatrix();
    translate(position.x, position.y);
    shape(asteroids[kind]);
    asteroids[kind].rotate(0.02);
    popMatrix();

    if (position.x > width || position.x < 0 ||
      position.y > height || position.y < 0)
    {
      active = false;
    }
  }
}

