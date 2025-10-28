int playerX;
int playerSpeed = 5;
int bulletSpeed = 10;
boolean isShooting = false;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
int score = 0;

void setup() {
  size(800, 600);
  playerX = width / 2;
  
  // Create enemies
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 3; j++) {
      enemies.add(new Enemy(100 + i * 100, 50 + j * 50));
    }
  }
}

void draw() {
  background(0);

  // Display score
  fill(255);
  textSize(20);
  text("Score: " + score, 10, 30);

  // Draw and move the player
  fill(0, 255, 0);
  rect(playerX - 25, height - 50, 50, 20);

  // Move player left and right
  if (keyPressed) {
    if (key == 'a' || key == 'A') {
      playerX -= playerSpeed;
    }
    if (key == 'd' || key == 'D') {
      playerX += playerSpeed;
    }
  }

  // Ensure the player stays within bounds
  playerX = constrain(playerX, 25, width - 25);

  // Draw and move bullets
  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet b = bullets.get(i);
    b.update();
    b.display();
    if (b.isOffScreen()) {
      bullets.remove(i);
    }
    for (int j = enemies.size() - 1; j >= 0; j--) {
      Enemy e = enemies.get(j);
      if (b.hits(e)) {
        enemies.remove(j);
        bullets.remove(i);
        score += 10;
        break;
      }
    }
  }

  // Draw enemies
  for (Enemy e : enemies) {
    e.display();
    e.update();
  }

  // End the game if all enemies are destroyed
  if (enemies.isEmpty()) {
    fill(255);
    textSize(30);
    text("You Win!", width / 2 - 75, height / 2);
    noLoop();
  }
}

// Shooting mechanism
void keyPressed() {
  if (key == ' ' && !isShooting) {
    bullets.add(new Bullet(playerX, height - 60));
    isShooting = true;
  }
}

void keyReleased() {
  if (key == ' ') {
    isShooting = false;
  }
}

class Bullet {
  float x, y;
  Bullet(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void update() {
    y -= bulletSpeed;
  }

  void display() {
    fill(255, 0, 0);
    noStroke();
    ellipse(x, y, 10, 20);
  }

  boolean isOffScreen() {
    return y < 0;
  }

  boolean hits(Enemy e) {
    float d = dist(x, y, e.x, e.y);
    return d < 25;
  }
}

class Enemy {
  float x, y;
  float speed = 1;
  boolean movingRight = true;

  Enemy(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void update() {
    if (movingRight) {
      x += speed;
      if (x > width - 25) {
        movingRight = false;
        y += 30;
      }
    } else {
      x -= speed;
      if (x < 25) {
        movingRight = true;
        y += 30;
      }
    }
  }

  void display() {
    fill(255, 0, 255);
    noStroke();
    ellipse(x, y, 30, 30);
  }
}
