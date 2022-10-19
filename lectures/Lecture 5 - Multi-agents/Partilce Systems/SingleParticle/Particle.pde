

class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float mass;

  Particle(PVector l) {
    acceleration = new PVector(0, 0.05); // gravity
    velocity = new PVector(random(-1, 1), random(-1, 0)); // random direction behavior
    location = l.get();
    lifespan = 255.0;
    mass = 1;
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);  // Force/Mass
    acceleration.add(f);
  }

  void run() {
    update();
    render();
  }

  // Method to update location
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 2.0;
  }

  // Method to display
  void display() {
    stroke(0, lifespan); // lifespan used as alpha value, 255 -> 0 becoming more transparent
    strokeWeight(2);
    fill(127, lifespan);
    ellipse(location.x, location.y, 12, 12);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } 
    else {
      return false;
    }
  }
}
