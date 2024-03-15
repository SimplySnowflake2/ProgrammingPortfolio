//Jenna Tran and Sarah Zhang
class PowUp {
  int x, y, diam, val, speed;
  PImage powup;
  char type;

  PowUp (int x, int y) {
    this.x = x;
    this.y = y;
    diam = 64;
    speed = 5;
    // Randomize Power Ups Here:
    int rand = int(random(2));
    if (rand == 0) {
      //Aayush Silwal
      //powup = loadImage("(AS)TimePowerup.png");
      powup = loadImage("(JT)Clock.png");
      type = 't';
      val = 10;
    } else {
      //powup = loadImage("(AS)Skippowerup.png");
      powup = loadImage("(AS)updatedSkippowerup.png");
      type = 's';
      val = 1;
    }
  }

  //Sarah Zhang
  void display() {
    imageMode(CENTER);
    powup.resize(diam, diam);
    image(powup, x, y);
  }

  void move() {
    x -= speed;
  }

  //Sarah Zhang
  boolean reachedLeft() {
    if (x > width + 50) {
      return true;
    } else {
      return false;
    }
  }
}
