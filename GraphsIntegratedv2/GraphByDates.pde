//John Liu
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Arrays;

HashMap<String, HashSet<Integer>> dates;

void setup4() {
  //background(255);
  //size(1000, 800);
  dates = loadQueryData2("flights_full_dates.txt");
  printKeys2();
}

//Hubert Stanowski
HashMap<String, HashSet<Integer>> loadQueryData2(String fileName) {
  String[] lines = loadStrings(fileName);
  HashMap<String, HashSet<Integer>> count = new HashMap<String, HashSet<Integer>>();

  for (String line : lines) {
    String[] curr = line.split("  ");
    String k = curr[0];
    String[] ids = curr[1].split(",");
    HashSet<Integer> data = new HashSet<>();

    for (String id : ids) {
      try {
        int num = Integer.parseInt(id);
        data.add(num);
      }
      catch (NumberFormatException e) {
        continue;
      }
    }
    count.put(k, data);
  }
  return count;
}

//Jan
HashSet<Integer> getFlightsOnDate(String date)
{
  HashSet<Integer> flightsOnDate = dates.get(date);
  return flightsOnDate;
}

//John Liu
void printKeys2() {
  List<String> sortedKeys = new ArrayList<>(dates.keySet()); //sort in ascending order
  Collections.sort(sortedKeys, (key1, key2) -> {
    int num1 = extractNumber2(key1);
    int num2 = extractNumber2(key2);
    return Integer.compare(num1, num2);
  }
  );

  /*for (String key : sortedKeys) {
    System.out.println(key);
  }*/
}

//Maria Ostrowska - adjusting the parameters for neat graphical presentation

void draw4() {
  // background(255);
  height = 825;
  width = 1000;

  stroke(128, 128, 128);
  line(45, 200, 45, 650); // Y-axis
  line(45, 650, 980, 650); // X-axis
  
  //Jan
  String[] dateStrings = {"1/1/2022 12:00:00 AM", "1/2/2022 12:00:00 AM", "1/3/2022 12:00:00 AM", "1/4/2022 12:00:00 AM", 
  "1/5/2022 12:00:00 AM", "1/6/2022 12:00:00 AM", "1/7/2022 12:00:00 AM", "1/8/2022 12:00:00 AM", "1/9/2022 12:00:00 AM", 
  "1/10/2022 12:00:00 AM", "1/11/2022 12:00:00 AM", "1/12/2022 12:00:00 AM","1/13/2022 12:00:00 AM", 
  "1/14/2022 12:00:00 AM", "1/15/2022 12:00:00 AM", "1/16/2022 12:00:00 AM", "1/17/2022 12:00:00 AM", 
  "1/18/2022 12:00:00 AM", "1/19/2022 12:00:00 AM", "1/20/2022 12:00:00 AM", "1/21/2022 12:00:00 AM", 
  "1/22/2022 12:00:00 AM", "1/23/2022 12:00:00 AM", "1/24/2022 12:00:00 AM", "1/25/2022 12:00:00 AM", 
  "1/26/2022 12:00:00 AM", "1/27/2022 12:00:00 AM", "1/28/2022 12:00:00 AM", "1/29/2022 12:00:00 AM", 
  "1/30/2022 12:00:00 AM", "1/31/2022 12:00:00 AM"};

  //John
  int histogramHeight = 450;
  int[] intervals = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 
      26, 27, 28, 29, 30, 31};
  int barWidth = 800 / intervals.length;


  //Jan
  int[] flightsOnDateCount = new int[dateStrings.length];

  for (int i = 0; i < dateStrings.length; i++)
  {
    String day = dateStrings[i];
    //println(day);
    HashSet<Integer> flightsOnDate = getFlightsOnDate(day);
    flightsOnDateCount[i] = flightsOnDate.size();
  }
  
  // Calculate maximum frequency - John Liu
  int maxFrequency = 0;
  for (int count : flightsOnDateCount) {
    maxFrequency = Math.max(maxFrequency, count);
  }
  // Draw histogram bars
  int space = 0;
  int level = 15; // the count labels are writing over each other, this variable helps to solve that issue
  for (int i = 0; i < intervals.length; i++) {
    int x = 50 + i * barWidth + space;
    int y = 650 - (int) map(flightsOnDateCount[i], 0, maxFrequency, 0, histogramHeight);
    int barHeight = (int) map(flightsOnDateCount[i], 0, maxFrequency, 0, histogramHeight);
    drawGradientRect2(x, y, barWidth, barHeight);

    textAlign(CENTER, BOTTOM);
    textSize(15);
    fill(255);
    text(flightsOnDateCount[i], x + barWidth / 2, y - 3 - level);
    fill(255);

    textAlign(CENTER);
    text(intervals[i], x + barWidth / 2, 665);
    space += 5;
    
    if(level == 0){ level = 15;}
    else{ level = 0;}
  }
  text(maxFrequency, 25, 215);
  //axes labels
  translate(30, height / 2);
  rotate(-HALF_PI);
  //textAlign(CENTER, CENTER);
  textSize(20);
  text("Number of Flights", 0, 0);
  rotate(HALF_PI);
  translate(-30, -height / 2);

  //textAlign(CENTER, BOTTOM);
  text("Days of the month", width/2, height-125);
  stroke(0);
}

int extractNumber2(String s) { //take out the first num aka delay time
  String[] parts = s.split("\\D+");
  for (String part : parts) {
    if (!part.isEmpty()) {
      return Integer.parseInt(part);
    }
  }
  return 0;
}

//colourful bars
void drawGradientRect2(int x, int y, int width, int height) {
  for (int i = 0; i < height; i++) {
    float inter = map(i, 0, height, 0, 1);
    int c = lerpColor(color(64, 31, 113), color(253, 175, 123), inter);
    stroke(c);
    line(x, y + i, x + width, y + i);
  }
}
