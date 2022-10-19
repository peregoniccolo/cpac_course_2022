import ddf.minim.*;
import ddf.minim.analysis.*;


float compute_flatness(){
  return random(3);
}

float compute_centroid(FFT fft, float[] freqs, int K){  
  float num = 0, den = 0, X_k, f_k;
  
  for (int k = 0; k < K; k++) {
    // at each iteration, each freq bin is summed
    X_k = fft.getBand(k);
    f_k = freqs[k];
    
    num += f_k*X_k;
    den += X_k;
  }
  
  float centroid = num/ (den+0.00001); // to avoid division by 0
  // if we want to have 1 as a result, add the delta at num
  
  return centroid;
}

float compute_spread(){
  return random(3);
}

float compute_skewness(){
  return random(3);  
}

float compute_entropy(){
  return random(3);
}

float compute_energy(FFT fft, int K) {    
  float energy = 0;
  float X_k;
  
  for (int k = 0; k < K; k++) {
    // at each iteration, each freq bin is summed
    X_k = fft.getBand(k);
    energy = energy + X_k*X_k;
  }
  
  return energy;
}
class AgentFeature { 
  float sampleRate;
  int K;
  FFT fft;
  BeatDetect beat;
  
  float[] freqs;
  float sum_of_bands;
  float centroid;
  float spread;
  float energy;
  float skewness;
  float entropy;
  float flatness;
  boolean isBeat;
  float lambda_smooth;
  AgentFeature(int bufferSize, float sampleRate){    
    this.fft = new FFT(bufferSize, sampleRate);
    this.fft.window(FFT.HAMMING);
    this.K=this.fft.specSize();
    this.beat = new BeatDetect();
    
    this.lambda_smooth = 0.5;
    this.freqs=new float[this.K];
    for(int k=0; k<this.K; k++){
      this.freqs[k]= (0.5*k/this.K)*sampleRate;
    }
    
    this.isBeat=false;
    this.centroid=0;
    this.spread=0;
    this.sum_of_bands = 0;
    this.skewness=0;    
    this.entropy=0;
    this.energy=0;
  }
  
  float smooth_filter(float old_value, float new_value){
    /* Try to implement a smoothing filter using this.lambda_smooth*/
    return this.lambda_smooth*new_value + (1-this.lambda_smooth*old_value);
    
  }
  
  void reasoning(AudioBuffer mix){
     this.fft.forward(mix);
     this.beat.detect(mix);
     float centroid = compute_centroid(this.fft, this.freqs, this.K);
     float flatness = compute_flatness();
     float spread = compute_spread();                                  
     float skewness= compute_skewness();
     float entropy = compute_entropy();     
     float energy = compute_energy(this.fft, this.K);
     
     this.centroid = centroid;    
     this.energy = this.smooth_filter(this.energy, energy);
     this.flatness = flatness;
     this.spread = spread;
     this.skewness = skewness;
     this.entropy = entropy;  }   
} 
