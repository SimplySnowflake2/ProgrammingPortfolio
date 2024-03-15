// Mads McDougal, Sarah Zhang, Aayush Silwal, and Jenna Tran
// Friday, February 23rd, 2024 | PEMDASH Group Project

PImage startScreen;
PImage mainScreen;
//PImage endScreen;

//Jenna Tran and Sarah Zhang
Ball b1;
ArrayList<Spike> spikes = new ArrayList<Spike>();
//ArrayList<Laser> lasers = new ArrayList<Laser>();
//ArrayList<Block> block s = new ArrayList<Block>();
ArrayList<PowUp> powups = new ArrayList<PowUp>();
ArrayList<MathProb> question = new ArrayList<MathProb>();
int x, y; // Global Variable
int w, h;
int score;
int level;
boolean play;
Timer spikeTimer, puTimer, quesTimer;
int time;
int wait = 1000;

//Sarah Zhang
void setup() {
  size (600, 300);
  score = 0;
  play = false;
  b1 = new Ball(50, height - 50);
  puTimer = new Timer(10000);
  puTimer.start();
  spikeTimer = new Timer (1500);
  spikeTimer.start();
  quesTimer = new Timer (15000);
  quesTimer.start();
  //Mads McDougal
  startScreen = loadImage("(MM)startscreen.png");
  mainScreen = loadImage("(MM)SceneA.png");
  w = 1800;
  h = 900;
}

//Sarah Zhang
void draw() {
  if (!play) {
    startScreen();
  } else {
    //Jenna Tran
    background (186, 203, 226);
    //Mads McDougal
    image(mainScreen, 0, 0);
    mainScreen.resize(w, h);
    noCursor();
    time = (millis()/1000); //store the current time

    //Sarah Zhang
    //Render Scoreboard
    infoPanel();

    //Sarah Zhang
    //Implementing a Time Function
    //check the difference between now and the previously stored time is greater than the wait interval
    if (millis() - time >= wait) {
      println("tick"); //if it is, do something
      time = (millis()/1000); //also update the stored time
    }

    //Jenna Tran and Sarah Zhang
    //Adding Spikes
    if (spikeTimer.isFinished()) {
      spikes.add(new Spike(650, int(random(230, 270))));
      spikeTimer.start();
    }

    //Rendering Spikes
    for (int i = 0; i < spikes.size(); i++) {
      Spike s = spikes.get(i);
      if (b1.intersect(s)) {
        b1.health -= s.diam/10;
        score -= s.diam;
        spikes.remove(s);
      }
      if (s.reachedLeft()) {
        score += 64;
        spikes.remove(s);
      } else {
        s.display();
        s.move();
        //score += 10;
      }
    }

    //Mads McDougal
    //adding blocks
    //for (int i = 0; i < blocks.size(); i++) {
    //  Block b = blocks.get(i);
    //  if (b.reachedSide()) {
    //    blocks.remove(b);
    //  } else {

    //    b.display();
    //  }
    //}

    // Jenna Tran
    // Adding + Distributing Power Ups
    if (puTimer.isFinished()) {
      powups.add(new PowUp(650, 175));
      puTimer.start();
    }

    // Rendering Power Ups
    for (int i = 0; i < powups.size(); i++) {
      PowUp pu = powups.get(i);
      if (b1.intersectPU(pu)) {
        if (pu.type == 't') {
          //b1.time -= pu.val;
        } else if (pu.type == 's') {
          //b1.skips += pu.val;
        }
        powups.remove(pu);
      }

      if (pu.reachedLeft()) {
        powups.remove(pu);
        score -= pu.diam;
      } else {
        pu.display();
        pu.move();
      }
    }

    //Sarah Zhang
    //Adding Math Questions
    if (quesTimer.isFinished()) {
      question.add(new MathProb(width/2, height/2));
      quesTimer.start();
    }
    
    // Display Math Questions
    //[STUFF HERE]

    //Jenna Tran and Sarah Zhang
    //Rendering Ball
    b1.display();

    //Allowing a Jump Feature for the Ball
    b1.applyGravity();
    b1.jump();
    //b1.draw();
  }

  if (b1.health < 0 || score < - 640 || time > 100) {
    gameOver();
  }
}


//Sarah Zhang and Jenna Tran
void infoPanel() {
  fill(104, 34, 139);
  rect(0, 0, 600, 50);
  fill(180, 145, 197);
  //rect(0, 50, 100, 30);
  textSize(20);
  fill(255);
  text("Score: " + score, 35, 30);
  text("Time: " + time, width/2 - 30, 30); // change to time later
  text("Health: " + b1.health, width - 125, 30);
  textSize(16);
  fill(0);
  //text ("Skips: " + b1.skips, 25, 70);
  println("spikes: " + spikes.size());
  //println("l:" + l);
  //println("r:" + r);
  //println("op:" + op);
  //println("result:" + result);
}

//Jenna Tran, Sarah Zhang, and Mads McDougal
void startScreen() {
  image(startScreen, 0, 0);
  time = (millis()/1000); //store the current time
  //background(#9BDDFF);
  //fill(255);
  ////size(500, 100);
  //fill(0, 100, 0);
  //rect(0, 240, 600, 60);
  //fill(#878B8E);
  //rect(width/2 - 65, height/2 + 50, 130, 20);
  //triangle(80, 240, 120, 240, 100, 205);
  //triangle(140, 240, 180, 240, 160, 205);
  //triangle(420, 240, 460, 240, 440, 205);
  //triangle(480, 240, 520, 240, 500, 205);
  //fill(#2079A7);
  //circle(330, 185, 30);
  //fill(255);
  //textAlign(CENTER);
  //textSize(60);
  //text("PEM-DASH", width/2, 80);
  //textSize(28);
  //text("Start Game", width/2, 120);
  //textSize(20);
  //text("Click or Press Key to Begin...", width/2, 160);
  if (mousePressed || keyPressed) {
    play = true;
  }
}

//Sarah Zhang
//void instructions() {
//  background(0);
//  fill(255);
//  textAlign(CENTER);
//  textSize(18);
//  text("Instructions!:", width/2, 75);
//  text("", width/2, 125);
//  text("", width/2, 125);
//  text("Click ANY Key to Officially Begin the Game", width/2, 175);
//  if (keyPressed) {
//    play = true;
//  }
//}

//Sarah Zhang
void gameOver() {
  background(0);
  fill(255);
  textAlign(CENTER);
  textSize(40);
  text("Game Over", width/2, 75);
  text("Score: " + score, width/2, 125);
  text("Time: " + time, width/2, 175);
  noLoop();
}

//Sarah Zhang
void mousePressed() {
}

//Sarah Zhang
void keyPressed() {
  println("key:" + key);
  println("keyCode" + keyCode);
  //if (keyPressed && key == ' ') {
  //  b1.jump();
  //  b1.jumpTimer.start();
  //}
}
