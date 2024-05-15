//https://studio.processingtogether.com/sp/pad/export/ro.9eDRvB4LRmLrr; GoToLoop

class Button {
  static final int W = 150, H = 50, TXTSZ = 14;
  static final color BTNC = #000000, HOVC = #2C2C2C, TXTC = 0;

  final String label;
  final int x, y, xW, yH;
  color c1;
  int txtc;

  boolean isHovering;

  Button(String txt, int xx, int yy, color c1, int txtc) {
    label = txt;
    x = xx;
    y = yy;
    xW = xx + W;
    yH = yy + H;
    this.c1 = c1;
    this.txtc = txtc;
  }

  void display() {
    stroke(255);
    strokeWeight(1);
    noFill();
    rect(x, y, W, H);

    fill(isHovering ? HOVC : c1);
    rect(x, y, W, H);

    textAlign(CENTER);
    textFont(font2);
    textSize(TXTSZ);
    fill(txtc);
    text(label, x + W/2, y + H/2 + 4);
  }

  boolean isInside() {
    return isHovering = mouseX > x && mouseX < xW && mouseY > y && mouseY < yH;
  }

  boolean checkHover() {
    if (isInside()) {
      isHovering = true;
      return true;
    } else {
      isHovering = false;
      return false;
    }
  }
}
