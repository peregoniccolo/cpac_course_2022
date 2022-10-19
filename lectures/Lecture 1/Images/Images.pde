PImage img;

void setup() {
  size(1024, 576);
  frameRate(60);
  
  img = loadImage("40704.jpg");
  imageMode(CENTER); // the coordinates provided in image() will be the image center
  noStroke();
  background(255);
}

void draw() { 
  image(img,width/2,height/2);
}
