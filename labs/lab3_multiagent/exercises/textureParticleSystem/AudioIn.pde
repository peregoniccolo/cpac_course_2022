import ddf.minim.*;
import ddf.minim.analysis.*;

int frameLength = 1024; //--> when this is low, it may take more to compute
AudioInput mic;
FFT fft;
Minim minim;
float maxEnergy=0;

float compute_energy() {
  fft.forward(this.mic.mix);
  float band_energy;
  float energy = 0;
  //float rectWidth=width/fft.specSize();
  //fill(255);
  for (int i=0; i<fft.specSize(); i++) {
    band_energy=this.fft.getBand(i)/fft.specSize();
    energy += pow(band_energy,2);
    //rect(i*rectWidth, height, rectWidth, max(-height, -10*height*band_energy));
    //maxEnergy=max(maxEnergy, band_energy);
  }
  return energy * 10;
}
