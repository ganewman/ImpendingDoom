abstract class Enemy extends Placeable {
  ArrayList<Float[]> path;
  int ALpos;
  float speed = 1;
  final int INITIAL_HEALTH;
  int health;

  final long delay;
  long blockUntil;

  Enemy(long delay, float speed, int health, ArrayList<Float[]> path) {
    this.delay = delay;
    this.speed = speed;
    this.health = health;
    INITIAL_HEALTH = health;
    this.path = path;
  }

  void startDelay() {
    if ( blockUntil == 0 ) {
      blockUntil = System.currentTimeMillis() + delay;
    }
  }

  long timeLeft() {
    return blockUntil - System.currentTimeMillis();
  }

  int getHealth() {
    return health;
  }

  int decrementHealth() {
    return health--;
  }

  float getSpeed() {
    return speed;
  }

  void setCoords(float x, float y) {
    X = x;
    Y = y;
  }

  void update() {
    X = path.get(ALpos)[0];
    Y = path.get(ALpos++)[1];
  }
}

/* I am aware that this does not follow the "one class per file" policy and the
 * implications of that. It's tidier this way.
 */

// enemies get slower, but tougher
class Enemy1 extends Enemy {
  Enemy1(long delay, ArrayList<Float[]> path ) {
    super(delay, 5.00,  1, path);
    img = enemyImages[0];
  }
}

class Enemy2 extends Enemy {
  Enemy2(long delay, ArrayList<Float[]> path ) {
    super(delay, 3.00,  2, path);
    img = enemyImages[1];
  }
}

class Enemy3 extends Enemy {
  Enemy3(long delay, ArrayList<Float[]> path ) {
    super(delay, 1.00,  5, path);
    img = enemyImages[2];
  }
}

class Enemy4 extends Enemy {
  Enemy4(long delay, ArrayList<Float[]> path ) {
    super(delay, 0.50, 10, path);
    img = enemyImages[3];
  }
}
