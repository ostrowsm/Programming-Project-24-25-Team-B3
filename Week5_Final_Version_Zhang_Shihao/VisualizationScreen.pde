class VisualizationScreen {
    PApplet parent;
    int departureFlights;
    int arrivalFlights;
    String airportCode;
    Date startDate;
    Date endDate;
    JButton backButton;
    CalendarView calendarView; 

    VisualizationScreen(PApplet parent, CalendarView calendarView) {
        this.parent = parent;
        this.calendarView = calendarView; // Store the instance of CalendarView
        this.airportCode = calendarView.airportCodeField.getText().toUpperCase();
        this.startDate = calendarView.startModel.getValue();
        this.endDate = calendarView.endModel.getValue();
        loadData(); // Load flight data for visualization


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
    int maxFlights = Math.max(departureFlights, arrivalFlights);
    int maxHeight = parent.height - 200; // Adjust the available height based on your screen layout

    int departureBarHeight = (int) parent.map(departureFlights, 0, maxFlights, 0, maxHeight);
    int arrivalBarHeight = (int) parent.map(arrivalFlights, 0, maxFlights, 0, maxHeight);
  
    // x-axis
    parent.line(150, 150 + maxHeight, 500, 150 + maxHeight);
    parent.text("Departure                                                                 Arrival", 200, 170 + maxHeight); 

    // y-axis
    parent.line(150, 150, 150, 150 + maxHeight);
    parent.text("Flights", 100, 140);

    //departure flights bar
    parent.fill(255, 0, 0);
    parent.rect(200, 150 + maxHeight - departureBarHeight, 50, departureBarHeight);
    parent.textAlign(parent.CENTER, parent.CENTER);
    parent.fill(0);
    parent.text(departureFlights, 200 + 25, 140 + maxHeight - departureBarHeight - 5);

    //arrival flights bar
    parent.fill(0, 0, 255);
    parent.rect(400, 150 + maxHeight - arrivalBarHeight, 50, arrivalBarHeight);
    parent.textAlign(parent.CENTER, parent.CENTER);
    parent.fill(0);
    parent.text(arrivalFlights, 400 + 25, 140 + maxHeight - arrivalBarHeight - 5);
}



    void handleMouseClick() {

        if (parent.mousePressed && parent.mouseX >= backButton.getX() && parent.mouseX <= backButton.getX() + backButton.getWidth() &&
                parent.mouseY >= backButton.getY() && parent.mouseY <= backButton.getY() + backButton.getHeight()) {
  
            System.out.println("Back button clicked");

            returnAction(null); 
        }
    }

    void returnAction(ActionEvent e) {
        System.out.println("Return button clicked");
      
        PApplet.main("YourMainSketchClass"); 
    }
}
