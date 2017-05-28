public abstract class Tower extends Placable {
  float radius = 5;
  float rate = 1;
  int strength = 1;

  Tower(float x, float y, PImage imgg) {
    X = x;
    Y = y;
    img = imgg;

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
