class ParticleSystem{
  ArrayList<Particle> particles;
  PVector origin;
  ParticleSystem(){
    this.particles = new ArrayList<Particle>();
    this.origin=new PVector(width/2, height);
  }
  ParticleSystem(PVector origin){
    this.particles = new ArrayList<Particle>();
    this.origin=origin.copy();
  }
  void addParticle(){
    this.particles.add(new Particle(this.origin, 10, random(0,255)));   
  }
  void draw(){
    Particle p;

    PVector wind_force=new PVector(computeEnergy(),0);
    for(int i=this.particles.size()-1; i>=0; i--){
      p=this.particles.get(i);
     // random_force.x=random(-small_force, small_force);
     // random_force.y=random(-small_force, small_force);
      p.applyForce(wind_force);
      p.update();
      p.draw();
      p.lifespan-=0.2;
      if(p.isDead()){
         particles.remove(i);
         this.addParticle();
      }
    
    }
  }

}
