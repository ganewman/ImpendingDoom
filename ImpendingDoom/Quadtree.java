import java.util.ArrayList;

public class Quadtree {
    private final ArrayList<Tower> towers = new ArrayList<>();
    private ArrayList<Enemy> enemies = new ArrayList<>();
    private final float X;
    private final float Y;
    private final float SIDELENGTH;
    private final int MAXOBJECTS = 10;
    private int numObjects;
    private Quadtree[] children = new Quadtree[4];

    public Quadtree(float x, float y, float length){
        X = x;
        Y = y;
        SIDELENGTH = length;
    }

  void setup(){}
    void subdivide(){
        children[0] = new Quadtree(X + (SIDELENGTH / 2), Y, SIDELENGTH / 2);
        children[1] = new Quadtree(X, Y,SIDELENGTH / 2);
        children[2] = new Quadtree(X, Y + (SIDELENGTH / 2), SIDELENGTH / 2);
        children[3] = new Quadtree(X + (SIDELENGTH / 2), Y + (SIDELENGTH / 2), SIDELENGTH / 2);
        for (Tower t : towers){
            addTower(t);
        }
        for (Enemy e : enemies){
            addEnemy(e);
        }

    }

    boolean contains(float[] point){
        return
            point[0] < X + SIDELENGTH &&
            point[0] > X &&
            point[1] < Y &&
            point[1] > Y + SIDELENGTH;
    }


    float[] getCoords() {
        return new float[] {X, Y};
    }

    void addEnemy(Enemy e) {
        numObjects++;
        if (numObjects >= MAXOBJECTS){
            subdivide();
        }
        if (children[0] == null){
            enemies.add(e);
            return;
        }
        for (Quadtree child : children){
            if (child.contains(e.getCoords())){
                child.addEnemy(e);
            }
        }
        enemies.add(e);
    }

    boolean removeEnemy(Enemy target) {
        for (Enemy e : enemies){
            if (e.equals(target)){
                enemies.remove(e);
                return true;
            }

        }
        for (Quadtree child : children){
            child.removeEnemy(target);
        }
        return false;
    }

    void addTower(Tower t) {
        numObjects++;
        if (numObjects >= MAXOBJECTS){
            subdivide();
        }
        if (children[0] == null){
            towers.add(t);
            return;
        }
        for (Quadtree child : children){
            if (child.contains(t.getCoords())){
                child.addTower(t);
            }
        }
        towers.add(t);

    }
    
    ArrayList<Enemy> clearEnemies(){
      ArrayList<Enemy> retAL = enemies;
      enemies = null;
      return retAL;
    }

    Quadtree[] getChildren() {
        return children;
    }
}