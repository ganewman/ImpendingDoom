import processing.core.PApplet;
public class Button {
  PFont buttonFont;
  float x;
  float y;
  final float buttonWidth;
  final float buttonHeight;
  String buttonText;

  Button(float xcor, float ycor, float width, float height, String text) {
    x = xcor;
    y = ycor;
    buttonWidth = width;
    buttonHeight = height;
    buttonText = text;
  }

  void colorChange() {
    if (
      mouseX > x - (buttonWidth / 2) &&
      mouseX < x + (buttonWidth / 2) &&
      mouseY > y - (buttonHeight / 2) &&
      mouseY < y + (buttonHeight / 2)) {
      fill(#5C00C6);
      rect(x, y, buttonWidth, buttonHeight);
      fill(#809B85);
      text(buttonText, x, y);
      }
    }
    
    boolean clicked(){
      return  mousePressed && 
      mouseX > x - (buttonWidth / 2) &&
      mouseX < x + (buttonWidth / 2) &&
      mouseY > y - (buttonHeight / 2) &&
      mouseY < y + (buttonHeight / 2);
    }
    void setup() {
      buttonFont = loadFont("AgencyFB-Reg-48.vlw");
      textFont(buttonFont);
    }


    void draw() {
      rectMode(CENTER);  
      fill(#809B85);

      rect(x, y, buttonWidth, buttonHeight);

      fill(#5C00C6);
      text(buttonText, x, y);
      colorChange();
    }
  }