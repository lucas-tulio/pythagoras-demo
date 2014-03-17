// Circles
int c1x, c1y, c1r;
int c2x, c2y, c2r;
int adjacent, opposite, hypotenuse;
int strokeColor = 0;

// Angle indicator stuff
int angleSize = 20;
int xAngleOffset = 0;
int yAngleOffset = 0;
int dotOffset = 0;

// Text drawing guides
int lineSize = 24;
int xInversion = 1;
int yInversion = 1;
int xTextOffset = 0;
int hypotenuseYTextOffset = 0;
int hypotenuseXTextOffset = 0;

// Size of the canvas
int width = 630;
int height = 500;

void setup() {

  size((int)width, (int)height);
  textSize(18);
  
  c1x = 100;
  c1y = 340;
  c1r = 30;
  c2x = 380;
  c2y = 200;
  c2r = 40;
}

void draw() {
  
  // White background, border
  background(255);
  stroke(0, 0, 0);
  rect(0, 0, width-1, height-1);
  
  // Movement
  c1x = mouseX;
  c1y = mouseY;

  // Calculate the Hypotenuse and the sum of both circles' radius
  int adjacent = getSide(c1x, c2x);
  int opposite = getSide(c1y, c2y);
  double hypotenuse = getHypotenuse(adjacent, opposite); 
  double sumOfRadius = c1r + c2r;
  
  // Check if the balls are touching
  if(hypotenuse <= sumOfRadius) {
    strokeColor = 200;
  } else {
    strokeColor = 0;
  }
  
  // Draw them on the screen
  stroke(strokeColor, 0, strokeColor);
  strokeWeight(4);
  ellipse(c1x, c1y, c1r * 2, c1r * 2);
  ellipse(c2x, c2y, c2r * 2, c2r * 2);

  // Change the Angle Indicator Size
  int smallerSide;
  if(adjacent <= opposite) {
    smallerSide = adjacent;
  } else {
    smallerSide = opposite;
  }
  angleSize = smallerSide / 4;
  if(angleSize >= 20) {
    angleSize = 20;
  } else if(angleSize < 10) {
    angleSize = 10;
  }
  
  // Check the inversion
  if(c1x >= c2x) {
    xInversion = -1;
    xTextOffset = -20;
    hypotenuseXTextOffset = 0;
    xAngleOffset = 0;
  } else {
    xInversion = 1;
    xTextOffset = 0;
    hypotenuseXTextOffset = -40;
    xAngleOffset = -angleSize;
  }

  if(c1y >= c2y) {
    yInversion = 1;
    hypotenuseYTextOffset = -20;
    yAngleOffset = -angleSize;
    dotOffset = 1;
  } else {
    yInversion = -1;
    hypotenuseYTextOffset = +20;
    yAngleOffset = 0;
    dotOffset = 0;
  }
  
  // Draw the adjacent, opposite and hypotenuse lines
  this.drawLines();
  
  // Show the values on the screen
  this.printValues(adjacent, opposite, hypotenuse);
}

void drawLines() {
  
  strokeWeight(1);
  
  // Draw the Square Angle indicator
  stroke(0, 0, 0);
  int rectX = c2x + xAngleOffset;
  int rectY = c1y + yAngleOffset;
  rect(rectX, rectY, angleSize, angleSize);
  fill(0, 0, 0);
  ellipse(dotOffset + (rectX*2.0 + angleSize) / 2.0, dotOffset + (rectY*2.0 + angleSize) / 2.0, 1, 1);

  // Adjacent side
  stroke(255, 0, 0);
  line(c1x, c1y, c2x, c1y);
  // Opposite side
  stroke(0, 0, 255);
  line(c2x, c2y, c2x, c1y);
  // Hypotenuse
  stroke(200, 0, 200);
  line(c1x, c1y, c2x, c2y);

  noFill();
}

/**
* Pythagoras Magic below
**/
double getHypotenuse(adjacent, opposite) {
  return Math.sqrt((double)(Math.pow(adjacent, 2) + Math.pow(opposite, 2)));
}

int getSide(int x1, int x2) {
  
  int side = x1 - x2;
  
  if(side < 0) {
    side = side * -1;
  }

  return side;
}

void printValues(int adjacent, int opposite, double hypotenuse) {
  
  fill(0);

  text("Circle 1", 10, 1*lineSize);
  text("x = " + c1x, 10, 2*lineSize);
  text("y = " + c1y, 10, 3*lineSize);
  text("radius = " + c1r, 10, 4*lineSize);
  
  text("Circle 2", 120, 1*lineSize);
  text("x = " + c2x, 120, 2*lineSize);
  text("y = " + c2y, 120, 3*lineSize);
  text("radius = " + c2r, 120, 4*lineSize);
  
  fill(255, 0, 0);
  text("adjacent side", 10, 6*lineSize);
  text(adjacent, (c1x + c2x) / 2 + xTextOffset, c1y + 20*yInversion);
  fill(0, 0, 255);
  text("opposite side", 10, 7*lineSize);
  text(opposite, c2x + 10*xInversion + xTextOffset, (c2y + c1y) / 2);
  fill(140, 0, 140);
  text("hypotenuse", 10, 8*lineSize);
  text("" + nf((float)hypotenuse, 0, 2), ((c1x + c2x) / 2) + hypotenuseXTextOffset, ((c1y + c2y) / 2) + hypotenuseYTextOffset);
  
  fill(0, 0, 0);
  text("Interactive demo of the Pythagorean Theorem", 10, (int)height - 10);
  text("Lucas Tulio, 2014", width - 150, (int)height - 10);
  
  noFill();
}