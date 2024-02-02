import java.util.Scanner;
import java.util.Random;

class Main {
  // 1. create a print statement to welcome the user to the game
  public static void main(String[] args) {
    System.out.println("Welcome to the game! I am thinking of a number between 1 and 100, what do you think it is?");
    // 2. create a scanner to take in the user's input
    Scanner input = new Scanner(System.in);
    // 3. create a variable to store the user's input
    int userInput = 0;
    // 4. create a variable to store the random number
    Random rand = new Random();
    int randomNumber = rand.nextInt(100) + 1;
    // 5. create a variable to store the amount of iterations
    int iterations = 0;
    // 6. create a while loop that runs until the user's input is equal to the random number
    while (userInput != randomNumber){
      // 7. create conditional statements to check the values
      userInput = input.nextInt();
      if (userInput < randomNumber) {
        System.out.println("Too low! Guess a higher number.");
      } else if (userInput > randomNumber) {
        System.out.println("Too high! Guess a lower number.");
      }
    iterations++;
      }
    // 9. create a print statement to tell the user the amount of iterations
    System.out.println("Number of iterations: " + iterations);
    // 10. create a print statement to tell the user that they won the game
    System.out.println("Congratulations! You won the game!");
    input.close();
  }

  // @Test
  // void addition() {
  // assertEquals(2, 1 + 1);
  // }
}