// v2 -- working game.
// Small corrections


int alienCount = 10;
int hoogte = 400;
int breedte = 250;
int snelheid = 5;
int difficulty = 2; // 1 = easy ; 2 = medium ; 3 = hard
int score = 0;

ArrayList<Kogel> kogels = new ArrayList<Kogel>();
ArrayList<Alien> aliens = new ArrayList<Alien>();

void setup() {
  size(500, 500);

  for (int i=0; i < alienCount; i++) {
    float cirkelstekenen = int(width * i / alienCount + 25);
    //float cirkelstekenen = width / 2;
    switch(difficulty) {
    case 1:
      aliens.add(new Alien(cirkelstekenen, 10, 2));
      break;
    case 2:
      aliens.add(new Alien(cirkelstekenen, int(random(0, 20)), 3));
      break;
    case 3:
      aliens.add(new Alien(cirkelstekenen, int(random(height)/2), 5));
      break;
    }
  }
}

void draw() {
  background(135, 206, 235);

  line(0, 450, 500, 450);
  line(166, 450, 166, 500);
  line(332, 450, 332, 500);

  textSize(25);
  fill(0);
  text("time:", 30, 480);
  //text("score: " + score, 200, 480);
  text("quit game", 350, 480);

  // define player movement
  if (keyPressed) {
    if (keyCode == LEFT ) {
      breedte -= 5;
    }
    if (keyCode == RIGHT ) {
      breedte += 5;
    }
  }

  // define player square
  fill(255, 50, 50);
  rect(breedte, hoogte, 25, 25);

  // limit the player to the screen size
  if ( breedte > 475 ) {
    breedte = 475;
  }

  if ( breedte < 0 ) {
    breedte = 0;
  }

  for ( int i = kogels.size() - 1; i >= 0; i-- ) {

    Kogel k = kogels.get(i);
    k.update();
    k.display();
    if (k.offScherm()) {
      kogels.remove(i);
    }
    for ( int j = aliens.size() - 1; j >= 0; j-- ) {
      Alien a = aliens.get(j);
      if (k.hit(a.x, a.y)) {
        aliens.remove(j);
        kogels.remove(i);
        score += 10;
      }
    }
  }

  for ( int i = 0; i < aliens.size(); i++ ) {
    Alien al = aliens.get(i);
    al.update();
    al.display();
  }

  fill(0);
  text("score: " + score, 200, 480);
  
  if (aliens.isEmpty() ) {
    textSize(40);
    fill(255);
    text("You WIN!", int(width/2 - 50), int(height/2));
    noLoop();
  }
}

void keyPressed() {
  if ( key == ' ' ) {
    kogels.add(new Kogel(breedte + 10, hoogte - 5 ));
  }
}

class Kogel {
  float x, y;
  int red;
  int green;
  int blue;

  Kogel(float x, float y) {
    this.x = x;
    this.y = y;
    this.red = int(random(0, 255));
    this.green = int(random(0, 255));
    this.blue = int(random(0, 255));
  }

  void display() {
    fill(red, green, blue);
    triangle(x, y, x+5, y+5, x-5, y+5);
    rect(x-5, y+5, 10, 20);
  }

  void update() {
    y -= 5;
  }

  boolean offScherm() {
    return y < 0;
  }

  boolean hit(float ax, float ay) {
    return dist(x, y, ax, ay) < 25;
  }
}

class Alien {
  float x, y;
  int s;
  int red;
  int green;
  int blue;

  Alien(float x, float y, int snelheid) {
    this.x = x;
    this.y = y;
    this.s = snelheid;
    this.red = int(random(0, 255));
    this.green = int(random(0, 255));
    this.blue = int(random(0, 255));
  }

  void update() {
    y += s;
    if (y > height - 75) {
      y = 0;
    }
  }

  void display() {
    fill(red, green, blue);
    ellipse(x, y, 30, 30);
  }
}
