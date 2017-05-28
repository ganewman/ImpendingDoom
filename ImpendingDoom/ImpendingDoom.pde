Board board;
Button playButton;

boolean gameStarted;
boolean levelRunning;

final color BG = #5C00C6;

PImage[] enemyImages = new PImage[2];
PImage[] towerImages = new PImage[2];

void setup() {
  size(900, 900);
  background(BG);
  noStroke();
  playButton = new Button(width / 2, height / 2, 150, 75, "Play!");

  enemyImages[0] = loadImage("enemy.png");
  enemyImages[1] = loadImage("chicken.png");
  towerImages[0] = loadImage("tower.png");
  board = new Board(enemyImages, towerImages);
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

void placeTowers() {
  textAlign(RIGHT, BOTTOM);
  textSize(20);
  text("Please select where to place tower", width/2, 40);
  if (mousePressed) {
    TowerA t = new TowerA((float)mouseX, (float)mouseY, towerImages[0]);
    board.addTower(t); 
    levelRunning = true;
  }
}

void play() {
  board.draw();
  if (! levelRunning) {
    delay(200);
    placeTowers();
  }
}