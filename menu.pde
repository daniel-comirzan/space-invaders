background(0, 0, 255);
size(500, 500);

rect(50, 50, 400, 75);
rect(50, 150, 400, 75);
rect(50, 250, 400, 75);
rect(50, 400, 400, 75);



if (mousePressed && (mouseY > 50) && (mouseX < 450) && (mouseY > 50) && (mouseY < 125)) {
  
  background(255);
  
}

if (mousePressed && (mouseY < 250) && (mouseX < 250) && (mouseY > 100) && (mouseX > 125)) {
    background(0, 255, 0);
}

if (mousePressed && (mouseY < 375) && (mouseX > 125) && (mouseY <250) && (mouseX > 100)) {
    background(255, 165, 0);   
}

if (mousePressed && (mouseY < 375) && (mouseX > 125) && (mouseY <250) && (mouseX > 100)) {
    background(255, 0, 0);
}

if (mousePressed) {
    println(mouseX, mouseY);
}


  textSize(35);
  fill(0, 255, 0);
  text("easy", 190, 95);

  fill(255, 165, 0);
  text("medium", 170, 195);

  fill(255, 0, 0);
  text("hard", 190, 295);

  fill(0);
  text("back to menu", 140, 445);