import javax.swing.*;
import java.awt.*;

void setup() {
  size(400, 300);
  SwingUtilities.invokeLater(new Runnable() {
    @Override
    public void run() {
      createAndShowDatePicker();
    }
  });
  new CalendarView();
}

void draw(){
  
}

void createAndShowDatePicker() {
  JFrame frame = new JFrame("Select Date");
  // Here you would initialize your JDatePicker and add it to the frame
  frame.setSize(200, 200);
  frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
  
  // Get the location of the Processing window
  Point location = frame.getLocation();
  
  // Adjust the JFrame's position. This is a simple example that positions
  // the JFrame 100 pixels to the right and 100 pixels down from the Processing window.
  // You can adjust these values based on the Processing window's actual location.
  frame.setLocation(location.x + 100, location.y + 100);
  
  frame.setVisible(true);
}
