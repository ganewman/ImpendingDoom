
public class Board {
  Quadtree boardMap = new Quadtree(0, 0, width); 
  ArrayList<Enemy> enemiesOnBoard = new ArrayList<Enemy>();
  ArrayList<Tower> towers = new ArrayList<Tower>();
  PImage[] enemyImages = new PImage[2];
  PImage[] towerImages = new PImage[2];
  EnemyA test;


  Board(PImage[] enemyImages, PImage[] towerImages) {
    this.enemyImages = enemyImages;
    this.towerImages = towerImages;
  }
  void draw() {
    background(#BFF7B4);
    update();
    for (Tower t : towers){
      t.draw();
    }
  }

  void addTower(Tower t) {
    boardMap.addTower(t);
    towers.add(t);
  }
  void update() {
    enemiesOnBoard = boardMap.clearEnemies();
  }
}