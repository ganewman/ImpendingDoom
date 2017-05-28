abstract class Enemy extends Placable {

  float speed = 1;
  int health = 1;

  final long delay;
  long blockUntil;

  Enemy(long delay) {
    this.delay = delay;
  }

  //
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

  void decrementHealth() {
    health--;
  }

  float getSpeed() {
    return speed;
  }

  void setCoords(float x, float y) {
    this.X = x;
    this.Y = y;
  }

  // FIXME: implement me please
  void update() {
  }
}
