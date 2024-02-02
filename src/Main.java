// import static org.junit.jupiter.api.Assertions.assertEquals;

// import org.junit.jupiter.api.Test;

class Main {
  public static void main(String[] args) {
    for (int bottles = 99; bottles > 2; bottles = bottles - 1) {
      System.out.println(bottles
          + " bottles of water on the wall, " + bottles + " bottles of water. Take one down and pass it around, "
          + (bottles - 1) + " bottles of water on the wall.");
      System.out.println("\n");
    }
    for (int bottle = 2; bottle > 1; bottle = bottle - 1) {
      System.out.println(bottle
          + " bottles of water on the wall, " + bottle + " bottles of water. Take one down and pass it around, "
          + (bottle - 1) + " bottle of water on the wall.");
      System.out.println("\n");
    }
    for (int bottle = 1; bottle > 0; bottle = bottle - 1) {
      System.out.println(bottle
          + " bottle of water on the wall, " + bottle + " bottle of water. Take one down and pass it around, "
          + (bottle - 1) + " bottles of water on the wall.");
      System.out.println("\n");
    }
  }
}
