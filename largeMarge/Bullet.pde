class Bullet {
  
  int speed = 5;
  
  double x, y;
  boolean dir; // true = left
  Bullet(double x, double y, boolean dir) {
    this.x = x;
    this.y = y;
    this.dir = dir;
  }
  
  // return false if the bullet is out of the world bounds
  boolean update() {
    x += dir ? -speed : speed;
    return (x >= 0 && x <= width);
  }
  
  void display() {
    fill(0,255,0);
    stroke(0, 255, 0);
    rect((float)x, (float)y, 1, 1);
  }
  
}
