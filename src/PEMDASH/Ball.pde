//Sarah Zhang and Jenna Tran
class Ball {
  int x, y, w, health, lives;
  PImage ball;
  Timer jumpTimer;
  float jumpSpeed = -10;
  float gravity = 0.5;
  boolean isJumping = false;
  boolean maxJump = false;

  Ball(int x, int y) {
    this.x = x;
    this.y = y;
    w = 50;
    health = 100;
    ball = loadImage("(MM)Ball.png");
    //jumpTimer = new Timer(100);
  }

  void display() {
    imageMode(CENTER);
    ball.resize(w, w);
    image(ball, x, y);
  }

  void jump() {
    if (keyPressed) {
      //keyCodes 32, 38, 87, and ' '
      y += jumpSpeed;
      maxJump = true;
    } else {
      y = 250;
    }
  }

  void applyGravity() {
    while (!play) {
      if (maxJump) {
        //jumpSpeed -= gravity;
        y = 250;
      } else {
        isJumping = false;
      }
    }
  }

  boolean intersectPU(PowUp pu) {
    float d = dist(x, y, pu.x, pu.y);
    if (d < pu.diam/2) {
      return true;
    } else {
      return false;
    }
  }

  boolean intersect(Spike s) {
    float d = dist(x, y, s.x, s.y);
    if (d < s.diam/2) {
      return true;
    } else {
      return false;
    }
  }
}
