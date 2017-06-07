import processing.core.PApplet;

public class Button {
  boolean toggled;
  PFont buttonFont;
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
    buttonFont = loadFont("AgencyFB-Reg-48.vlw");
    textFont(buttonFont);
  }

  void draw() {
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

class StatefulButton extends Button {
  int state = 1;

  StatefulButton(float xcor, float ycor, float width, float height, String text) {
    super(xcor, ycor, width, height, text);
  }
}

class DifficultyButton extends StatefulButton {
  DifficultyButton(float xcor, float ycor, float width, float height, String text) {
    super(xcor, ycor, width, height, text);
  }

  boolean clicked() {
    if ( mousePressed && inRect() ) {
      if ( ++state > 3 ) {
        state = 1;
      }

      switch ( state ) {
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
  TowerButton(float xcor, float ycor, float width, float height, String text) {
    super(xcor, ycor, width, height, text);
  }

  boolean clicked() {
    if ( mousePressed && inRect() ) {
      if ( ++state > NUM_TOWERS ) {
        state = 1;
      }
      return true;
    }
    return false;
  }

  @Override void draw() {
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
    image(towerImages[state - 1], X, Y, 150, 150);
    text(X, Y, ((Tower) (Utilities.createObject(towerList.get(state - 1), self, -1, -1))).getCost());
  }
}
