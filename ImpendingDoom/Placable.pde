abstract class Placable {
  float X;
  float Y;
  PImage img;

  void draw() {
    image(img, X, Y);
  }

  float[] getCoords() {
    return new float[] {X, Y};
  }
}
