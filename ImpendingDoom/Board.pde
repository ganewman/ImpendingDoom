public class Board {
  Quadtree boardMap;
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
    enemiesOnBoard.add(e);
  }

  void update() {
    enemiesOnBoard = boardMap.clearAllEnemies();

    for ( Enemy e : enemiesOnBoard ) {
      e.update();
    }

    for ( Enemy e : enemiesOnBoard ) {
      boardMap.addEnemy(e);
    }
  }

  boolean isEmpty() {
    return enemiesOnBoard.isEmpty();
  }
}
