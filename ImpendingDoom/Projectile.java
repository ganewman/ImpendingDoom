public abstract class Projectile {
    private float speed = 1;
    private float[] coords = new float[2];
    private int strength;

    float getSpeed() {
        return speed;
    }

    float[] getCoordinates() {
        return coords;
    }

    int getStrength() {
        return strength;
    }
}
