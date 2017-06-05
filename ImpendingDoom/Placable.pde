abstract class Placable {
  float X;
  float Y;
  PImage img;

  void draw() {
    image(img, 
      X - (img.width / 2), 
      Y - (img.height / 2));
      if (this instanceof Tower) {
        this.draw();
      }
  }

  float[] getCoords() {
    return new float[] {X, Y};
  }
}