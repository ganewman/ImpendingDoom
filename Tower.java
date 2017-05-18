public abstract class Tower {
  private float radius = 5;
  private float rate = 1;
  private float[] coords = new float[2];
  private int strength = 1;

  public Tower(float x, float y) {
    coords[0] = x;
    coords[1] = y;
  }

  public void setRadius(float radius) {
    this.radius = radius;
  }

  public void setStrength(int strength) {
    this.strength = strength;
  }

  public void setRate(int rate) {
    this.rate = rate;
  }
}

