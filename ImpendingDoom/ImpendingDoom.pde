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

static int difficulty;
static int level = 1;
static int playerHealth = 10;
static int delay = INITIAL_DELAY;

static final List<PImage> enemyImages = new ArrayList<PImage>();
static final List<PImage> towerImages = new ArrayList<PImage>();
static final List<Enemy> enemyList = new ArrayList<Enemy>();
static final List<Tower> towerList = new ArrayList<Tower>();

static final LinkedBlockingQueue<Enemy> dqueue = new LinkedBlockingQueue<Enemy>();
static final ArrayList<Float[]> path = new ArrayList<Float[]>();

static final Hashtable<String, PFont> fonts = new Hashtable<String, PFont>();

void loadDefaults() {
  background(BG);
  noStroke();
  textAlign(CENTER, CENTER);
}

void setup() {
  sketchApplet = this;
  size(900, 900);

  loadDefaults();


  // initialize master image and object lists
  // generic exception because we just want to load as many as possible
  // Processing does not throw an Exception when the image doesn't exist
  for ( int i = 1; ; i++ ) {
    try {
      PImage tmp = loadImage("enemy" + i + ".png");
      if ( tmp == null ) { break; }

      enemyImages.add(tmp);
      enemyList.add((Enemy) Utilities.createObject("ImpendingDoom$Enemy" + i, self, delay));
    } catch ( Exception e ) {
      break;
    }
  }

  for ( int i = 1; ; i++ ) {
    try {
      PImage tmp = loadImage("tower" + i + ".png");
      if ( tmp == null ) { break; }

      towerImages.add(tmp);
      towerList.add((Tower) Utilities.createObject("ImpendingDoom$Tower" + i, self, -1, -1));
    } catch ( Exception e ) {
      break;
    }
  }

  playButton = new Button(width / 2, height / 2, 150, 75, "Play!");
  nextLevel = new Button(75, height - 37.5, 150, 75, "Next Level");
  difficultyButton = new DifficultyButton(width / 2, height / 3 * 2, 150, 75, "Normal");
  currentTower = new TowerButton(width - 75, 75, 150, 150, " ");


  generatePath();
  board = new Board();
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
    String className = Utilities.getName(enemyList.get(prng.nextInt(enemyList.size())));
    Enemy tmp = (Enemy) Utilities.createObject(className, self, delay);

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
    difficulty = difficultyButton.currentState;

    switch ( difficulty ) {
      case 1: currency = 500; playerHealth = 100; return;
      case 2: currency = 200; playerHealth =  50; return;
      case 3: currency = 100; playerHealth =  20; return;
    }
  }

  if ( ( ! levelRunning ) && nextLevel.clicked() ) {
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

