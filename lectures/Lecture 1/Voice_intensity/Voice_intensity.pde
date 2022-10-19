
import processing.sound.*;
Amplitude amp;
AudioIn in; // to capture di audio

float intensity; // value in range 0 to 1

void setup()
{
  //size(800,600);
  fullScreen(); // create fullscreen canvas
  
  // Create an Input stream which is routed into the Amplitude analyzer
  amp = new Amplitude(this);
  in = new AudioIn(this, 0); // works as the camera, device 0 (best practice would be to check the devices we have, ...)
  in.start(); // start the acquisition
  amp.input(in); // associate the amp object to the in one
  
  intensity=0;
}



void draw()
{
  background(0);
  
  intensity = amp.analyze(); // read amp value
  
  fill((intensity+0)*10*255,(intensity+0)*10*255,(intensity+0)*10*255);
  rect(0, 0, width, height*intensity*10);
}
