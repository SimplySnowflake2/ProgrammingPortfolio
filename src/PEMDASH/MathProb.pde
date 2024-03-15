//Sarah Zhang
class MathProb {
  int num1, num2, answer, answerInput;
  int result;ss
  //String winMessage, loseMessage;

  MathProb(int x, int y) {
    int num1 = int(random(25));
    int num2 = int(random(25));
    int answer = num1 * num2;

    println("Answer: " + answer);
    if (answerInput == result) {
      println(winMessage);
    } else {
      println(loseMessage);
    }
  }

  void display() {
    fill(255, 0, 0);
    rectMode(CENTER);
    rect(100, 100, 500, 200);
  }

  //Win Messages
  String[] winMessage = {"Correct!", "Oh yeah, that's right!", "Your math is good", "Cool!"};
  String[] loseMessage = {"nope", "no", "try again", "sorry! thats wrong"};
}
