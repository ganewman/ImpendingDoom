public abstract class Enemy {
    private float speed = 1;
    private float[] coords = new float[2];
    private int health = 1;

    public int getHealth() {
        return health;
    }

    public void decrementHealth() {
        health--;
    }

    public float getSpeed() {
        return speed;
    }

    public float[] getCoords() {
        return coords;
    }

    public void setCoords(float x, float y) {
        this.coords[0] = x;
        this.coords[1] = y;
    }
}
