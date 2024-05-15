//Sarah Zhang | Monday, March 18th, 2024 | Individual Project
//https://studio.processingtogether.com/sp/pad/export/ro.9eDRvB4LRmLrr; GoToLoop

import java.util.Calendar; //Import Calendar for date manipulation

static final int MAX = 6, GAP = 50, DIM = 120, RAD = DIM >> 1;
int page, cx, cy;
PFont font1, font2;

Button back, next, app1, app2, app3, app4, app5, app6;

// GLobal variables
boolean showInstructions = false;
Button instructions;

float secondsRadius;
float minutesRadius;
float hoursRadius;
float clockDiameter;

float oldX;
float oldY;
color redC = color(240, 111, 128);
color greenC = color(0, 77, 12);
color blueC = color(2, 51, 155);
color yellow = color(240, 237, 143);
color orange = color(240, 210, 111);
color violet = color(199, 143, 240);
color blueGreen = color(187, 234, 209);
color yellowGreen = color(201, 234, 187);
color pink = color(240, 143, 185);
color lightBlue = color(166, 229, 252);
color white = color(255);
color black = color(0);
float masterStroke = 1;
float pmouseX, pmouseY;
boolean isMousePressed = false;
ArrayList<PVector> lines = new ArrayList<PVector>(); // Array to store drawn lines
boolean drawingStarted = false;
color selectedColor = white; // Default Color

int numBalls = 18;
float spring = 0.08;
float gravity = 0.05;
float friction = -1;
Ball[] balls = new Ball[numBalls];

int secret_num;
String Number = "";
String feedback = "";

void setup() {
  size(600, 400);
  font1 = loadFont("CourierNewPS-BoldMT-48.vlw");
  font2 = loadFont("ComicSansMS-48.vlw");

  //Page Setup
  noLoop();
  smooth();

  stroke(255);
  strokeWeight(1.5);

  cx = width  >> 1;
  cy = height >> 1;

  back = new Button("BACK", GAP, height - Button.H - GAP + 20, 0, 255);
  next = new Button("NEXT", width - Button.W - GAP, height - Button.H - GAP + 20, 0, 255);

  app1 = new Button("Clock", 68, 190, #F29292, 0);
  app2 = new Button("Continuous Drawing", width/2 - 75, 190, #FFD2A8, 0); //Draw
  app3 = new Button("Random Bubbles", 382, 190, #FFF4BD, 0);
  app4 = new Button("Guess the Number", 68, 250, #BEE9CB, 0);
  app5 = new Button("896 Digits of Pi", width/2 - 75, 250, #AAD4EE, 0);
  app6 = new Button("App 6", 382, 250, #D8C7FF, 0);

  //Clock:
  float radius = min(width, height) / 2.75;
  secondsRadius = radius * 0.72;
  minutesRadius = radius * 0.60;
  hoursRadius = radius * 0.50;
  clockDiameter = radius * 1.8;

  cx = width / 2;
  cy = height / 2;

  //Ball
  for (int i = 0; i < numBalls; i++) {
    balls[i] = new Ball(random(width), random(height), random(30, 70), i, balls);
  }
  noStroke();
  fill(255, 204);

  //GuessNum
  if (page == 4) {
    textAlign(CENTER);
    //textFont(createFont("Georgia", 17));
    background(255);
  }

  // Random number generation
  secret_num = int(random(1, 101)); // Generate a random number between 1 and 100
  println("Secret Number is  " + secret_num);
}

void draw() {
  background(0);

  textAlign(CENTER);
  textFont(font2);
  textSize(16);
  fill(250);
  text("Page #" + page, width/2, 380);

  textSize(Button.TXTSZ);
  if (page > 0)    back.display();
  if (page < MAX)  next.display();
  if (page < 1)    app1.display();
  if (page < 1)    app2.display();
  if (page < 1)    app3.display();
  if (page < 1)    app4.display();
  if (page < 1)    app5.display();
  if (page < 1)    app6.display();

  //method("page" + page); // Works on Java Mode only!
  pageSelector();        // Workaround for PJS. But works on Java Mode as well!


  if (page == 0) {
    instructions.checkHover();
    if (showInstructions) {
      showInstructions();
    } else {
      instructions = new Button("Instructions", GAP, height - Button.H - GAP + 20, color(100), color(255));
      instructions.display();
    }
  } else {
    instructions = null; // Clear the button when not on page 0
  }

  // Update the Screen?
  redraw();

  // Draw lines
  if (page == 2 && isMousePressed) {
    if (mouseX > 60 && mouseX < width - 20 && mouseY > 10 && mouseY < height - 10) {
      line(mouseX, mouseY, pmouseX, pmouseY);
    }
  }
}

void mousePressed() {
  if (showInstructions) {
    // If instructions are displayed, only respond to clicks on the back button
    if (back.isHovering) {
      println("Back button clicked!");
      // Hide instructions and return to main screen
      showInstructions = false;
      page = 0;
    }
    return; // Exit the function early to prevent further processing
  }

  if (page > 0 && back.isHovering) {
    --page;
  } else if (page < MAX && next.isHovering) {
    ++page;
  } else if (page < 1 && app1.isHovering) {
    ++page;
  } else if (page < 1 && app2.isHovering) {
    page = 2;
  } else if (page < 1 && app3.isHovering) {
    page = 3;
  } else if (page < 1 && app4.isHovering) {
    page = 4;
  } else if (page < 1 && app5.isHovering) {
    page = 5;
  } else if (page < 1 && app6.isHovering) {
    page = 6;
  }

  // Check if the instructions button is clicked
  if (page == 0 && instructions.isInside()) {
    println("Button clicked!");
    // Show instructions
    showInstructions = true;
  }

  redraw();

  isMousePressed = true;

  if (page == 2 && mouseX > 60 && mouseX < width - 10 && mouseY > 10 && mouseY < height - 10) {
    drawingStarted = true;
  }
}

void mouseReleased() {
  isMousePressed = false;
  drawingStarted = false;
}

void mouseMoved() {
  back.isInside();
  next.isInside();
  app1.isInside();
  app2.isInside();
  app3.isInside();
  app4.isInside();
  app5.isInside();
  app6.isInside();

  redraw();

  //Update Mouse
  if (isMousePressed) {
    pmouseX = mouseX;
    pmouseY = mouseY;
  }
}

void showInstructions() {
  background(0);
  textAlign(CENTER);
  fill(255);
  textSize(20);
  text("Instructions:", width/2, 40);

  textSize(14);
  textAlign(CENTER);
  text("Welcome to 'MindScape Hub'!", width/2, 80);
  text("This is an application filled with a bunch of different random programs!", width/2, 100);
  text("Feel free to look around and explore!", width/2, 130);
  text("Clicking on the 'BACK' button, will take you back to the home page \n where you can click on any of the 6 app buttons or the 'NEXT' button, \n to start your journey and exploration!", width/2, 150);
  
  text("A Brief Summary of Each App as Displayed on the Buttons:", width/2, 220);
  textSize(10);
  text("Clock App: Displays the current time and date. \n Continuous Drawing: Use the mouse to draw continuously on the canvas. Select colors \n from the palette on the left. \n Random Bubbles: Watch the bubbles bounce around the screen. \n Guess the Number: Try to guess the random number between 1 and 100. \n 896 Digits of Pi: Displays the first 896 digits of Pi.", width/2, 240);
  
  // Display back button
  back.display();

  println("Showing instructions!");
}


void page0() {
  textAlign(CENTER);

  fill(250);
  textFont(font1);
  textSize(42);
  text("MindScape Hub", width/2, 120);
  textFont(font2);
  textSize(20);
  text("by Sarah Zhang", width/2, 150);
  text("(Period 2A)", width/2, 170);
  textAlign(CENTER);

  // Recreate the instructions button if it's null
  if (instructions == null) {
    instructions = new Button("Instructions", width/2 - 75, 130, color(100), color(255));
  }
}

void page1() {
  fill(80);
  noStroke();
  ellipse(cx, cy - 20, clockDiameter, clockDiameter);

  // Angles for sin() and cos() start at 3 o'clock;
  // subtract HALF_PI to make them start at the top
  float s = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;
  float m = map(minute() + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI;
  float h = map(hour() + norm(minute(), 0, 60), 0, 24, 0, TWO_PI * 2) - HALF_PI;

  // Draw the hands of the clock
  stroke(255);
  strokeWeight(1);
  line(cx, cy - 20, cx + cos(s) * secondsRadius, cy + sin(s) * secondsRadius - 20);
  strokeWeight(2);
  line(cx, cy - 20, cx + cos(m) * minutesRadius, cy + sin(m) * minutesRadius);
  strokeWeight(4);
  line(cx, cy - 20, cx + cos(h) * hoursRadius, cy + sin(h) * hoursRadius);

  // Draw the minute ticks
  strokeWeight(2);
  beginShape(POINTS);
  for (int a = 0; a < 360; a+=6) {
    float angle = radians(a);
    float x = cx + cos(angle) * secondsRadius;
    float y = cy - 20 + sin(angle) * secondsRadius;
    vertex(x, y);
  }
  endShape();

  // Get the current date and time
  String currentTime = nf(hour(), 2) + ":" + nf(minute(), 2) + ":" + nf(second(), 2);

  // Get the current date and day of the week
  Calendar cal = Calendar.getInstance();
  String[] daysOfWeek = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
  String[] months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};

  String dayOfWeek = daysOfWeek[cal.get(Calendar.DAY_OF_WEEK) - 1];
  String month = months[cal.get(Calendar.MONTH)];
  int day = cal.get(Calendar.DAY_OF_MONTH);
  int year = cal.get(Calendar.YEAR);

  // Format the date string
  String suffix = "th";
  if (day == 1 || day == 21 || day == 31) {
    suffix = "st";
  } else if (day == 2 || day == 22) {
    suffix = "nd";
  } else if (day == 3 || day == 23) {
    suffix = "rd";
  }
  String currentDate = dayOfWeek + ", " + month + " " + day + suffix + ", " + year;

  // Display the current date and time in the top right corner
  textAlign(RIGHT, TOP);
  textSize(16);
  fill(255);
  text(currentDate, width - 10, 10); // Adjust the x and y position as needed
  text(currentTime, width - 10, 30); // Adjust the y position to be below the date
}

void mouseDragged() {
  // Store the coordinates of the line being drawn
  if (drawingStarted) {
    PVector start = new PVector(pmouseX, pmouseY);
    PVector end = new PVector(mouseX, mouseY);
    lines.add(start);
    lines.add(end);
  }
  // Update previous mouse position
  pmouseX = mouseX;
  pmouseY = mouseY;
}

void page2() {
  strokeWeight(1);
  fill(redC);
  rect(10, 10, 25, 25);
  fill(blueC);
  rect(35, 10, 25, 25);
  fill(greenC);
  rect(10, 35, 25, 25);
  fill(yellow);
  rect(35, 35, 25, 25);
  fill(orange);
  rect(10, 60, 25, 25);
  fill(violet);
  rect(35, 60, 25, 25);
  fill(blueGreen);
  rect(10, 85, 25, 25);
  fill(yellowGreen);
  rect(35, 85, 25, 25);
  fill(pink);
  rect(10, 110, 25, 25);
  fill(lightBlue);
  rect(35, 110, 25, 25);
  fill(white);
  rect(10, 135, 25, 25);
  fill(black);
  rect(35, 135, 25, 25);

  //Stroke size controls
  //line(450, 30, 500, 30);
  //strokeWeight(4);
  //line(450, 50, 500, 50);
  //strokeWeight(8);
  //line(450, 80, 500, 80);
  //strokeWeight(1);

  // Clear button
  fill(255);
  rect(250, 10, 50, 50);

  // Drawings
  stroke(selectedColor);
  for (int i = 0; i < lines.size(); i += 2) {
    PVector start = lines.get(i);
    PVector end = lines.get(i + 1);
    line(start.x, start.y, end.x, end.y);
  }

  // Handle mouse interactions
  handleColorPalette();
  handleStrokeSizeControls();
  handleClearButton();
}

// Handle mouse interaction for color palette
void handleColorPalette() {
  // Check if the mouse is pressed
  if (mousePressed) {
    // Check if the mouse is within the bounds of the color palette
    if (mouseX > 10 && mouseY < 160) {
      if (mouseX > 10 && mouseX < 35) {
        if (mouseY > 10 && mouseY < 35) {
          selectedColor = redC;
        } else if (mouseY > 35 && mouseY < 60) {
          selectedColor = greenC;
        } else if (mouseY > 60 && mouseY < 85) {
          selectedColor = orange;
        } else if (mouseY > 85 && mouseY < 110) {
          selectedColor = blueGreen;
        } else if (mouseY > 110 && mouseY < 135) {
          selectedColor = pink;
        } else if (mouseY > 135 && mouseY < 160) {
          selectedColor = white;
        }
      }
      if (mouseX > 35 && mouseX < 60) {
        if (mouseY > 10 && mouseY < 35) {
          selectedColor = blueC;
        } else if (mouseY > 35 && mouseY < 60) {
          selectedColor = yellow;
        } else if (mouseY > 60 && mouseY < 85) {
          selectedColor = violet;
        } else if (mouseY > 85 && mouseY < 110) {
          selectedColor = yellowGreen;
        } else if (mouseY > 110 && mouseY < 135) {
          selectedColor = lightBlue;
        } else if (mouseY > 135 && mouseY < 160) {
          selectedColor = black;
        }
      }
    }
  }
}

// Handle mouse interaction for stroke size controls
void handleStrokeSizeControls() {
  //if (mousePressed) {
  //  if (mouseX > 450 && mouseX < 500) {
  //    if (mouseY == 30) {
  //      masterStroke = 1;
  //    } else if (mouseY == 50) {
  //      masterStroke = 4;
  //    } else if (mouseY == 80) {
  //      masterStroke = 7;
  //    }
  //  }
  //  //strokeWeight(masterStroke);
  //}
}

// Handle mouse interaction for clear button
void handleClearButton() {
  if (mousePressed) {
    if (mouseX > 250 && mouseX < 300) {
      if (mouseY > 10 && mouseY < 60) {
        lines.clear(); // Clear the lines array
      }
    }
  }
}

void page3() {
  //background(0);
  for (Ball ball : balls) {
    ball.collide();
    ball.move();
    ball.display();
  }
}

void keyPressed() {
  if (page == 4) { // Only capture keyboard input when page 4 is active
    if (keyCode == ENTER || keyCode == RETURN || key == '\n') {
      int guess = parseInt(Number); // Convert the user's input to an integer

      if (guess == secret_num) {
        feedback = "Correct!! You got me this time! Well done!!";
      } else if (guess > secret_num) {
        feedback = "Wrong!! HAHA! Your going to have to try a smaller number!!";
      } else {
        feedback = "Wrong!! HAHA! Your going to have to try a bigger number!!";
      }

      Number = ""; // Clear the input box after each guess
    } else if (keyCode >= '0' && keyCode <= '9') {
      Number += key; // Append the digit to the input
    }
  }
}

void page4() {
  textAlign(CENTER);
  fill(255);
  text("I'm Thinking of a number between 1-100 can you guess what it is? \nYou have an unlimited amount of guesses,", width/2, 50);
  text("But you better start thinking ;D", width/2, 90);
  text("Enter what you think it is into this box", width/2, 220); // Adjusted text position
  rect(400, 250, 100, 30); // Adjusted textbox position
  fill(0); // Set text color to black
  text(Number, 450, 270); // Adjusted text position
  fill(255); // Set text color back to white
  text(feedback, width/2, 300); // Adjusted text position
}

void page5() {
  textAlign(CENTER); // Align text to the center
  fill(255);
  text(" 896 Digits of Pi", width / 2, 25); // Centered position

  String piDigits = "3.14159265358979323846264338327950288419716939937510582097494459230781640628620899862803482534211706798214808651328230664709384460955058223172535940812848111745028410270193852110555964462294895493038196442881097566593344612847564823378678316527120190914564856692346034861045432664821339360726024914127372458700660631558817488152092096282925409171536436789259036001133053054882046652138414695194151160943305727036575959195309218611738193261179310511854807446237996274956735188575272489122793818301194912983367336244065664308602139494639522473719070217986094370277053921717629317675238467481846766940513200056812714526356082778577134275778960917363717872146844090122495343014654958537105079227968925892354201995611212902196086403441815981362977477130996051870721134999999837297804995105973173281609631859502445945534690830264252230825334468503526193118817101000313783875288658753320838142061717766914..."; // Add more digits as needed

  textSize(13); // Adjust text size
  int x = 20; // Adjusted starting x position
  int y = 50;
  int maxWidth = width - 20; // Adjusted maximum width to accommodate margins
  int spacing = 20;
  // Loop through each digit in the piDigits string
  for (int i = 0; i < piDigits.length(); i++) {
    char digit = piDigits.charAt(i);
    if (digit == '.') {
      text(".", x, y);
      x += textWidth(".") + 5; // Adjusted spacing after decimal point
    } else {
      // Exclude rendering on buttons and page number area
      if (!((x >= back.x && x <= back.x + Button.W + 5 && y >= back.y && y <= back.y + Button.H + 7) ||
        (x >= next.x && x <= next.x + Button.W + 3 && y >= next.y && y <= next.y + Button.H) ||
        (x >= width / 2 - 40 && x <= width / 2 + 40 && y >= 360 && y <= 400))) {
        text(digit, x, y);
      }
      x += textWidth(digit) + 1.5; // Adjusted spacing between digits
    }
    if (x > maxWidth) {
      x = 20; // Reset x position for new line
      y += spacing; // Move to the next line
    }
  }
}


void page6() {
}

void pageSelector() { // Replaces method("") for PJS
  switch(page) {
  case 0:
    page0();
    break;

  case 1:
    page1();
    break;

  case 2:
    page2();
    break;

  case 3:
    page3();
    break;

  case 4:
    page4();
    break;

  case 5:
    page5();
    break;

  case 6:
    page6();
    break;
  }
}
