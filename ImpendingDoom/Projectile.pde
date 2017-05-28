public abstract class Projectile extends Placable {
  float speed = 1;
  int strength;

  float getSpeed() {
    return speed;
  }

  int getStrength() {
    return strength;
  }
}
