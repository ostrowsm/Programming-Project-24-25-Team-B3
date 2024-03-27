import processing.core.PApplet;
import java.util.HashMap;
import java.util.Map;

public class HistogramWindow extends PApplet {
  HashMap<String, Integer> departureCounts;
  HashMap<String, Integer> arrivalCounts;

  public HistogramWindow(HashMap<String, Integer> departureCounts, HashMap<String, Integer> arrivalCounts) {
    this.departureCounts = departureCounts;
    this.arrivalCounts = arrivalCounts;
  }

  public void settings() {
    size(800, 600);
  }

  public void setup() {
    fill(120);
  }

  public void draw() {
    background(255);
    drawHistogram();
  }

  void drawHistogram() {
    textSize(12);
    textAlign(LEFT, CENTER);

    int xOffset = 50; // X-axis offset
    int yOffset = height - 100; // Y-axis offset from bottom
    int barWidth = 20; // Width of each histogram bar
    int maxBarHeight = 200; // Max height of histogram bars
    int spacing = 5; // Spacing between bars
    
    int maxCount = Math.max(departureCounts.values().stream().max(Integer::compare).orElse(0),
                            arrivalCounts.values().stream().max(Integer::compare).orElse(0));
    float scale = maxBarHeight / (float)maxCount; // Scale factor for bar heights based on max count
    
    int i = 0;
    for (Map.Entry<String, Integer> entry : departureCounts.entrySet()) {
      int departureBarHeight = (int)(entry.getValue() * scale);
      fill(100, 100, 250); // Departure bar color
      rect(xOffset + i * (barWidth * 2 + spacing), yOffset - departureBarHeight, barWidth, departureBarHeight);
      fill(0);
      text(entry.getKey(), xOffset + i * (barWidth * 2 + spacing), yOffset + 15); // Date labels
      
      Integer arrivalCount = arrivalCounts.getOrDefault(entry.getKey(), 0);
      int arrivalBarHeight = (int)(arrivalCount * scale);
      fill(250, 100, 100); // Arrival bar color
      rect(xOffset + i * (barWidth * 2 + spacing) + barWidth, yOffset - arrivalBarHeight, barWidth, arrivalBarHeight);
      
      i++;
    }
  }
}
