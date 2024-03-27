import java.util.ArrayList;
import java.util.HashMap;

class FlightHistogram {
  HashMap<String, Integer> departureCounts = new HashMap<>();
  HashMap<String, Integer> arrivalCounts = new HashMap<>();
  
  // Updated to accept airport code for focused counting
  void processFlightsForHistogram(ArrayList<Flight> flights, String airportCode) {
    departureCounts.clear();
    arrivalCounts.clear();
    
    for (Flight flight : flights) {
      // Assuming FlightDateInfo includes a method to get the date in "yyyy-MM-dd" format
      String date = flight.dateInfo.getSimpleDate();
      
      if (flight.origin.equals(airportCode)) {
        departureCounts.put(date, departureCounts.getOrDefault(date, 0) + 1);
      }
      if (flight.destination.equals(airportCode)) {
        arrivalCounts.put(date, arrivalCounts.getOrDefault(date, 0) + 1);
      }
    }
  }

  void launchHistogramWindow() {
    String[] processingArgs = {"Flight Histogram"};
    PApplet.runSketch(processingArgs, new HistogramWindow(departureCounts, arrivalCounts));
  }
}
