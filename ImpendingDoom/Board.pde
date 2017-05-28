public class Board {
  final Quadtree boardMap = new Quadtree(0, 0, width);
  ArrayList<Enemy> enemiesOnBoard = new ArrayList<Enemy>();
  final ArrayList<Tower> towers = new ArrayList<Tower>();

  void draw() {
    background(#BFF7B4);
    update();
    for (Tower t : towers) {
      t.draw();
    }
  }

  void addTower(Tower t) {
    boardMap.addTower(t);
    towers.add(t);
  }

  void addEnemy(Enemy e) {
    boardMap.addEnemy(e);
  }

  void update() {
    if ( boardMap.enemies == null ) {
      return;
    }

    for ( Enemy e : boardMap.enemies ) {
      e.update();
    }
  }
}
