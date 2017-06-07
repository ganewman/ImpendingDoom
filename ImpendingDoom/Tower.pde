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
  }

  float getRadius() {
    return radius;
  }

  @Override void draw() {
    // XXX: debug purposes
    sketchApplet.image(img, X - (img.width / 2), Y - (img.height / 2));
    sketchApplet.fill(#5C00C6, 70);
    sketchApplet.ellipse(X, Y, this.getRadius(), this.getRadius());
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
    img = towerImages[0];
  }
}

class Tower2 extends Tower {
  Tower2(float x, float y) {
    super(x, y, 150, 0.15, 200);
    img = towerImages[1];
  }
}

class Tower3 extends Tower {
  Tower3(float x, float y) {
    super(x, y, 250, 0.50, 400);
    img = towerImages[2];
  }
}

class Tower4 extends Tower {
  Tower4(float x, float y) {
    super(x, y, 400, 1.00, 800);
    img = towerImages[3];
  }
}
