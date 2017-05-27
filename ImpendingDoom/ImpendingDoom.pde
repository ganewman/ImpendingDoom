
final Board board = new Board();
Button playButton;
boolean gameStarted = false;

void setup() {
  size(700, 700);
  background(#5C00C6);
  noStroke();
  playButton = new Button(width / 2, height / 2, 150, 75, "Play!");
}


void draw() {
  if (! gameStarted) { 
    titleScreen();
  }
  if (playButton.clicked()){
    gameStarted = true;
    background(0);
  }
}

void titleScreen() {
  String s = "Tower Defense";
  fill(#809B85);
  textSize(50);
  textAlign(CENTER, CENTER);
  text(s, width / 2, height / 2 - 120);
  textSize(20);
  text("Gabi Newman + Jeffrey Lin", width / 2, height / 2 - 70);
  playButton.draw();
}