import java.util.ArrayList;
import java.util.List;

public class Board {
  Quadtree boardMap;
  List<Enemy> enemiesOnBoard = new ArrayList<Enemy>();
  final List<Tower> towers = new ArrayList<Tower>();

  public Board() {
  }

  void draw() {
    background(#BFF7B4);
    update();

    stroke(#EDBA37);
    strokeWeight(20);
    for ( int i = 0; i < path.size() - 1; i++ ) {
      line(path.get(i)[0], path.get(i)[1], path.get(i + 1)[0], path.get(i + 1)[1]);
    }
    noStroke();
    for ( Enemy e: enemiesOnBoard ) {
      e.draw();
    }

    for (Tower t : towers) {
      t.draw();
    }
  }

  void addTower(Tower t) {
    boardMap.addTower(t);
    towers.add(t);
  }

  void addEnemy(Enemy e) {
    e.setCoords(path.get(0)[0], path.get(0)[1]);
    boardMap.addEnemy(e);
    enemiesOnBoard.add(e);
  }

  void update() {
    enemiesOnBoard = boardMap.clearAllEnemies();


    for ( Enemy e : enemiesOnBoard ) {
      e.update();
      boardMap.addEnemy(e);
    }
    boardMap.detectCollisions();
  }

  boolean isEmpty() {
    return enemiesOnBoard.isEmpty();
  }
}

