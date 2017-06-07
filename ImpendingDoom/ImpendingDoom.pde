import java.util.concurrent.LinkedBlockingQueue;
import java.util.Random;
import java.util.Hashtable;

static PApplet sketchApplet;
static final ImpendingDoom self = new ImpendingDoom();
static final Random prng = new Random();

static Board board;
static Button playButton;
static Button nextLevel;
static DifficultyButton difficultyButton;
static TowerButton currentTower;

static boolean gameStarted;
static boolean levelRunning = true; // prevent placing during title screen
static boolean levelGenerated;

static int currency;
static int score;

static final color BG = #5C00C6;
static final int INITIAL_DELAY = 3000;

static int difficulty = 2;
static int level = 1;
static int playerHealth = 10;
static int delay = INITIAL_DELAY;

static final int NUM_ENEMIES = 4;
static final int NUM_TOWERS = 4;
static final PImage[] enemyImages = new PImage[NUM_ENEMIES];
static final PImage[] towerImages = new PImage[NUM_TOWERS];
static final List<Enemy> enemyList = new ArrayList<Enemy>();
static final List<Tower> towerList = new ArrayList<Tower>();

static final LinkedBlockingQueue<Enemy> dqueue = new LinkedBlockingQueue<Enemy>();
static final ArrayList<Float[]> path = new ArrayList<Float[]>();

static final Hashtable<String, PFont> fonts = new Hashtable<String, PFont>();

void setup() {
  sketchApplet = this;

  size(900, 900);
  background(BG);
  noStroke();
  textAlign(CENTER, CENTER);

  for ( int i = 0; i < NUM_ENEMIES; i++ ) {
    enemyImages[i] = loadImage("enemy" + (i + 1) + ".png");
    enemyList.add(
        (Enemy) Utilities.createObject("ImpendingDoom$Enemy" + (i + 1), self, delay, path));
  }

  for ( int i = 0; i < NUM_TOWERS; i++ ) {
    towerImages[i] = loadImage("tower" + (i + 1) + ".png");
    towerList.add(
        (Tower) Utilities.createObject("ImpendingDoom$Tower" + (i + 1), self, -1, -1));
  }

  playButton = new Button(width / 2, height / 2, 150, 75, "Play!");
  nextLevel = new Button(75, height - 37.5, 150, 75, "Next Level");
  difficultyButton = new DifficultyButton(width / 2, height / 3 * 2, 150, 75, "Normal");
  currentTower = new TowerButton(width - 75, 75, 150, 150, " ");


  // enemyImages[1] = loadImage("chicken.png");
  generatePath();
  board = new Board(path);
  board.boardMap = new Quadtree(0, 0, width);

  fonts.put("monospace", loadFont("LiberationMono-48.vlw"));
  fonts.put("variable", loadFont("AgencyFB-Reg-48.vlw"));
}

void draw() {
  if ( ! levelGenerated ) {
    generateLevel();
    return;
  }

  fill(#809B85);
  background(BG);

  if ( gameStarted ) {
    if ( playerHealth > 0 ) {
      play();
    } else {
      textSize(50);
      text("GAME OVER", width / 2, height / 2 - 120);
      textSize(20);
      text(String.format("You died on level %s with a final score of %s.", level, score),
          width / 2,
          height / 2 - 70);
    }

    return;
  }

  textSize(50);
  text("Tower Defense", width / 2, height / 2 - 120);
  textSize(20);
  text("Gabi Newman + Jeffrey Lin", width / 2, height / 2 - 70);
  playButton.draw();
  difficultyButton.draw();
}

void placeTowers() {
  Tower t = (Tower) Utilities.createObject(
      Utilities.getName(currentTower.current), self, (float) mouseX, (float) mouseY);
  if ( currency - t.cost < 0 ) {
    return;
  } else {
    board.addTower(t);
    currency -= t.cost;
  }
}

void generatePath() {
  float[] edge1 = Utilities.generateCoordinate(0, 0, width, height);
  float[] edge2 = Utilities.generateCoordinate(0, 0, width, height);

  float dy = (edge2[1] - edge1[1]) / edge2[1];
  float dx = (edge2[0] - edge1[0]) / edge2[0];




  //FIXME: Find a way to programically generate a random path
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
    String className = Utilities.getName(enemyList.get(prng.nextInt(enemyList.size())));
    Enemy tmp = (Enemy) Utilities.createObject(className, self, delay, path);

    dqueue.add(tmp);
    threshold -= tmp.getHealth();
  }

  levelGenerated = true;
}

void play() {
  currentTower.draw();
  board.draw();

  textFont(fonts.get("monospace"));
  textSize(20);
  textAlign(LEFT);
  text(String.format("Level: %10d\nCurrency: %7d\nHealth: %9d\nScore:%11d",
        level, currency, playerHealth, score), 5, 25);
  textAlign(CENTER);
  textFont(fonts.get("variable"));

  if ( ! levelRunning ) {
    textSize(20);
    text("Please select where to place tower", width/2, 40);

    nextLevel.draw();
    currentTower.draw();
    return;
  }

  if ( dqueue.isEmpty() ) {
    if ( board.isEmpty() ) {
      levelRunning = false;
      levelGenerated = false;
      level++;
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
    difficulty = difficultyButton.state;

    switch ( difficulty ) {
      case 1: currency = 500; playerHealth = 100; return;
      case 2: currency = 200; playerHealth =  50; return;
      case 3: currency = 100; playerHealth =  20; return;
    }
  }

  if ( ! levelRunning && nextLevel.clicked() ) {
    levelRunning = true;
    return;
  }

  if ( ! gameStarted ) {
    difficultyButton.clicked();
    return;
  }

  if ( currentTower.clicked() ) {
    return;
  }

  placeTowers();
}

