
class MyPoint {

  float x, y;
  float size;
  color c;

  //Constructor
  public MyPoint(float x, float y, float size, color c) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.c = c;
  }

  // ---- Methods
  public void plot() {
    noStroke();
    fill(c);
    rect(x, y, size, size);
  }
  
  public void plotTrace(float x, float y) {
    noStroke();
    fill(c);
    rect(x, y, size/2, size/2);
  }

  public void move(float x, float y) {
    float oldX = x;
    float oldY = y;
    this.x = x;
    this.y = y;
    plotTrace(oldX, oldY);
  }

  public void changeColor(color c) {
    this.c = c;
  }
  
}
