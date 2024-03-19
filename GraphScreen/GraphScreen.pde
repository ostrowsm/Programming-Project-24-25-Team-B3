int buttonX = 250;
int inputBoxY = 30, inputBoxWidth = 200, inputBoxHeight = 30;
int lateButtonY = 100;

int backButtonX = 30;
int backButtonY = 70;
int backButtonWidth = 50;
int backButtonHeight = 40;

int bgcolor = 255;
int whichEvent = 0;

PFont chartFont, normalFont;
PImage header, galaxy, bg;

void setup(){
  size(1000,800);
  chartFont = createFont("LucidaFax-Italic-30.vlw", 30);
  normalFont = createFont("LucidaSans-12", 12);
  header = loadImage("graph screen header.jpeg");
  galaxy = loadImage("galaxy.jpeg");
  bg = loadImage("background.jpeg");
}

void draw(){
  background(bgcolor);
  if(whichEvent == 1)
  {
    drawBackButton();
    drawText();
    drawChart1();
    drawChart2();
  }
  else if(whichEvent == 0){ drawLateButton(); }
  
}

//Maria Ostrowska
void drawLateButton(){
  bgcolor = 255;
  fill(200);
  rect(200, lateButtonY, inputBoxWidth, inputBoxHeight, 5);
  fill(0);
  text("Late", buttonX + inputBoxWidth/5, lateButtonY + inputBoxHeight/2 + 5);
}

int events(int mX, int mY) {
     if(mX>200 && mX < 200+inputBoxWidth && mY > lateButtonY && mY < lateButtonY + inputBoxHeight){
        return 1;
     }
     else if(mX > backButtonX && mX < backButtonX + backButtonWidth && mY > backButtonY && mY < backButtonY + backButtonHeight){
       return 0;}
     return 2;
}

void mousePressed(){
  int event = events(mouseX, mouseY);
  switch(event)
  {
    case 1:
      whichEvent = 1;
      break;
    case 0:
      whichEvent = 0;
      break;
  }
}
      
void drawBackButton() {
    bgcolor = 255;
    fill(50);
    image(bg, 0, 0, 1000, 800);
    rect(backButtonX, backButtonY, backButtonWidth, backButtonHeight, 5);
    fill(255);
    text("Back", backButtonX + backButtonWidth/4, backButtonY + backButtonHeight/2 + 5);
  }

void drawText(){
  int chartTextX = 450, chartTextY = 35;
  int header1X = 100, header1Y = 170;
  int header2X = 550, header2Y = 170;
  fill(102, 102, 255);
  rect(0,0, 600, 45);
  image(header, 0, 0, 1000, 45);
  textFont(chartFont);
  fill(255);
  text("Charts", chartTextX, chartTextY);
  fill(50);
  rect(header1X - 10,header1Y - 30, 315, 45);
  //image(galaxy, header1X - 10,header1Y - 30, 315, 45);
  fill(255);
  textSize(20);
  text("Number of delayed flights per day", header1X, header1Y);
  fill(50);
  rect(header2X - 10,header2Y - 30, 345, 45);
  //image(galaxy, header2X - 10,header2Y - 30, 315, 45);
  fill(255);
  textSize(20);
  text("Number of delayed flights by minutes", header2X, header2Y);
  textFont(normalFont);
}

void drawChart1(){
}

void drawChart2(){
}
