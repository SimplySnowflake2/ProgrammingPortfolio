//Jenna Tran and Sarah Zhang
class Spike {
  int x, y, diam, health, speed;
  PImage spike;

  Spike(int x, int y) {
    this.x = x;
    this.y = y;
    diam = 64;
    //speed = int(random(1, 7));
    speed = 10;
    //spike = loadImage("(SZ)Spike.png");
    spike = loadImage("(JT)Spike2.png");
  }

  void display() {
    imageMode(CENTER);
    spike.resize(diam, diam);
    image(spike, x, y);
  }

  void move() {
    x -= speed;
  }

  boolean reachedLeft() {
    if (x < - 64) {
      return true;
    } else {
      return false;
    }
  }
}
