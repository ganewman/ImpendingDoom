public abstract class Projectile extends Placeable {
  float speed = 1;
  int strength;

  float getSpeed() {
    return speed;
  }

  int getStrength() {
    return strength;
  }
}
