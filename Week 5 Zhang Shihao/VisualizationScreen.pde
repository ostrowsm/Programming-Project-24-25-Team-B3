class VisualizationScreen {
    PApplet parent;
    int departureFlights;
    int arrivalFlights;
    String airportCode;
    Date startDate;
    Date endDate;
    JButton backButton;
    CalendarView calendarView; // Add a field to store the instance of CalendarView

    VisualizationScreen(PApplet parent, CalendarView calendarView) {
        this.parent = parent;
        this.calendarView = calendarView; // Store the instance of CalendarView
        this.airportCode = calendarView.airportCodeField.getText().toUpperCase();
        this.startDate = calendarView.startModel.getValue();
        this.endDate = calendarView.endModel.getValue();
        loadData(); // Load flight data for visualization

        // Create and configure the back button
        backButton = new JButton("Back");
        backButton.addActionListener(e -> returnAction(e));
    }

    void loadData() {
        departureFlights = countDepartureFlights();
        arrivalFlights = countArrivalFlights();
    }

    int countDepartureFlights() {
        int count = 0;
        for (Flight flight : flights) {
            if (flight.matchesCriteria(startDate, endDate, airportCode, null) && flight.origin.equals(airportCode)) {
                count++;
            }
        }
        return count;
    }

    int countArrivalFlights() {
        int count = 0;
        for (Flight flight : flights) {
            if (flight.matchesCriteria(startDate, endDate, airportCode, null) && flight.destination.equals(airportCode)) {
                count++;
            }
        }
        return count;
    }

    void drawVisualization() {
        // Draw bar chart
        // Here, we use the rect() function in Processing to draw rectangular bar chart
        // The height of the rectangle can be determined based on the values of departureFlights and arrivalFlights
        parent.fill(255, 0, 0); // Red color indicates the number of departure flights
        parent.rect(100, 100, 50, departureFlights * 5); // Draw bar chart for the number of departure flights

        parent.fill(0, 0, 255); // Blue color indicates the number of arrival flights
        parent.rect(200, 100, 50, arrivalFlights * 5); // Draw bar chart for the number of arrival flights
    }

    void handleMouseClick() {
        // Handle mouse click event here
        // For example:
        if (parent.mousePressed && parent.mouseX >= backButton.getX() && parent.mouseX <= backButton.getX() + backButton.getWidth() &&
                parent.mouseY >= backButton.getY() && parent.mouseY <= backButton.getY() + backButton.getHeight()) {
            // If the mouse is pressed within the area of the back button
            System.out.println("Back button clicked");
            // Add your code to handle back button click event
            returnAction(null); // Call returnAction method to go back to the flight information display
        }
    }

    void returnAction(ActionEvent e) {
        System.out.println("Return button clicked");
        // Hide the application window
        PApplet.main("YourMainSketchClass"); // Replace "YourMainSketchClass" with the name of your main sketch class
    }
}
