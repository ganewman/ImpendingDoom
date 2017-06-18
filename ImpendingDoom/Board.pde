import java.util.ArrayList;
import java.util.List;

public class Board {
  final Quadtree boardMap = new Quadtree(0, 0, width);
  List<Enemy> enemiesOnBoard = new ArrayList<Enemy>();
  final List<Tower> towers = new ArrayList<Tower>();

  public Board() {
  }

  void draw() {
    background(colors.get("lime"));
    update();

    stroke(colors.get("tan"));
    for ( int i = 0; i < path.size() - 1; i++ ) {
      line(path.get(i)[0], path.get(i)[1], path.get(i + 1)[0], path.get(i + 1)[1]);
    }
    loadDefaults();

    for ( Enemy e: enemiesOnBoard ) {
      e.draw();
    }

    for (Tower t : towers) {
      t.draw();
    }

    for ( Tower t : towers ) {
      t.drawRadius();
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

