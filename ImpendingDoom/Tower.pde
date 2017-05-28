public abstract class Tower {
  private float radius = 5;
  private float rate = 1;
  private float[] coords = new float[2];
  private int strength = 1;
  PImage img;

  public Tower(float x, float y, PImage img) {
    coords[0] = x;
    coords[1] = y;
    this.img = img;
  }

  void draw() {
    image(img, x, y);
  }


  float getRadius() {
    return radius;
  }

  float[] getCoords() {
    return coords;
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