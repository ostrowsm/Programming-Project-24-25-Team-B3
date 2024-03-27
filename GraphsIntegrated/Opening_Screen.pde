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

//Maria Ostrowska
int buttonX = 250;
int inputBoxY = 30, inputBoxWidth = 200, inputBoxHeight = 30;
int lateButtonY = 100;

int backButtonX = 30, backButtonY = 70;
int backButtonWidth = 50, backButtonHeight = 40;

int chartTextX = 425, chartTextY = 35;

int header1X = 100, header1Y = 170, headerHeight = 45, header1Width = 315;
int chartText1X = 300;
int backButton1X = 475;

int header2X = 550, header2Y = 170, header2Width = 345;
int chartText2X = 275;
int backButton2X = 900;

int bgcolor = 255;
int whichEvent = 0;

PFont chartFont, normalFont, stdFont;
PImage header, bg;


void setup() {
  //Jan
  frameRate(80);
  size(1000, 800);
  Widget widget1, widget2, widget3;
  stdFont=loadFont("Chalkboard-30.vlw");
  textFont(stdFont);
  widget1=new Widget(375, 175,
    "Airports", stdFont, EVENT_BUTTON1);
  widget2=new Widget(600, 375, "Lateness",
    stdFont, EVENT_BUTTON2);
  widget3=new Widget(150, 375, "Date Range",
    stdFont, EVENT_BUTTON3);
  widgetList = new ArrayList();
  widgetList.add(widget1);
  widgetList.add(widget2);
  widgetList.add(widget3);

  //Maria Ostrowska
  header = loadImage("graph screen header.jpeg");
  bg = loadImage("background.jpeg");
  //chartFont = loadFont("Dubai-Bold-30.vlw");
  setup1();
  setup2();
}

void draw() {
  //Maria Ostrowska
  if (whichEvent == 3)
  {
    drawHeader();
    drawBackButton();
    drawChart1Button();
    drawChart2Button();
  } else if (whichEvent == 4) {
    image(bg, 0, 0, 1000, 800);
    drawHeader1();
    drawBackButton1();
    draw1();
  } else if (whichEvent == 5) {
    image(bg, 0, 0, 1000, 800);
    drawHeader2();
    drawBackButton2();
    draw2();
  } else if (whichEvent == 0) {
    //Jan
    PImage back = loadImage("clouds2.png");
    background(135, 206, 235);
    image(back, MIDDLEX, MIDDLEY);
    textFont(stdFont);
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
}

//Maria Ostrowska
void drawHeader() {
  bgcolor = 255;
  image(bg, 0, 0, 1000, 800);
  fill(102, 102, 255);
  rect(0, 0, 600, 45);
  image(header, 0, 0, 1000, 45);
  textFont(stdFont);
  fill(255);
  textAlign(chartTextX, chartTextY);
  text("Charts", chartTextX, chartTextY);
}

void drawBackButton() {
  fill(50);
  rect(backButtonX, backButtonY, backButtonWidth, backButtonHeight, 5);
  fill(255);
  textSize(15);
  text("Back", backButtonX + backButtonWidth/4 - 3, backButtonY + backButtonHeight/2 + 5);
}

void drawChart1Button() {
  fill(50);
  rect(header1X - 10, header1Y - 30, header1Width, headerHeight);
  fill(255);
  textSize(20);
  textAlign(header1X, header1Y);
  text("Number of delayed flights per day", header1X, header1Y);
}

void drawChart2Button() {
  fill(50);
  rect(header2X - 10, header2Y - 30, 345, headerHeight);
  fill(255);
  textSize(20);
  text("Number of delayed flights by minutes", header2X, header2Y);
}

void drawHeader1() {
  bgcolor = 255;
  image(bg, 0, 0, 1000, 800);
  fill(102, 102, 255);
  rect(0, 0, 600, 45);
  image(header, 0, 0, 1000, 45);
  textFont(stdFont);
  fill(255);
  textAlign(chartText1X, chartTextY);
  text("Number of delayed flights per day", chartText1X, chartTextY);
}

void drawBackButton1() {
  fill(50);
  rect(backButton1X, backButtonY, backButtonWidth, backButtonHeight, 5);
  fill(255);
  textSize(15);
  text("Back", backButton1X + backButtonWidth/4 - 3, backButtonY + backButtonHeight/2 + 5);
}

void drawHeader2() {
  bgcolor = 255;
  image(bg, 0, 0, 1000, 800);
  fill(102, 102, 255);
  rect(0, 0, 600, 45);
  image(header, 0, 0, 1000, 45);
  textFont(stdFont);
  fill(255);
  textAlign(chartText2X, chartTextY);
  text("Number of delayed flights by minutes", chartText2X, chartTextY);
}

void drawBackButton2() {
  fill(50);
  rect(backButton2X, backButtonY, backButtonWidth, backButtonHeight, 5);
  fill(255);
  textSize(15);
  text("Back", backButton2X + backButtonWidth/4 - 3, backButtonY + backButtonHeight/2 + 5);
}

int events(int mX, int mY) {
  if (mX > backButtonX && mX < backButtonX + backButtonWidth && mY > backButtonY && mY < backButtonY + backButtonHeight) {
    return 0;
  } else if (mX > header1X - 10 && mX < header1X - 10 + header1Width && mY > header1Y - 30 && mY < header1Y - 30 + headerHeight) {
    return 4;
  } else if (mX > header2X - 10 && mX < header2X - 10 + header2Width && mY > header2Y - 30 && mY < header2Y - 30 + headerHeight) {
    return 5;
  } else if (mX > backButton1X && mX < backButton1X + backButtonWidth && mY > backButtonY && mY < backButtonY + backButtonHeight) {
    return 3;
  } else if (mX > backButton2X && mX < backButton2X + backButtonWidth && mY > backButtonY && mY < backButtonY + backButtonHeight) {
    return 3;
  }
  return 6;
}


void mousePressed() {
  int event;

  if (whichEvent == 0) {
    //Jan
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
        whichEvent = 3;
        return;
      case EVENT_BUTTON3:
        lateness = true;
        println("button 3!");
        return;
      }
    }
  }else
  {
    //Maria Ostrowska
    event = events(mouseX, mouseY);
    switch(event)
    {
    case 3:
      whichEvent = 3;
      break;

    case 4:
      whichEvent = 4;
      break;

    case 5:
      whichEvent = 5;
      break;

    case 0:
      whichEvent = 0;
      break;
    }
  }
}

//Jan
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
