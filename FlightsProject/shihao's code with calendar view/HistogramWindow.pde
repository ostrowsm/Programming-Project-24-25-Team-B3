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
    size(1000, 800); // 设置画布大小为1300x1100
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
      textAlign(CENTER, BOTTOM);
    
      int xOffset = 50; // X-axis offset
      int yOffset = height - 150; // Y-axis offset from bottom
      int barWidth = 20; // Width of each histogram bar
      int maxBarHeight = 300; // Max height of histogram bars
      int spacing = 15; // Increased spacing between bars
    
      float maxCount = Math.max(departureCounts.values().stream().max(Integer::compare).orElse(0),
                                arrivalCounts.values().stream().max(Integer::compare).orElse(0));
      float scale = maxBarHeight / maxCount; // Scale factor for bar heights
      
      int i = 0;
      for (Map.Entry<String, Integer> entry : departureCounts.entrySet()) {
        int departureBarHeight = (int)(entry.getValue() * scale);
        fill(100, 100, 250); // Departure bar color
        int depXPos = xOffset + i * (barWidth * 2 + spacing);
        rect(depXPos, yOffset - departureBarHeight, barWidth, departureBarHeight);
        fill(0);
        text(entry.getValue().toString(), depXPos + barWidth / 2, yOffset - departureBarHeight - 5); // Show departure count
        
        Integer arrivalCount = arrivalCounts.getOrDefault(entry.getKey(), 0);
        int arrivalBarHeight = (int)(arrivalCount * scale);
        fill(250, 100, 100); // Arrival bar color
        int arrXPos = depXPos + barWidth; // Positioned next to the departure bar
        rect(arrXPos, yOffset - arrivalBarHeight, barWidth, arrivalBarHeight);
        text(arrivalCount.toString(), arrXPos + barWidth / 2, yOffset - arrivalBarHeight - 5); // Show arrival count
        
        fill(0);
        text(entry.getKey(), depXPos + barWidth, yOffset + 20); // Date labels
        
        i++;
      }
  }
}
