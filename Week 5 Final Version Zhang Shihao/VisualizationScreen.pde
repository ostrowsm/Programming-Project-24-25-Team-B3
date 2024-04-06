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

        parent.fill(255, 0, 0);
        parent.rect(100, 100, 50, departureFlights * 5);

        parent.fill(0, 0, 255); 
        parent.rect(200, 100, 50, arrivalFlights * 5); 
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
