public abstract class Tower extends Placeable {
  float radius;
  float rate;
  int strength = 1; // currently unused
  int cost;

  Tower(float x, float y, float radius, float rate, int cost) {
    X = x;
    Y = y;
    this.radius = radius;
    this.rate = rate;
    this.cost = cost;

    // should always be the trailing number - 1 assuming naming conventions are followed
    img = towerImages.get(Integer.parseInt(Utilities.getName(this).replaceAll("\\D+", "")) - 1);
  }

  float getRadius() {
    return radius;
  }

  void drawRadius() {
    fill(colors.get("background"), 70);
    ellipse(X, Y, this.getRadius(), this.getRadius());
    fill(colors.get("background"));
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

  int getCost() {
    return cost;
  }
}

/* I am aware that this does not follow the "one class per file" policy and the
 * implications of that. It's tidier this way.
 */

class Tower1 extends Tower {
  Tower1(float x, float y) {
    super(x, y, 100, 0.05, 100);
  }
}

class Tower2 extends Tower {
  Tower2(float x, float y) {
    super(x, y, 150, 0.15, 200);
  }
}

class Tower3 extends Tower {
  Tower3(float x, float y) {
    super(x, y, 250, 0.50, 400);
  }
}

class Tower4 extends Tower {
  Tower4(float x, float y) {
    super(x, y, 400, 1.00, 800);
  }
}

