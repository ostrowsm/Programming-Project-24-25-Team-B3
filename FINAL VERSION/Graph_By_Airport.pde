//Jan Zacarias Garcia
import java.util.*;
import java.util.Map;
import java.util.HashSet;
import java.util.Arrays;

HashMap<String, HashSet<Integer>> airports;
// Hubert Stanowski
HashMap<String, HashSet<Integer>> loadQueryData1(String filename)
{
  String[] lines = loadStrings(filename);
  HashMap<String, HashSet<Integer>> map = new HashMap<String, HashSet<Integer>>();
  for (int i = 0; i<lines.length; i++)
  {
    String[] curr = lines[i].split("  ");
    String k = curr[0];
    String[] ids = curr[1].split(",");
    HashSet<Integer> data = new HashSet<Integer>();
    for (int j = 0; j < ids.length; j++)
    {
      data.add(Integer.parseInt(ids[j]));
    }
    map.put(k, data);
  }

  return map;
}
//Jan Zacarias Garcia
void setup3() {
  //background(255);
  //size(1470, 840);
  airports = loadQueryData1("flights_full_airports.txt");
  printKeys1();
}


HashSet<Integer> getFlightsByAirport(String airport)
{
  HashSet<Integer> flightsFromAirport = airports.get(airport);
  //println(airports.get(airport));
  //println("");

  return flightsFromAirport;
}
void printKeys1() {
  List<String> sortedKeys = new ArrayList<>(airports.keySet());
  Collections.sort(sortedKeys, (key1, key2) -> {
    int num1 = extractNumber1(key1);
    int num2 = extractNumber1(key2);
    return Integer.compare(num1, num2);
  });

  /*for (String key : sortedKeys) {
    System.out.print("'" + key +"'"+", ");
  }*/
}
void draw3() {
  String[] airCode = {"JAX","DFW","STL","HNL","MIA","LGA","IAD","SEA","IAH",
                      "HOU","CVG","RSW","FLL","SFO","RDU","ATL","JFK","ORD",
                      "BWI","AUS","OAK","SJC","PDX","CLE","CLT","SLC","CMH",
                      "SMF","TPA","SNA","PHL","PHX","MSP","DAL","MSY","MCI",
                      "BNA","LAN","PIT","LAS","LAX","MDW","DCA","BOS","IND",
                      "SAN","DTW","EWR","DEN","BUR"};
  //background(225);
  height = 825;
  width = 1000;
  
  stroke(128, 128, 128);
  line(50, 175, 50, 750); // Y-axis
  line(50, 750, 1310, 750); // X-axis

  int histogramHeight = 550;
  int barWidth = 18; 

  // Initialize array to store counts for each airport
  int[] airportCounts = new int[airCode.length];

  // Iterate through each airport
  for (int i = 0; i < airCode.length; i++) {
    String airport = airCode[i];
    HashSet<Integer> flightsFromAirport = getFlightsByAirport(airport);
    airportCounts[i] = flightsFromAirport.size();
  }

  // Calculate maximum frequency
  int maxFrequency = Arrays.stream(airportCounts).max().orElse(0);

  // Draw histogram bars and labels
  for (int i = 0; i < airportCounts.length; i++) {
    fill(17, 216, 230); stroke(128, 128, 128);
    int x = 52 + i * (barWidth + 9); // Adjust spacing between bars
    int barHeight = (int) map(airportCounts[i], 0, maxFrequency, 0, histogramHeight);
    int y = 751 - barHeight;
    drawGradientRect1(x, y, barWidth, barHeight);

    // Display count above the bar
    fill(255);
    textAlign(CENTER, BOTTOM);
    text(airportCounts[i], x + barWidth / 2, y - 5);

    // Display airport code below the bar (rotated)
    fill(255);
    textAlign(CENTER, TOP);
    translate((x + barWidth / 2) - 5, 770); // Move origin to center of the text
    rotate(-HALF_PI); // Rotate text by -90 degrees (clockwise)
    text(airCode[i], 0, 0);
    rotate(HALF_PI); // Reset rotation
    translate(-((x + barWidth / 2) - 5), -770); // Reset origin
  }

  // Axes labels
  fill(255);
  textSize(20);
  textAlign(CENTER, BOTTOM);
  translate(30, height / 2);
  rotate(-HALF_PI);
  text("Number of Planes", 0, 0); // Rotate label by 90 degrees
  rotate(HALF_PI);
  translate(-30, -height / 2);
  textAlign(CENTER, CENTER);
  text("Airports", (width + 500) / 2, height - 25);
  textSize(15);
  stroke(0);
}

int extractNumber1(String s) {
  String[] parts = s.split("\\D+");
  for (String part : parts) {
    if (!part.isEmpty()) {
      return Integer.parseInt(part);
    }
  }
  return 0;
}
void drawGradientRect1(int x, int y, int width, int height) {
  for (int i = 0; i < height; i++) {
    float inter = map(i, 0, height, 0, 1);
    int c = lerpColor(color(144, 238, 144), color(1, 50, 32), inter);
    stroke(c);
    line(x, y + i, x + width, y + i);
  }
}
