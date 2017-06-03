import java.util.concurrent.LinkedBlockingQueue;

Board board = new Board();
Button playButton;

boolean gameStarted;
boolean levelRunning = true; // prevent placing during title screen
int level = 1;

final color BG = #5C00C6;
final int INITIAL_SPEED = 3000;

static final PImage[] enemyImages = new PImage[4];
static final PImage[] towerImages = new PImage[4];
final LinkedBlockingQueue<Enemy> dqueue = new LinkedBlockingQueue<Enemy>();

void setup() {
  size(900, 900);
  background(BG);
  noStroke();
  board.boardMap = new Quadtree(0, 0, width);
  playButton = new Button(width / 2, height / 2, 150, 75, "Play!");

  for ( int i = 0; i < enemyImages.length; i++ ) {
    enemyImages[i] = loadImage("enemy" + (i + 1) + ".png");
  }

  for ( int i = 0; i < towerImages.length; i++ ) {
    towerImages[i] = loadImage("tower" + (i + 1) + ".png");
  }

  // enemyImages[1] = loadImage("chicken.png");
}


void draw() {
  if ( gameStarted ) {
    play();
  } else {
    titleScreen();
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
}

void generateQueue() {
  for ( int i = 0; i < level * random(level / 5, level * 2); i++ ) {
    // FIXME: Find a way to add different enemies based on level.
    dqueue.add(new EnemyA(INITIAL_SPEED / level));
  }
}

void play() {
  board.draw();
  if ( levelRunning ) {
    Enemy tmp = dqueue.peek();
    tmp.startDelay();
    if ( tmp.timeLeft() < 0 ) {
      board.addEnemy(dqueue.poll());
    }

    if ( dqueue.isEmpty() && board.isEmpty() ) {
      levelRunning = false;
    }
    if ( board.enemiesOnBoard != null ) { board.update(); }
  } else {
    generateQueue();
    placeTowers();
  }
}

void mousePressed() {

  if ( playButton.clicked() ) {
    gameStarted = true;
    levelRunning = false;
    return;
  }
  if ( ! levelRunning ) {
    // give the user a chance to place towers
    Tower t = new TowerA((float)mouseX, (float)mouseY);
    board.addTower(t);
    levelRunning = true;
    return;
  }
}
