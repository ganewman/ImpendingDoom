public class EnemyA extends Enemy {
  EnemyA(PImage img) {
    blob = img;
  }



  PImage blob;


  void draw() {
    image(blob, 100, 100);
  }
}