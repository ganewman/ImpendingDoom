import java.lang.reflect.Constructor;
import java.lang.reflect.Field;

static final class Utilities {
  private Utilities() { }

  static Object createObject(String className) throws Exception {
    Class<?> c = Class.forName(className);
    return c.newInstance();
  }

  static Object createObject(String className, Object... args) throws Exception {
    Class<?> c = Class.forName(className);
    Constructor<?> ctor = c.getDeclaredConstructors()[0];
    return ctor.newInstance(args);
  }

  static String getName(Object obj) {
    return obj.getClass().getName();
  }

  static Object getObject(Object clazz, String variableName) throws Exception {
    Field f = clazz.getClass().getDeclaredField(variableName);
    return f.get(clazz);
  }
}
