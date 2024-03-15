//Mads McDougal
class Block {
  int x, y, w, h;
  color c1;

  Block(int x, int y) {
    this.x=x;
    this.y=y;
  }

  void display() {
    rect(x, y, 50, 50);
  }

  boolean intercept(Ball b1) {
    float d =dist(x, y, b1.x, b1.y);
    if (d<b1.w) {
      return true;
    } else {
      return false;
    }
  }

  boolean reachedLeft() {
    if (x <-10) {
      return true;
    } else {
      return false;
    }
  }
}
