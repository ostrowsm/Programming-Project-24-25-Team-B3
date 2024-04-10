import java.text.ParseException;
import java.util.HashMap;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Collections;

class DailyDelaysGraph {
  HashMap<String, Integer> dailyDelaysMap; // a map storing <date : #delays>
  List<Map.Entry<String, Integer>> sortedDelays; // a sorted list of [date,#delays] based on date
  List<Integer> delayCounts; // get delays count orded by day1, day2, ... day 31
  SimpleDateFormat sdf;
  int maxDelayCount = 0;
  PFont customFont;

  // constructor, initializing all the class attributes
  DailyDelaysGraph() {
    dailyDelaysMap = new HashMap<>();
    sortedDelays = new ArrayList<>();
    delayCounts = new ArrayList<>();
    this.sdf = new SimpleDateFormat("dd/mm/yyyy");
    customFont = loadFont("AdelleSansDevanagari-Regular-48.vlw");
  }

  // The calculations for drawing graph have to be loaded an processed only once in setup() or
  // another initializtion section of the main, not continuouly recalculated in draw()
  void graphSetup(ArrayList<Flight> flights) {
    dailyDelaysMap = calculateDailyDelays(flights);
    // sortedDelays = {"2024/01/01"->10, "2024/01/02"->5, "2024/01/03"->7, ...}
    sortedDelays = new ArrayList<>(dailyDelaysMap.entrySet());
    // Sorting sortedDelays list ascending by dates
    Collections.sort(sortedDelays, (entry1, entry2) -> {
      Date date1 = parseDate(entry1.getKey());
      Date date2 = parseDate(entry2.getKey());
      return date1.compareTo(date2);
    }
    );
    delayCounts = getDelayCount(sortedDelays);
    maxDelayCount = getMaxDelayCount(sortedDelays);
  }

  void drawGraph() {
    float margin = 60;
    float graphWidth = width - (2 * margin);
    int numberOfDays = delayCounts.size();
    // radius within which to detect mouse proximity to a point
    float hitRadius = 10;
    //background(255);
    // Draw x and y axes
    stroke(255); // Set the line color to white
    line(margin, height - margin - 80, margin, margin + 80); // Y-axis, line(startX, startY, endX, endY) ->  added 80 to y2 and subtracted 80 from y1 to scale the graph M
    line(margin, height - margin - 80, width - margin, height - margin - 80); // X-axis -> subtracted 80 from y1, y2 to scale the graph M

    // Calculates the spacing(xSpacing) between each data point on the x-axis of a graph, based on the number of days
    // If there is only one day of data, xSpacing is set to the entire width of the graph
    float xSpacing = numberOfDays > 1 ? graphWidth / (numberOfDays - 1) : graphWidth;
    for (int day = 1; day < numberOfDays; day++) {
      // Calculate x and y positions
      float x = margin + (day - 1) * xSpacing;
      // Calculate y-coordiante in pixels, a day with zero delays maps to the bottom of the graph,
      // and a day with the maximum number of delays (maxDelayCount) maps to the top of the graph.
      // map(valueInList, lowerBoundInput, UpperBoundValueInput, lowerBoundOutputInPixel, upperBoundOutputInPixel)
      float y = map(delayCounts.get(day - 1), 0, maxDelayCount, height - margin, margin + 100);   //added 100 to scale the graph M

      // check if the mouse is close to this point
      if (dist(mouseX, mouseY, x, y) < hitRadius) {
        fill(255); // used for setting color for x labels
        // display th edelay count above and to the right of the point
        text(delayCounts.get(day-1) + " delays", x + 5, y - 5);
      }

      // Draw the data point
      stroke(17, 216, 230);
      fill(17, 216, 230);
      ellipse(x, y, 5, 5);
      // Draw date labels on the x-axis
      fill(255);
      textAlign(CENTER);
      // + 20: Adds 20 pixels to the height - margin value, effectively moving the text 20 pixels down from the x-axis line.  -> subtracted 80 to scale the graph M
      text(String.valueOf(day), x, height - margin - 80 + 20);

      // Draw a line connecting the current data point(x, y) to the previous day's data point(prevX, prevY)
      if (day > 1) {
        /*
        Calculates the x-coordinate (prevX) of the previous day's data point. The calculation uses (day - 2) because the array is
         zero-indexed (so day - 1 gives the zero-based index for the current day), and then subtracting one more positions it at the
         previous day. Multiplying by xSpacing determines how far along the x-axis this point is, based on the spacing between days,
         and margin offsets this position from the edge of the drawing area
         */
        float prevX = margin + (day - 2) * xSpacing;
        /*
        Calculates the y-coordinate (prevY) of the previous day's data point. It uses map() to scale the delay count from the data
         (delayCounts.get(day - 2)) into the drawable area of the graph. The scaling is from the range [0, maxDelayCount] to pixel
         coordinates [height - margin, margin], effectively mapping the data value to a vertical position within the graph
         */
        float prevY = map(delayCounts.get(day - 2), 0, maxDelayCount, height - margin, margin + 100);  //added 100 to scale the graph M
        stroke(17, 216, 230); // Set the color of the line to blue
        line(prevX, prevY, x, y);
        stroke(0); // changing the border color to black, so that the other shapes don't have a blue outline - Maria Ostrowska
      }
    }

    textFont(customFont, 16); // set the custom font with size 16
    // Y-axis label "Number of Delays"
    pushMatrix(); // Save the current transformation matrix
    translate(margin / 2, height / 2); // Shifts teh origin of the drawing context to the desired label position
    rotate(-HALF_PI); // Rotate text by 90 degrees clockwise, making the text orientation vertical
    text("Number of Delays", 0, 0); // Draw the text at (0,0), because of the rotate(), the text will appear verical along y-axis
    popMatrix(); // Restore the original transformation matrix

    text("Day of Month", width/2, height-margin/3 - 70);  //subtracted 70 to scale the graph M

    // Y-axis labels for max delay count
    textAlign(RIGHT);
    text("0", margin - 10, height - margin - 75);  //subtracted 70 to scale the graph M
    text(String.valueOf(maxDelayCount), margin - 10, margin + 105);  //added 105 to scale the graph
    stroke(0);
  }

  // helper method to get the number of delays each day from sortedDelays list, and put it in a list
  ArrayList<Integer> getDelayCount(List<Map.Entry<String, Integer>> sortedDelays) {
    ArrayList<Integer> delayCounts = new ArrayList<>();
    for (Map.Entry<String, Integer> entry : sortedDelays) {
      delayCounts.add(entry.getValue());
    }
    return delayCounts;
  }

  // helper method to parse the date string into a Date object, for sorting sortedDelays list by the ascending order of dates.
  Date parseDate(String dateString) {
    SimpleDateFormat sdf = new SimpleDateFormat("dd/mm/yyyy");
    try {
      return sdf.parse(dateString);
    }
    catch(ParseException e) {
      e.printStackTrace();
      return null;
    }
  }

  // a method to get the maximum delay count from the list
  int getMaxDelayCount(List<Map.Entry<String, Integer>> sortedDelays) {
    int max = 0;
    for (Map.Entry<String, Integer> entry : sortedDelays) {
      if (entry.getValue() > max) {
        max = entry.getValue();
      }
    }
    return max;
  }

  // date : number of deleys
  HashMap<String, Integer> calculateDailyDelays(ArrayList<Flight> flights) {
    for (int i=0; i<flights.size(); i++) {
      String date = flights.get(i).dateInfo.flightDate;
      if (flights.get(i).depTime.isEmpty()) {
        continue;
      }
      // determine if the flight was dalayed. a delay is if DepTime is after CRSDepTime.
      // some depTime is "", has to catch exceptions
      try {
        int depTime = Integer.parseInt(flights.get(i).depTime.trim());
        int crsDepTime = Integer.parseInt(flights.get(i).crsDepTime.trim());
        boolean isDelayed = depTime > crsDepTime;
        if (isDelayed) {
          if (dailyDelaysMap.containsKey(date)) {
            dailyDelaysMap.put(date, dailyDelaysMap.get(date) + 1);
          } else {
            dailyDelaysMap.put(date, 1);
          }
        }
      }
      catch(NumberFormatException e) {
        println(e.getMessage());
      }
    }
    return dailyDelaysMap;
  }
}
