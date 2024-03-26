import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

HashMap<String, HashSet<Integer>> airports;

void setup() {
  background(255);
  size(1200, 800);
  airports = loadQueryData("flights_full_airports.txt");
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
  List<String> sortedKeys = new ArrayList<>(airports.keySet());
  Collections.sort(sortedKeys, (key1, key2) -> {
    int num1 = extractNumber(key1);
    int num2 = extractNumber(key2);
    return Integer.compare(num1, num2);
  });

  for (String key : sortedKeys) {
    System.out.print(""" + key +"""+", ");
  }
}

void draw() {
  background(255);
  stroke(128, 128, 128);
  line(50, 50, 50, 750); // Y-axis
  line(50, 750, 1150, 750); // X-axis

  int histogramHeight = 650;
  String[] intervals = {"JAX", "TVC", "RAP", "CDC", "STC", "KTN", "BRW", "HNL", "STL", "XNA", "MHK", "STT", "STS", "DFW", "PNS", 
  "SDF", "CDV", "STX", "LWB", "MHT", "HOB", "LFT", "EYW", "OMA", "TWF", "MIA", "LGB", "OME", "LGA", "MYR", "LWS", "JST", "IAD",
  "SUN", "SEA", "IAG", "HOU", "IAH", "RST", "CVG", "RSW", "SUX", "BTM", "FLG", "BTR", "YAK", "ART", "ABE", "BTV", "TXK", "PPG", 
  "FLL", "HPN", "ABI", "FLO", "BDL", "DHN", "CWA", "GNV", "SFB", "VLD", "ABQ", "ABR", "BUF", "ASE", "RDD", "ONT", "ABY", "RDM", 
  "LYH", "SFO", "BUR", "RDU", "SWF", "CGI", "MKE", "ISP", "DIK", "EKO", "MKG", "PQI", "LIH", "SWO", "TYR", "TYS", "BET", "ACT", 
  "SGF", "ACV", "PAE", "LIT", "PAH", "ACY", "ATL", "ICT", "ITH", "CHA", "SGU", "PRC", "MLB", "HRL", "BFF", "ATW", "ITO", "ATY", 
  "IDA", "ELM", "ELP", "ADK", "BFL", "GPT", "MLI", "CHO", "FNT", "JFK", "ADQ", "SHD", "CHS", "RFD", "PBG", "BWI", "PBI", "MLU", 
  "FOD", "CYS", "SHR", "AUS", "CID", "SHV", "PSC", "PSE", "PSG", "BGM", "HSV", "PSM", "PSP", "BGR", "SYR", "CIU", "YUM", "AEX", 
  "GRB", "AVL", "OAK", "OAJ", "AVP", "DLG", "GRI", "SIT", "ORD", "GRK", "DLH", "ORF", "ORH", "BHM", "GRR", "HTS", "SJC", "WRG", 
  "TLH", "RHI", "HDN", "VPS", "CKB", "SJT", "PUB", "SJU", "BIH", "MOB", "GSO", "BIL", "GSP", "PDX", "GCC", "RIC", "BIS", "AGS", 
  "GCK", "FAI", "PUW", "MOT", "FAR", "BZN", "FAT", "GTF", "CLE", "PVD", "FAY", "BJI", "RIW", "CLL", "OTH", "GTR", "LNK", "CLT", 
  "SLC", "PVU", "GUC", "OTZ", "SLN", "FSD", "CMI", "GUM", "CMH", "FSM", "XWA", "FCA", "PWM", "GEG", "AZA", "PGD", "SMF", "CMX", 
  "TOL", "MQT", "HGR", "MAF", "AZO", "EAR", "EAU", "EAT", "RKS", "ERI", "PGV", "BLI", "SMX", "TPA", "VCT", "SNA", "HHH", "GFK", 
  "BLV", "JLN", "PHF", "CNY", "ESC", "PHL", "MRY", "COD", "OWB", "KOA", "BMI", "MBS", "HIB", "PHX", "USA", "HYS", "DAB", "AKN", 
  "COS", "GGG", "MSO", "COU", "PIB", "MSN", "PIA", "MSP", "PIE", "OGD", "OGG", "DAL", "PIH", "JMS", "MSY", "MCI", "ECP", "BNA", 
  "ALB", "MCO", "LAN", "PIR", "PIT", "YKM", "OGS", "VEL", "LAR", "DAY", "LAS", "LRD", "DRO", "MCW", "LAX", "MTJ", "LAW", "ALO", 
  "CPR", "ILG", "DRT", "ALS", "TRI", "ILM", "ALW", "LBB", "SPI", "LBE", "JNU", "SPN", "FWA", "LBF", "RNO", "DBQ", "AMA", "EUG", 
  "SPS", "LBL", "MDT", "BOI", "DSM", "LSE", "MDW", "TBN", "DCA", "ROA", "CAE", "BOS", "ROC", "CAK", "LCH", "MEI", "IMT", "MEM", 
  "LCK", "ANC", "SAF", "ROW", "IND", "CRP", "SAN", "DDC", "EVV", "DTW", "INL", "SAT", "BPT", "SAV", "CRW", "HLN", "MFE", "TTN", 
  "GJT", "SBA", "SRQ", "PLN", "CSG", "MFR", "EWN", "BQK", "SBN", "BQN", "SBP", "EWR", "EGE", "DEC", "OKC", "TUL", "SBY", "DEN", 
  "JAC", "MGM", "SCC", "TUS", "SCE", "BRD", "JAN", "SCK", "DVL", "LEX"};
  int barWidth = 1100 / intervals.length;

  int[] intervalCounts = new int[intervals.length]; // array to store counts for each interval

  // Calculate counts for each interval
  for (String key : airports.keySet()) {
    if (key.matches("\\d+")) { //check for only nums
      int num = Integer.parseInt(key);
      for (int i = 0; i < intervals.length; i++) {
          intervalCounts[i] += airports.get(key).size(); // add up the count of delays for the interval
        }
      }
    }

  // Calculate maximum frequency;
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
  text("Airports", width / 2, height - 10);
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
