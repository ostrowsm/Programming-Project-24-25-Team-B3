final int EVENT_BUTTON1=1;
final int EVENT_BUTTON2=2;
final int EVENT_BUTTON3=3;
final int EVENT_NULL=0;
final int MIDDLEX = 0;
final int MIDDLEY = 0;
ArrayList widgetList;

boolean airports = false;
boolean date_range = false;
boolean lateness = false;
boolean mouseRed = false;
boolean mouseGreen = false;
boolean mouseBlue = false;


void setup() {
  frameRate(80);
  size(750, 700);
  PFont stdFont;
  Widget widget1, widget2, widget3;
  stdFont=loadFont("Chalkboard-30.vlw");
  textFont(stdFont);
  widget1=new Widget(275, 125,
    "Airports",stdFont, EVENT_BUTTON1);
  widget2=new Widget(500, 325, "Lateness",
    stdFont, EVENT_BUTTON2);
  widget3=new Widget(50, 325,"Date Range",
  stdFont, EVENT_BUTTON3);
  widgetList = new ArrayList();
  widgetList.add(widget1);
  widgetList.add(widget2);
  widgetList.add(widget3);
}

void draw() {
  PImage back = loadImage("clouds2.png");
  background(135, 206, 235);
  image(back, MIDDLEX , MIDDLEY);
  for (int i = 0; i<widgetList.size(); i++) {
    Widget aWidget = (Widget)widgetList.get(i);
    if (airports && i == 0) {
      aWidget.draw();
    } else if (date_range && i == 1) {
      aWidget.draw();
    } else if (lateness && i == 2) {
      aWidget.draw();
    } else {
      aWidget.draw();
    }
  }
}

void mousePressed() {
  int event;
  for (int i = 0; i<widgetList.size(); i++) {
    Widget aWidget = (Widget) widgetList.get(i);
    event = aWidget.getEvent(mouseX, mouseY);
    switch(event) {
    case EVENT_BUTTON1:
      airports = true;
      println("button 1!");
      return;
    case EVENT_BUTTON2:
      date_range = true;
      println("button 2!");
      return;
    case EVENT_BUTTON3:
      lateness = true;
      println("button 3!");
      return;
    }
  }
}
void mouseMoved() {
  mouseRed = false;
  mouseGreen = false;
  mouseBlue = false;
  
  if ((mouseX >= 100 && mouseX <= 280) && (mouseY >= 50 && mouseY <= 90)) {
    mouseRed = true;
    mouseGreen = false;
    mouseBlue = false;
  }
  if ((mouseX >= 100 && mouseX <= 280) && (mouseY >= 150 && mouseY <= 190)) {
    mouseGreen = true;
    mouseRed = false;
    mouseBlue = false;
  }
  if ((mouseX >= 100 && mouseX <= 280) && (mouseY >= 250 && mouseY <= 290)) {
    mouseBlue = true;
    mouseGreen = false;
    mouseRed = false;
  }
}
