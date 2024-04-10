// Jan Zacarias Garcia
final int EVENT_BUTTON1=1;
final int EVENT_BUTTON2=2;
final int EVENT_BUTTON3=3;
final int EVENT_BUTTON4 = 4;
final int EVENT_NULL=0;
final int MIDDLEX = 0;
final int MIDDLEY = 0;
ArrayList widgetList;

boolean airports1 = false;
boolean date_range = false;
boolean lateness = false;
boolean flights_per_day = false;


// Hubert Stanowski fix the clouds movement, standardize button locations

PImage back;

//Maria Ostrowska

int backButtonX = 30, backButtonY = 70;
int backButtonWidth = 50, backButtonHeight = 40;

int chartTextX = 425, chartTextY = 35;

int header1X = 100, header1Y = 170, headerHeight = 45, header1Width = 315;

int header2X = 550, header2Y = 170, header2Width = 345;

int chartText1X = 300;
int chartText2X = 275;
int chartText3X = 600;
int chartText4X = 375;

boolean done = false;

int whichEvent = 0;

PFont chartFont, normalFont, stdFont;
PImage header, bg, bg2, bg3;


void setup() {
  //Jan
  frameRate(100);
  size(1200, 800);
  Widget widget1, widget2, widget3, widget4;
  back = loadImage("planeBg.jpeg");
  stdFont=loadFont("Chalkboard-30.vlw");
  textFont(stdFont);
  widget1=new Widget(500, 175,
    "Airports", stdFont, EVENT_BUTTON1);
  widget2=new Widget(800, 375, "Lateness",
    stdFont, EVENT_BUTTON2);
  widget3=new Widget(200, 375, "Date Range",
    stdFont, EVENT_BUTTON3);
  widget4=new Widget(500, 550, "Flights per day",
    stdFont, EVENT_BUTTON4);
  widgetList = new ArrayList();
  widgetList.add(widget1);
  widgetList.add(widget2);
  widgetList.add(widget3);
  widgetList.add(widget4);

  //Maria Ostrowska
  header = loadImage("graph screen header.jpeg");
  bg = loadImage("background.jpeg");
  bg2 = loadImage("bg2.jpeg");
  bg3 = loadImage("background3.jpeg");

  setup1();
  setup2();
  setup3();
  setup4();
}

void draw() {
  //Maria Ostrowska
  if (whichEvent == 1)
  {
    windowResize(1420, 825);
    drawHeader1(chartText3X, "Top 50 busiest airports");
    drawBackButton(backButtonX);
    draw3();
  } else if (whichEvent == 2) {
    if(!done){
      setup5();
      done = true;
    }
    draw5();
  } else if (whichEvent == 4) {
    drawHeader2(chartText4X, "Total flights per day");
    drawBackButton(backButtonX);
    draw4();
  } else if (whichEvent == 3) {
    drawHeader(chartTextX, "Charts");
    drawBackButton(backButtonX);
    drawChart1Button();
    drawChart2Button();
  } else if (whichEvent == 5) {
    drawHeader(chartText1X, "Number of delayed flights per day");
    drawBackButton(backButtonX);
    draw1();
  } else if (whichEvent == 6) {
    drawHeader(chartText2X, "Number of delayed flights by minutes");
    drawBackButton(backButtonX);
    draw2();
  } else if (whichEvent == 0) {
    //Jan
   background(135, 206, 235);
   image(back, MIDDLEX, MIDDLEY);
   textFont(stdFont);
   fill(255);
   frameRate(80);
   for (int i = 0; i<widgetList.size(); i++) {
      Widget aWidget = (Widget)widgetList.get(i);
      if (airports1 && i == 0) {
           aWidget.draw();
      } else if (date_range && i == 1) {
           aWidget.draw();
      } else if (lateness && i == 2) {
           aWidget.draw();
      } else if (flights_per_day && i == 3) {
           aWidget.draw();
      } else {
           aWidget.draw();
      }
   }
   done = false;
  }
  loop();
}

//Maria Ostrowska
void drawHeader(int chartTextX, String text) {
  image(bg, 0, 0, 1000, 800);
  image(header, 0, 0, 1000, 45);
  textFont(stdFont);
  fill(255);
  textAlign(chartTextX, chartTextY);
  text(text, chartTextX, chartTextY);
}

void drawBackButton(int backButtonX) {
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

void drawHeader1(int chartTextX, String text) {
  image(bg2, 0, 0, 1500, 825);
  image(header, 0, 0, 1500, 45);
  textFont(stdFont);
  fill(255);
  textAlign(chartTextX, chartTextY);
  text(text, chartTextX, chartTextY);
}

void drawHeader2(int chartTextX, String text) {
  image(bg3, 0, 0, 1500, 825);
  image(header, 0, 0, 1500, 45);
  textFont(stdFont);
  fill(255);
  textAlign(chartTextX, chartTextY);
  text(text, chartTextX, chartTextY);
}

int events(int mX, int mY) {
  if (mX > backButtonX && mX < backButtonX + backButtonWidth && mY > backButtonY && mY < backButtonY + backButtonHeight) {
    windowResize(1200, 800);
    return 0;
  } else if (mX > backButtonX && mX < backButtonX + backButtonWidth && mY > backButtonY && mY < backButtonY + backButtonHeight) {
    windowResize(1200, 800);
    return 0;
  } else if (mX > backButtonX && mX < backButtonX + backButtonWidth && mY > backButtonY && mY < backButtonY + backButtonHeight) {
    windowResize(1200, 800);
    return 0;
  } else if (mX > header1X - 10 && mX < header1X - 10 + header1Width && mY > header1Y - 30 && mY < header1Y - 30 + headerHeight) {
    windowResize(1000, 800);
    return 5;
  } else if (mX > header2X - 10 && mX < header2X - 10 + header2Width && mY > header2Y - 30 && mY < header2Y - 30 + headerHeight) {
    windowResize(1000, 800);
    return 6;
  } else if (mX > backButtonX && mX < backButtonX + backButtonWidth && mY > backButtonY && mY < backButtonY + backButtonHeight) {
    windowResize(1000, 800);
    return 3;
  } else if (mX > backButtonX && mX < backButtonX + backButtonWidth && mY > backButtonY && mY < backButtonY + backButtonHeight) {
    windowResize(1000, 800);
    return 3;
  }
  return 7;
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
        airports1 = true;
        println("button 1!");
        whichEvent = 1;
        return;
      case EVENT_BUTTON2:
        lateness = true;
        windowResize(1000, 800);
        println("button 2!");
        whichEvent = 3;
        return;
      case EVENT_BUTTON3:
        date_range = true;
        println("button 3!");
        whichEvent = 2;
        return;
      case EVENT_BUTTON4:
        flights_per_day = true;
        windowResize(1000, 800);
        println("button 4!");
        whichEvent = 4;
        return;
      }
    }
  } else
  {
    //Maria Ostrowska
    event = events(mouseX, mouseY);
    switch(event)
    {
    case 3:
      whichEvent = 3;
      break;

    case 5:
      whichEvent = 5;
      break;

    case 6:
      whichEvent = 6;
      break;

    case 0:
      whichEvent = 0;
      break;
    }
  }
}
