//jan zacarias garcia
// Hubert Stanowski add highlighting
class Widget {
  int x, z;
  float y;
  String label;
  int event;
  color widgetColor, labelColor;
  PFont widgetFont;
  PImage cloud = loadImage("clouds.png");
  PImage highlightedCloud = loadImage("highlighted_clouds.png");

  Widget(int x, float y, String label, PFont widgetFont, int event) {
    this.x=x;
    this.y=y;
    this.label=label;
    this.event=event;
    this.widgetFont=widgetFont;
    labelColor= color(0);
  }
  void draw() {
    z+=1;
    if (z >=500) {
      z=0;
    }
    textAlign(int(x+10), int(y+10));  //added so that the text will be in the same position as it was, when the screen first appeared -> chart's text aligns have effect on these widget's label positions
    text(label, x+10, y+-10);
    if (x < mouseX  && mouseX < x+200 && mouseY > y && mouseY <y+100)
      image(highlightedCloud, x, y + sin(z / 12) * 10);
    else
      image(cloud, x, y + sin(z / 12) * 10);
  }

  int getEvent(int mX, int mY) {
    if (x< mX  && mX < x+200 && mY >y && mY <y+100) {
      return event;
    }
    return EVENT_NULL;
  }
}
