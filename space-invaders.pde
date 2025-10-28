int alienCount = 10;
int hoogte = 400;
int breedte = 250;
int snelheid = 5;
boolean bulletOn = false;

ArrayList<Kogel> kogels = new ArrayList<Kogel>();
ArrayList<Alien> aliens = new ArrayList<Alien>();

void setup() {
  size(500, 500);
  
  for (int i=1; i<= width; i+= alienCount) {
    aliens.add(new Alien(int(hoogte / alienCount) * i, 20));
  }
  
}

void draw() {
  background(135, 206, 235);

  line(0, 450, 500, 450);
  line(166, 450, 166, 500);
  line(332, 450, 332, 500);

  textSize(25);
  fill(0);

  // define player --
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
  
  for ( int i = kogels.size() - 1; i >= 0 ; i-- ){
  
    Kogel k = kogels.get(i);
    k.update();
    k.display();
  } 
  
  for ( int i = 0; i < aliens.size() ; i++ ) {
    Alien al = aliens.get(i);
    al.update();
    al.display();
  }
  
  
}

void keyPressed() {
  if ( key == ' ' ) {
    kogels.add(new Kogel(breedte, hoogte - 45));
  }
}

class Kogel {
  float x, y;
  
  Kogel(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void display() {
    fill(255, 50, 50);
    //ellipse(x, y, 5, 20);
    line(x, y, x+10, y+10);
    line(x+10, y+10, x+10, y+30);
    line(x+10, y+30, x-10, y+30);
    line(x-10, y+30, x-10, y+10);
    line(x-10, y+10, x, y);
  }
  
  void update() {
    y -= snelheid;
  }
}

class Alien {
  float x, y;
  float snelheid = int(random(1, 3));
  
  Alien(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void update() {
    y += snelheid;
  }
  
  void display() {
    fill(255, 0, 255);
    ellipse(x, y, 30, 30);
  }
}
