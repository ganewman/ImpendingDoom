
public class Board {
  Quadtree boardMap = new Quadtree(0, 0, width);
  ArrayList<Enemy> onBoard;

  void update() {
    onBoard = boardMap.clearEnemies();
  }
}