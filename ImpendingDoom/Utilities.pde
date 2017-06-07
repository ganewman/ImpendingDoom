import java.lang.reflect.Constructor;
import java.util.ArrayList;
import java.util.List;

static final class Utilities {
  private Utilities() { }

  private static Object createObject(String className) {
    try {
      Class<?> c = Class.forName(className);
      return c.newInstance();
    } catch ( Exception e ) {
      e.printStackTrace();
      return null;
    }
  }

  private static Object createObject(String className, Object... args) {
    try {
      Class<?> c = Class.forName(className);
      Constructor<?> ctor = c.getDeclaredConstructors()[0];
      return ctor.newInstance(args);
    } catch ( Exception e ) {
      e.printStackTrace();
      return null;
    }
  }

  /** Generate a random coordinate.
   * Assumes the area is a square with corners (x1, y1) and (x2, y2).
   */
  private static float[] generateCoordinate(float x1, float y1, float x2, float y2) {
    return new float[] { sketchApplet.random(x1, x2), sketchApplet.random(y1, y2) };
  }

  private static String getName(Object obj) {
    return obj.getClass().getName();
  }
}
