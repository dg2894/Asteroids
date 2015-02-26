Mover mover;
Asteroid[] asteroids = new Asteroid[30];

boolean turnLeft = false;
boolean turnRight = false;
boolean move = false;
boolean gameOver = false;
boolean savedScores = false;

int aNum = 0;
float timer;
float harder = 100;
int type;
int limit = 10;
int score = 0;

float shipCol;
float bulletCol;

int[] data;
String [] scoreSummary;
String theScores = "";
String lastFive = "";

void setup() {
  size(700, 600, P2D);
  mover = new Mover();
  for (int i = 0; i < asteroids.length; i++) 
  {
    asteroids[i] = new Asteroid(int(random(0, 2)), 1);
    asteroids[i].active = false;
  }
}

void draw() {
  background(0);
  mover.display();
  shipCollision();
  bulletCollision();
  textAlign(CENTER);
  textSize(24);
  fill(255);
  text(score, width/2, 22);

  for (Asteroid a : asteroids) 
  {
    if (a.active) 
    {
      a.display();
    }
  }

  if (timer > 0) 
  {
    timer--;
  }
  if (timer == 0) 
  {
    newAst();
  }

  if (gameOver)
  {
    gameOverScreen();
  }
}

void newAst()
{
  if (harder > 20)
  {
    harder -= 1;
  } else if (harder - 0.05 < 20)
  {
    harder = 20;
  }

  timer = harder;

  if (asteroids[aNum].active == false)
  {
    asteroids[aNum] = new Asteroid(int(random(0, 2)), random(1, 3));

    if (mover.position.x < width/2)
    {
      asteroids[aNum].position = new PVector(random(width/2, width), random(height));
    } else if (mover.position.x > width/2)
    {
      asteroids[aNum].position = new PVector(random(0, width/2), random(height));
    }
    asteroids[aNum].velocity = new PVector(random(-1, 1), random(-1, 1));
    asteroids[aNum].active = true;
  }

  if (limit < asteroids.length -  2)
  {
    limit++;
  }

  if (aNum > limit) 
  {
    aNum = 0;
  }
  aNum++;
}

void gameOverScreen()
{
  if (savedScores == false)
  { 
    String[] stuff = loadStrings("scores.txt");
    for (int i = 0; i < stuff.length; i++)
    {
      theScores += stuff[i] + ",";
    }
    theScores += score;

    scoreSummary = split(theScores, ',');
    for (int i = scoreSummary.length - 5; i < scoreSummary.length; i++)
    {
      lastFive += "    " + scoreSummary[i];
    }
    saveStrings("scores.txt", scoreSummary);
    savedScores = true;
  }

  background(0);
  textAlign(CENTER);
  text("Game Over", width/2, height/2 - 20);
  text("Recent Scores:" + lastFive, width/2, height/2 + 20);
}

void shipCollision()
{
  for (Asteroid a : asteroids)
  {
    if (a.active)
    {
      shipCol = mover.position.dist(a.position);

      if (shipCol < 13.5 + a.theSize * 20) 
      {
        gameOver = true;
      }
    }
  }
}

void bulletCollision()
{
  for (Bullet b : mover.bullets)
  {
    for (int i = 0; i < asteroids.length; i++)
    {
      if (b.using && asteroids[i].active)
      { 
        bulletCol = b.position.dist(asteroids[i].position);

        if (bulletCol < 1 + asteroids[i].theSize * 20) 
        {
          b.using = false;
          PVector tempPos = asteroids[i].position;
          int theKind = asteroids[i].kind;
          float theSize = asteroids[i].theSize;
          if (theSize - 0.5 < 0.75)
          {
            asteroids[i].active = false;
            score += 10;
          } else {
            asteroids[i].active = false;
            asteroids[aNum] = new Asteroid(theKind, theSize-0.5);
            asteroids[aNum].position.x = tempPos.x;
            asteroids[aNum].position.y = tempPos.y+5;
            asteroids[aNum].velocity = new PVector(random(-1, 1), random(-1, 1));
            asteroids[aNum].active = true;

            asteroids[i] = new Asteroid(theKind, theSize-0.5);
            asteroids[i].position.x = tempPos.x;
            asteroids[i].position.y = tempPos.y-5;
            asteroids[i].velocity = new PVector(random(-1, 1), random(-1, 1));
            asteroids[i].active = true;
            score += 5;
          }
        }
      }
    }
  }
}

void keyPressed() {
  if (keyCode == RIGHT) 
  {
    turnRight = true;
  }
  if (keyCode == LEFT) 
  {
    turnLeft = true;
  }
  if (keyCode == UP) 
  {
    move = true;
  }
  if (keyCode == DOWN) 
  {
    mover.position = new PVector(random(width), random(height));
  }
  if (key == ' ') 
  {
    mover.shooting = true;
  }
}

void keyReleased() {
  if (keyCode == RIGHT) 
  {
    turnRight = false;
  }
  if (keyCode == LEFT) 
  {
    turnLeft = false;
  }
  if (keyCode == UP) 
  {
    move = false;
  }
  if (key == ' ') 
  {
    mover.shooting = false;
  }
}

