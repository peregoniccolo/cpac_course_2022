import processing.sound.*;
import java.util.Date;

AgentMover[] movers;
int agentNum;
String[] fileNames;
int MASS_TO_PIXEL=10;
float mass_mover = 10;
float mass_attractor;
PVector pos_attractor;
float radius_attractor;
float area;
float dist=0;
float Amin = 0.01;

String[] getFilenames() {
  String path=sketchPath()+"/sounds";
  File dir = new File(path);
  String all_filenames[] = dir.list();
  int N_wavs=0;
  for (int i=0; i<all_filenames.length; i++) {
    if (all_filenames[i].endsWith(".wav")) {
      N_wavs++;
    }
  }
  String[] wav_filenames= new String[N_wavs];
  int j=0;
  for (int i=0; i<all_filenames.length; i++) {
    if (all_filenames[i].endsWith(".wav")) {
      wav_filenames[j]=sketchPath()+"/sounds/" + all_filenames[i];
      j++;
    }
  }
  return wav_filenames;
}


void setup() {
  fileNames = getFilenames();
  agentNum = fileNames.length;
  movers = new AgentMover[agentNum];
  SoundFile sound;
  for (int i = 0; i < agentNum; ++i) {
    sound = new SoundFile(this, fileNames[i]);
    movers[i] = new AgentMover(random(10, 50), sound);
    sound.loop();
  }
  mass_attractor=random(800, 1200);
  pos_attractor = new PVector(width/2., height/2.);
  radius_attractor = sqrt(mass_attractor/PI)*MASS_TO_PIXEL;

  size(1280, 720);
  background(0);
}

float computeApplyGravityForce(AgentMover mover) {
  PVector attr_force = mover.position.copy();

  attr_force.sub(pos_attractor);
  dist= attr_force.mag();
  float unconstrained_dist = dist;
  dist=constrain(dist, dist_min, dist_max);
  attr_force.normalize();
  attr_force.mult(-1*mass_attractor*mover.mass/(dist*dist));
  mover.applyForce(attr_force);
  return unconstrained_dist;
}


void draw() {
  rectMode(CORNER);
  fill(0, 20); //<>//
  rect(0, 0, width, height);
  fill(200, 0, 200, 40);
  ellipse(pos_attractor.x, pos_attractor.y,
    radius_attractor, radius_attractor);

  float dist, amp;
  for (int i = 0; i < fileNames.length; ++i) {
    dist = computeApplyGravityForce(movers[i]);
    amp = max(Amin, 1/(1+Amin*dist));
    movers[i].setAmp(amp);
    movers[i].update();
    movers[i].draw();
  }
}
