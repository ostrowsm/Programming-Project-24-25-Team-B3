import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

HashMap<String, HashSet<Integer>> delays;

void setup() {
  background(255);
  size(1200, 800);
  delays = loadQueryData("flights_full_delays.txt");
  printKeys();
}

HashMap<String, HashSet<Integer>> loadQueryData(String fileName) {
  String[] lines = loadStrings(fileName);
  HashMap<String, HashSet<Integer>> delays = new HashMap<>();

  for (String line : lines) {
    String[] curr = line.split("  ");
    String k = curr[0];
    String[] ids = curr[1].split(",");
    HashSet<Integer> data = new HashSet<>();

    for (String id : ids) {
      try {
        int num = Integer.parseInt(id);
        data.add(num);
      } catch (NumberFormatException e) {
        continue;
      }
    }
    delays.put(k, data);
  }
  return delays;
}

void printKeys() {
  List<String> sortedKeys = new ArrayList<>(delays.keySet());
  Collections.sort(sortedKeys, (key1, key2) -> {
    int num1 = extractNumber(key1);
    int num2 = extractNumber(key2);
    return Integer.compare(num1, num2);
  });

  for (String key : sortedKeys) {
    System.out.println(key);
  }
}

void draw() {
  background(255);
  stroke(128, 128, 128);
  line(50, 50, 50, 750); // Y-axis
  line(50, 750, 1150, 750); // X-axis

  int histogramHeight = 650;
  int[] intervals = {5, 10, 15, 20, 25, 30, 45, 60, 120, 180, 240, 300, 1440};
  int barWidth = 1100 / intervals.length;

  int[] intervalCounts = new int[intervals.length]; // array to store counts for each interval

  // Calculate counts for each interval
  for (String key : delays.keySet()) {
    if (key.matches("\\d+")) { //check for only nums
      int num = Integer.parseInt(key);
      for (int i = 0; i < intervals.length; i++) {
        if (num <= intervals[i]) {
          intervalCounts[i] += delays.get(key).size(); // add up the count of delays for the interval
          break;
        }
      }
    }
  }

  // Calculate maximum frequency
  int maxFrequency = 0;
  for (int count : intervalCounts) {
    maxFrequency = Math.max(maxFrequency, count);
  }

  // Draw histogram bars and handle mouse hover
  for (int i = 0; i < intervals.length; i++) {
    fill(17, 216, 230); stroke(128, 128, 128);
    int x = 50 + i * barWidth;
    int barHeight = (int) map(intervalCounts[i], 0, maxFrequency, 0, histogramHeight);
    int y = 750 - barHeight;
    drawGradientRect(x, y, barWidth, barHeight);

    // Check if mouse is over bar
    if (mouseX >= x && mouseX <= x + barWidth && mouseY >= y && mouseY <= 750) {
      fill(0);
      textAlign(CENTER, BOTTOM);
      text(intervalCounts[i], x + barWidth / 2, y - 5);
    }

    fill(0, 0, 255);
    textAlign(CENTER);
    text(intervals[i], x + barWidth / 2, 770);
  }

  // Axes labels
  fill(0);
  translate(30, height / 2);
  rotate(-HALF_PI);
  textAlign(CENTER, CENTER);
  text("Number of Planes", 0, 0);
  rotate(HALF_PI);
  translate(-30, -height / 2);

  textAlign(CENTER, BOTTOM);
  text("Lateness in minutes", width / 2, height - 10);
}

int extractNumber(String s) {
  String[] parts = s.split("\\D+");
  for (String part : parts) {
    if (!part.isEmpty()) {
      return Integer.parseInt(part);
    }
  }
  return 0;
}

void drawGradientRect(int x, int y, int width, int height) {
  for (int i = 0; i < height; i++) {
    float inter = map(i, 0, height, 0, 1);
    int c = lerpColor(color(17, 216, 230), color(255, 120, 0), inter);
    stroke(c);
    line(x, y + i, x + width, y + i);
  }
}
