// Author: Hao She

// PApplet is a library, which serves as the base for any sketch that uses Processing in a Java environment
import processing.core.PApplet;
import java.util.ArrayList;

ArrayList<Flight> histogramFlights;
String histogramAirportCode;
String histogramStartDate, histogramEndDate;

public class FlightHistogram extends PApplet {

  public FlightHistogram() {
    super();
  }

  // screen size
  public void settings() {
    size(600, 400);
  }

  public void setup() {
    background(255); // white
    noLoop(); // prevent draw() loop
    drawHistogram();
  }

  void drawHistogram() {
    int departuresCount = 0;
    int arrivalsCount = 0;
    // computing amount of departure and arrival flights based on the static variables
    for (Flight flight : histogramFlights) {
      if (flight.airport.origin.equals(histogramAirportCode)) {
        departuresCount++;
      }
      if (flight.airport.destination.equals(histogramAirportCode)) {
        arrivalsCount++;
      }
    }
    // draw departure flights histogram
    fill(100, 150, 255); // sky-blue-like color
    // x:100; y: departuresCount*5 dynamically adjusts the y-coordinate, subtracting it from 350 to make it taller
    // width: rectangle will be 100 pixels wide; height: it depends on teh departuresCount, increasing by 5 pixels for each unit
    rect(100, 350 - departuresCount * 5, 100, departuresCount * 5);
    textAlign(CENTER);
    text("Departures: " + departuresCount, 150, 365); // x(150), y(365)

    // draw arrival flights histogram
    fill(255, 150, 100); // orangish color
    rect(300, 350 - arrivalsCount * 5, 100, arrivalsCount * 5);
    text("Arrivals: " + arrivalsCount, 350, 365);
  }
}
