
float increment = 0.01; // changing the increment will change the produced pattern

void setup() {
  size(800,200);
  noLoop();
}

void draw() {
  background(0);
  
  
  loadPixels(); // we need to modify each pixel of the canvas
  // we can now access all of them as an array (computationally ligheter than a matrix)

  float xoff = 0.0; // Start xoff at 0
  
  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = 0; x < width; x++) {
    xoff += increment;     // Increment xoff 
    float yoff = 0.0;      // For every xoff, start yoff at 0
    
    for (int y = 0; y < height; y++) {
      yoff += increment; // Increment yoff
      
      // Calculate noise and scale by 255
      float bright = noise(xoff,yoff)*255;
      // noise is connected to a specific coordinate in a the space
      // to generate the whole space we cicle over it
      // noise returns a value from 0 to 1

      // Try using this line instead
      // float bright = random(0,255); // uniform distrubution
      
      // Set each pixel onscreen to a grayscale value
      pixels[x+y*width] = color(bright);
    }
  }
  
  updatePixels();
}
