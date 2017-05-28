import processing.core.PApplet;

public class Button {
  PFont buttonFont;
  final float X;
  final float Y;
  final float BUTTONWIDTH;
  final float BUTTONHEIGHT;
  final String BUTTONTEXT;

  Button(float xcor, float ycor, float width, float height, String text) {
    X = xcor;
    Y = ycor;
    BUTTONWIDTH = width;
    BUTTONHEIGHT = height;
    BUTTONTEXT = text;
  }

  boolean inRect() {
    return
      mouseX > X - (BUTTONWIDTH / 2) &&
      mouseX < X + (BUTTONWIDTH / 2) &&
      mouseY > Y - (BUTTONHEIGHT / 2) &&
      mouseY < Y + (BUTTONHEIGHT / 2);
  }

  void colorChange() {
    if ( inRect() ) {
      fill(#5C00C6);
      rect(X, Y, BUTTONWIDTH, BUTTONHEIGHT);
      fill(#809B85);
      text(BUTTONTEXT, X, Y);
    }
  }

  boolean clicked() {
    return mousePressed && inRect();
  }

  void setup() {
    buttonFont = loadFont("AgencyFB-Reg-48.vlw");
    textFont(buttonFont);
  }

  void draw() {
    rectMode(CENTER);
    fill(#809B85);

    rect(X, Y, BUTTONWIDTH, BUTTONHEIGHT);

    fill(#5C00C6);
    text(BUTTONTEXT, X, Y);
    colorChange();
  }
}
