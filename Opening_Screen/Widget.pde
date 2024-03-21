class Widget {
  int x, y, width, height;
  String label; int event;
  color widgetColor, labelColor;
  PFont widgetFont;

  Widget(int x,int y, int width, int height, String label,
  color widgetColor, PFont widgetFont, int event){
    this.x=x; this.y=y; this.width = width; this.height= height;
    this.label=label; this.event=event; 
    this.widgetColor=widgetColor; this.widgetFont=widgetFont;
    labelColor= color(0);
   }
  void draw(int colour1, int colour2, int colour3, boolean mouseOn){
    widgetColor = color (colour1, colour2, colour3);
    fill(widgetColor);
    if(mouseOn){
      stroke (300, 300, 300);
    }else{
      noStroke();
    } 
    rect(x,y,width,height);
    fill(labelColor);
    text(label, x+10, y+height-10);
    mouseOn = false;
  }
  int getEvent(int mX, int mY){
     if(mX>x && mX < x+width && mY >y && mY <y+height){
        return event;
     }
     return EVENT_NULL;
  }
}
