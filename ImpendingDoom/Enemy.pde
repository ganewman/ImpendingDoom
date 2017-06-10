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

    // should always be the trailing number - 1 assuming naming conventions are followed
    img = enemyImages.get(Integer.parseInt(Utilities.getName(this).replaceAll("\\D+", "")) - 1);
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
  }
}

class Enemy2 extends Enemy {
  Enemy2(long delay, ArrayList<Float[]> path ) {
    super(delay, 3.00,  2, path);
  }
}

class Enemy3 extends Enemy {
  Enemy3(long delay, ArrayList<Float[]> path ) {
    super(delay, 1.00,  5, path);
  }
}

class Enemy4 extends Enemy {
  Enemy4(long delay, ArrayList<Float[]> path ) {
    super(delay, 0.50, 10, path);
  }
}
