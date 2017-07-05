import java.util.Iterator;

public class Quadtree {
  final ArrayList<Tower> towers = new ArrayList<Tower>();
  ArrayList<Enemy> enemies = new ArrayList<Enemy>();
  final float X;
  final float Y;
  final float SIDELENGTH;
  final int MAXOBJECTS = 10;
  int numObjects;
  Quadtree[] children = new Quadtree[4];

  Quadtree(float x, float y, float length) {
    X = x;
    Y = y;
    SIDELENGTH = length;
    numObjects = 0;
  }

  void subdivide() {
    children[0] = new Quadtree(X + (SIDELENGTH / 2), Y, SIDELENGTH / 2);
    children[1] = new Quadtree(X, Y, SIDELENGTH / 2);
    children[2] = new Quadtree(X, Y + (SIDELENGTH / 2), SIDELENGTH / 2);
    children[3] = new Quadtree(X + (SIDELENGTH / 2), Y + (SIDELENGTH / 2), SIDELENGTH / 2);
    numObjects = 0;
    for (Tower t : towers) {
      addTower(t);
    }
    for (Enemy e : enemies) {
      addEnemy(e);
    }
  }

  // credit to the wonderful Joshua Turcotti for this formula which checks whether a circle is within a certain square
  boolean contains(Tower t) {
    float[] quadCenter = { X + SIDELENGTH / 2, Y + SIDELENGTH / 2};
    float[] tCenter = t.getCoords();
    double squareRadius =
      dist(tCenter[0], tCenter[1], X, Y)
      * (SIDELENGTH / 2)
      / abs(tCenter[1] - X);
    return (abs(tCenter[0] - quadCenter[0]) + t.getRadius() < SIDELENGTH / 2) &&
      (abs(t.getCoords()[1] - quadCenter[1]) + t.getRadius() < SIDELENGTH / 2);
  }

  boolean contains(Enemy e) {
    float[] enemyCoords = e.getCoords();
    return
      (enemyCoords[0] > X &&
       enemyCoords[0] < X + SIDELENGTH &&
       enemyCoords[1] > Y &&
       enemyCoords[1] < Y + SIDELENGTH);
  }

  float[] getCoords() {
    return new float[] {X, Y};
  }

  void addEnemy(Enemy e) {
    if (numObjects >= MAXOBJECTS) {
      subdivide();
    }

    numObjects++;
    if (children[0] == null) {
      enemies.add(e);
      return;
    }

    for (Quadtree child : children) {
      if (child.contains(e)) {
        child.addEnemy(e);
      }
    }
  }

  boolean removeEnemy(Enemy target) {
    if ( enemies.remove(target) ) {
      return true;
    }

    for (Quadtree child : children) {
      if ( child.removeEnemy(target) ) {
        return true;
      }
    }

    return false;
  }

  void addTower(Tower t) {
    numObjects++;
    if (numObjects >= MAXOBJECTS) {
      subdivide();
    }

    numObjects++;
    if (children[0] == null) {
      towers.add(t);
      return;
    }

    for (Quadtree child : children) {
      if (child.contains(t)) {
        child.addTower(t);
        return;
      }
    }
  }

  void detectCollisions() {
    for (Tower t : towers) {
      Iterator<Enemy> ite = enemies.iterator();
      while (ite.hasNext()) {
        Enemy e = ite.next();
        float[] eC = e.getCoords();
        float[] tC = t.getCoords();

        // in radius of tower
        if (dist(eC[0], eC[1], tC[0], tC[1]) <= t.getRadius()) {
          // FIXME: Currently vaporizes the enemy regardless of health
          // more health vs. lower check rate?
          if ( frameCount % ( difficulty / t.getRate() ) == 0 && e.decrementHealth() <= 0 ) {
            ite.remove();
            score += (difficulty * e.INITIAL_HEALTH);
            currency += ceil(e.INITIAL_HEALTH * difficulty / 2) * 10;
          }
        }

        // reached end without dying
        if (e.ALpos >= path.size() ) {
          ite.remove();
          playerHealth -= e.getHealth();
        }
      }
    }

    for (Quadtree q : children){
      if (q != null){
        q.detectCollisions();
      }
    }
  }

  ArrayList<Enemy> clearAllEnemies() {
    ArrayList<Enemy> retAL = enemies;
    enemies = new ArrayList<Enemy>();
    numObjects = 0;

    for ( Quadtree q : children ) {
      if ( q != null ) {
        q.numObjects = 0;
        retAL.addAll(q.clearAllEnemies());
      }
    }
    return retAL;
  }

  Quadtree[] getChildren() {
    return children;
  }
}