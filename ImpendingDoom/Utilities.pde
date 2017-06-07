import java.lang.reflect.Constructor;

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

  private static String getName(Object obj) {
    return obj.getClass().getName();
  }
}
