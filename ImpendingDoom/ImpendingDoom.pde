import java.util.concurrent.LinkedBlockingQueue;

Board board;
Button playButton;

boolean gameStarted;
boolean levelRunning = true; // prevent placing during title screen
boolean levelGenerated;
int level = 1;

final color BG = #5C00C6;
final int INITIAL_SPEED = 3000;

static final PImage[] enemyImages = new PImage[4];
static final PImage[] towerImages = new PImage[4];
final LinkedBlockingQueue<Enemy> dqueue = new LinkedBlockingQueue<Enemy>();

final ArrayList<Float[]> path = new ArrayList<Float[]>();

void setup() {
  size(900, 900);
  background(BG);
  noStroke();

  playButton = new Button(width / 2, height / 2, 150, 75, "Play!");

  for ( int i = 0; i < enemyImages.length; i++ ) {
    enemyImages[i] = loadImage("enemy" + (i + 1) + ".png");
  }

  for ( int i = 0; i < towerImages.length; i++ ) {
    towerImages[i] = loadImage("tower" + (i + 1) + ".png");
  }

  // enemyImages[1] = loadImage("chicken.png");
  generatePath();
  board = new Board(path);
  board.boardMap = new Quadtree(0, 0, width);
}

void draw() {
  if ( ! levelGenerated ) {
    generateLevel();
    return;
  }

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

void generatePath() {
    //FIXME: Find a way to programically generate a random path
  float[] edge1 = new float[] {0, 0};
  float[] edge2 = new float[] {900, 900};
  float dy = (edge2[1] - edge1[1]) / edge2[1];
  float dx = (edge2[0] - edge1[0]) / edge2[0];

  for ( int i = 0; i < 900; i++ ) {
    path.add(new Float[] {edge1[0] + (dx * i), edge1[1] + (dy * i)});
  }
}

void generateLevel() {
  for ( int i = 0; i < level * random(level / 5, level * 2); i++ ) {
    // FIXME: Find a way to add different enemies based on level.
    dqueue.add(new Enemy1(INITIAL_SPEED / level, path));
  }

  levelGenerated = true;
}

void play() {
  board.draw();

  if ( ! levelRunning ) {
    placeTowers();
    return;
  }

  if ( dqueue.isEmpty() ) {
    if ( board.isEmpty() ) {
      levelRunning = false;
      levelGenerated = false;
      return;
    }

    board.update();
  } else {
    Enemy tmp = dqueue.peek();
    tmp.startDelay();

    if ( tmp.timeLeft() < 0 ) {
      board.addEnemy(dqueue.poll());
    }
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
    Tower t = new Tower1((float)mouseX, (float)mouseY);
    board.addTower(t);
    levelRunning = true;
    return;
  }
}

