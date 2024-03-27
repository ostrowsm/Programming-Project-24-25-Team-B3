class FlightInfoScreen {
  int flightsStartY = 100; // Starting Y position for displaying flights
  int lineSpacing = 20;   // Spacing between lines of text

  void display() {
    inputScreen.fill(0); // Assuming black text
    inputScreen.textAlign(LEFT, TOP); // Align text to the left and top
    int yPos = flightsStartY;
    
    // Check if matchingFlights is empty
    if (matchingFlights.isEmpty()) {
      inputScreen.text("No matching flights found.", 50, yPos);
    } else {
      // Loop through each flight and display its information
      for (Flight flight : matchingFlights) {
        String flightInfo = flight.iataCode + " " + flight.flightNumber + " from " + flight.airport.originCityName +
                            " to " + flight.airport.destCityName + " on " + flight.dateInfo.flightDate;
        inputScreen.text(flightInfo, 50, yPos);
        yPos += lineSpacing; // Move down for the next flight
      }
    }

    drawReturnButton();
    drawVisualizeButton();
  }
}
