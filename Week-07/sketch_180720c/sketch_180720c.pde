// Collision detection adapted from:
// http://happycoding.io/tutorials/processing/collision-detection

ArrayList<Rectangle> rectangles = new ArrayList<Rectangle>();
float initW;
float initH;
float diag;

void setup() {
  size(920, 580);
  noStroke();
  colorMode(HSB, 100, 100, 100, 100);
  
  initW = width/13;
  initH = height/13;
  
  for(int i = 0; i < width; i += initW){
    for(int j = 0; j < height; j += initH){
      float w = random(initW/4, initW/1.5);
      float h = random(initW/4, initW/1.5);
      float hue = random(1) > 0.2 ? 6 : 28;
      rectangles.add(new Rectangle(
        i + random(-initW/2, initH/2),
        j + random(-initW/2, initH/2),
        w, h, hue
      ));
    }
  }
}

void draw() {
  background(0, 0, 20);

  //iterate over the rectangles
  for (int i = 0; i < rectangles.size(); i++) {
    Rectangle rectangle = rectangles.get(i);
    
    rectangle.prevX = rectangle.x;
    rectangle.prevY = rectangle.y;
    
    // compare this rectangle (i) with all the others
    for (int j = 0; j < rectangles.size(); j++) {
      Rectangle rectangle2 = rectangles.get(j);
      
      if(i != j){ // except with itself
        boolean checkX = (
            rectangle2.x + rectangle2.rectWidth > rectangle.x && 
            rectangle2.x < rectangle.x + rectangle.rectWidth &&
            rectangle2.y + rectangle2.rectHeight > rectangle.y && 
            rectangle2.y < rectangle.y + rectangle.rectHeight
          ) ||
          rectangle.x < 0 ||
          rectangle.x + rectangle.rectWidth > width ||
          rectangle.y < 0 ||
          rectangle.y + rectangle.rectHeight > height
        ;
        
        if(checkX){
          rectangle.x += random(-initW/4, initW/4);
          rectangle.y += random(-initH/4, initH/4);
        }
      }
    }

    if(
      rectangle.prevX == rectangle.x &&
      rectangle.prevY == rectangle.y
    ){
      rectangle.done = true;
    } else {
      rectangle.done = false;
    }

    drawRect(rectangle);
  }
}

void drawRect(Rectangle rectangle){
  
  if(rectangle.done){
    fill(rectangle.hue, 60, 40);
  } else {
    fill(0,0,70);
  }
  
  rect(rectangle.x, rectangle.y, rectangle.rectWidth, rectangle.rectHeight);
}
