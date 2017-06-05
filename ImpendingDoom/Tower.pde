public abstract class Tower extends Placable {
  float radius = 5;
  float rate = 1;
  int strength = 1;

  Tower(float x, float y) {
    X = x;
    Y = y;
  }

  float getRadius() {
    return radius;
  }

  void setRadius(float radius) {
    this.radius = radius;
  }

  float getStrength() {
    return strength;
  }

  void setStrength(int strength) {
    this.strength = strength;
  }

  float getRate() {
    return rate;
  }

  void setRate(int rate) {
    this.rate = rate;
  }
}

/* I am aware that this does not follow the "one class per file" policy and the
 * implications of that. It's tidier this way.
 */

class Tower1 extends Tower {
  Tower1(float x, float y) {
    super(x, y);
    img = towerImages[0];
  }
}

class Tower2 extends Tower {
  Tower2(float x, float y) {
    super(x, y);
    img = towerImages[1];
  }
}

class Tower3 extends Tower {
  Tower3(float x, float y) {
    super(x, y);
    img = towerImages[2];
  }
}

class Tower4 extends Tower {
  Tower4(float x, float y) {
    super(x, y);
    img = towerImages[3];
  }
}

