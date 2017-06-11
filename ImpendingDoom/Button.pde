import processing.core.PApplet;

public class Button {
  boolean toggled;
  String buttonText;
  final float X;
  final float Y;
  final float BUTTONWIDTH;
  final float BUTTONHEIGHT;

  Button(float xcor, float ycor, float width, float height, String text) {
    X = xcor;
    Y = ycor;
    BUTTONWIDTH = width;
    BUTTONHEIGHT = height;
    buttonText = text;
  }

  boolean inRect() {
    return
      mouseX > X - (BUTTONWIDTH / 2) &&
      mouseX < X + (BUTTONWIDTH / 2) &&
      mouseY > Y - (BUTTONHEIGHT / 2) &&
      mouseY < Y + (BUTTONHEIGHT / 2);
  }

  boolean clicked() {
    if ( mousePressed && inRect() ) {
      return toggled ^= true;
    }

    return false;
  }

  void setup() {
  }

  void draw() {
    textFont(fonts.get("variable"));
    rectMode(CENTER);
    if ( inRect() ) {
      fill(#5C00C6);
      rect(X, Y, BUTTONWIDTH, BUTTONHEIGHT);
      fill(#809B85);
    } else {
      fill(#809B85);
      rect(X, Y, BUTTONWIDTH, BUTTONHEIGHT);
      fill(#5C00C6);
    }
    text(buttonText, X, Y);
  }
}

/* Yes, this violates the "one class per file" policy too.
 */

abstract class StatefulButton extends Button {
  int maxState;
  int minState;
  int currentState;

  StatefulButton(float xcor, float ycor, float width, float height, String text) {
    super(xcor, ycor, width, height, text);
  }

  int cycle() {
    if ( ++currentState > maxState ) {
      currentState = minState;
    }
    return currentState;
  }
}

class DifficultyButton extends StatefulButton {
  DifficultyButton(float xcor, float ycor, float width, float height, String text) {
    super(xcor, ycor, width, height, text);
    maxState = 3;
    minState = 1;
    currentState = 2;
  }

  boolean clicked() {
    if ( mousePressed && inRect() ) {
      switch ( cycle() ) {
        case 1: buttonText = "Easy";   break;
        case 2: buttonText = "Normal"; break;
        case 3: buttonText = "Hard";   break;
      }
      return true;
    }
    return false;
  }
}

class TowerButton extends StatefulButton {
  Tower current = towerList.get(0);

  TowerButton(float xcor, float ycor, float width, float height, String text) {
    super(xcor, ycor, width, height, text);
    maxState = towerList.size() - 1;
  }

  boolean clicked() {
    if ( mousePressed && inRect() ) {
      current = towerList.get(cycle());
      return true;
    }
    return false;
  }

  @Override void draw() {
    rectMode(CENTER);
    imageMode(CENTER);
    if ( inRect() ) {
      fill(#5C00C6);
      rect(X, Y, BUTTONWIDTH, BUTTONHEIGHT);
      fill(#809B85);
    } else {
      fill(#809B85);
      rect(X, Y, BUTTONWIDTH, BUTTONHEIGHT);
      fill(#5C00C6);
    }

    image(current.img, X, Y);
    text(current.getCost(), X, Y);
  }
}

