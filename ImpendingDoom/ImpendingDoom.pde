import java.util.concurrent.LinkedBlockingQueue;
import java.util.Random;

static PApplet sketchApplet;
static final ImpendingDoom self = new ImpendingDoom();
static final Random prng = new Random();

static Board board;
static Button playButton;

static boolean gameStarted;
static boolean levelRunning = true; // prevent placing during title screen
static boolean levelGenerated;

static final color BG = #5C00C6;
static final int INITIAL_DELAY = 3000;

static int difficulty = 1; // really should be final but oh well // FIXME: set on titlescreen
static int level = 1;
static int playerHealth = 10;
static int delay = INITIAL_DELAY;

static final int NUM_ENEMIES = 4;
static final int NUM_TOWERS = 4;
static final PImage[] enemyImages = new PImage[NUM_ENEMIES];
static final PImage[] towerImages = new PImage[NUM_TOWERS];
static final List<String> enemyList = new ArrayList<String>();
static final List<String> towerList = new ArrayList<String>();

static final LinkedBlockingQueue<Enemy> dqueue = new LinkedBlockingQueue<Enemy>();
static final ArrayList<Float[]> path = new ArrayList<Float[]>();

void setup() {
  sketchApplet = this;

  size(900, 900);
  background(BG);
  noStroke();

  playButton = new Button(width / 2, height / 2, 150, 75, "Play!");

  for ( int i = 0; i < NUM_ENEMIES; i++ ) {
    enemyImages[i] = loadImage("enemy" + (i + 1) + ".png");
    enemyList.add("ImpendingDoom$Enemy" + (i + 1));
  }

  for ( int i = 0; i < NUM_TOWERS; i++ ) {
    towerImages[i] = loadImage("tower" + (i + 1) + ".png");
    towerList.add("ImpendingDoom$Tower" + (i + 1));
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

/** Generates a level.
 * First allocates a "budget" for the level. Enemies are added to the dqueue, with their health
 * values subtracted from the "budget".
 */
void generateLevel() {
  int threshold = level + ceil(random(level / 2, level * 10));

  while ( threshold > 0 ) {
    String className = enemyList.get(prng.nextInt(enemyList.size()));
    Enemy tmp = (Enemy) Utilities.createObject(className, self, delay, path);

    dqueue.add(tmp);
    threshold -= tmp.getHealth();
  }

  levelGenerated = true;
}

void play() {
  if ( playerHealth <= 0 ) {
    System.out.println("GAME OVER JERK");
    exit();
  }

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

