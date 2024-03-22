class Widget {
  int x, z;
  float y;
  String label; int event;
  color widgetColor, labelColor;
  PFont widgetFont;
  PImage cloud = loadImage("clouds.png");

  Widget(int x,float y,String label, PFont widgetFont, int event){
    this.x=x; this.y=y; this.label=label; this.event=event;
    this.widgetFont=widgetFont;
    labelColor= color(0);
   }
  void draw(){
    z+=1;
    if (z >=500){
      z=0;
    }
    text(label, x+10, y+-10);
    image(cloud, x, y + sin(z / 12) * 10);
  }

  int getEvent(int mX, int mY){
     if(x< mX  && mX < x+width && mY >y && mY <y+100){
        return event;
     }
     return EVENT_NULL;
  }
}
