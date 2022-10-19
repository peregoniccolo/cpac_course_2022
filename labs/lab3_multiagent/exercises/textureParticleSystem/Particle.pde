class Particle{
  PVector pos, vel, acc;
  float radius, lifespan;
  float hue;
  float sigma = 0.3;
  int mu_y = -2;
  Particle(PVector pos, float radius, float lifespan){
    this.pos= pos.copy();
    
    float rand_x = randomGaussian()*sigma; // mu = 0
    float rand_y = randomGaussian()*sigma + mu_y;
    this.vel = new PVector(rand_x, rand_y);
    this.acc = new PVector();
    this.radius=radius;
    this.lifespan=lifespan;
    this.hue=random(0,255);
    
    
    //PVector force = new PVector(rand_x, rand_y);
    //this.applyForce(force);
  }
  void update(){    
    this.vel.add(this.acc);
    this.pos.add(this.vel);
    this.acc.mult(0);
  }
  
  void applyForce(PVector force){    
    this.acc.add(force);    
  }
  
  void draw(){
    //colorMode(HSB, 255);
    //fill(200, this.lifespan);
    //noStroke();
    //ellipse(this.pos.x, this.pos.y, this.radius, this.radius);    
    imageMode(CENTER); 
    tint(255, this.lifespan); 
    image(img, this.pos.x, this.pos.y);
  }
  boolean isDead(){
    return this.lifespan<=0;
  }
}
