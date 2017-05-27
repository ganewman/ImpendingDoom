final Board board = new Board();
final Button playButton = new Button(width / 2, height / 2, 150, 75, "Play!");

boolean gameStarted;
boolean levelRunning;

final color BG = #5C00C6;

void setup() {
  size(700, 700);
  background(BG);
  noStroke();
}


void draw() {
  if (! gameStarted) {
    titleScreen();
  }

  if (playButton.clicked()) {
    gameStarted = true;
    play();
  }
}

void titleScreen() {
  fill(#809B85);
  textSize(50);
  textAlign(CENTER, CENTER);
  text("Tower Defense", width / 2, height / 2 - 120);
  textSize(20);
  text("Gabi Newman + Jeffrey Lin", width / 2, height / 2 - 70);
  playButton.draw();
}

void play() {
  if ( levelRunning ) {

  } else {

  }
}

