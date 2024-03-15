//Aayush Silwal and Sarah Zhang
class Laser {
  //declared
  int x, y, w, h, speed;

  Laser (int y, int x) {
    this.x = width; //Start from right side of screen
    this.y = y;
    w = 6;
    h = 12;
    speed = 3; //Initial speed
  }

  void display() {
    //Import a picture for laser
    //Or don't (up to you)          
    fill(255, 0, 0);
    rectMode(CENTER);
    rect(x, y, w, h);
  }

  void move() {
    x -= speed; // Move laser to left side of screen
  }

  boolean reachedLeft() {
    if (x > width + 50) {
      return true;
    } else {
      return false;
    }
  }

  //  boolean intersect(Ball b1) {
  //    float d = dist(x, y, b1.x, b1.y);
  //    if (d < b1.diam/2) {
  //      return true;
  //    } else {
  //      return false;
  //    }
  //  }
}
