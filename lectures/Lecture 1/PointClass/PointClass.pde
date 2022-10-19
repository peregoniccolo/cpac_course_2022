
float offset = 5;
color c1;

MyPoint p1;

void setup(){
  size(800,800);
  frameRate(60);
  c1 = color(255, 0, 0);
}


void draw(){ 
  background(255,255,255);
  
  if(p1 != null)
    p1.plot();
}

void mousePressed() {
  p1 = new MyPoint(mouseX,mouseY,10, c1);
  p1.move(mouseX,mouseY);
}

void mouseDragged() {
  //print(mouseX);
  p1.move(mouseX,mouseY);
}
