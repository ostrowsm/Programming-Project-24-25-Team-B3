import javax.swing.*;
import org.jdatepicker.impl.JDatePanelImpl;
import org.jdatepicker.impl.JDatePickerImpl;
import org.jdatepicker.impl.UtilDateModel;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.*;
import controlP5.*;

PImage bg;
ControlP5 cp5;
PApplet inputScreen;
ArrayList<Flight> flights = new ArrayList<>();
ArrayList<Flight> matchingFlights = new ArrayList<>();
final Object lock = new Object(); 
boolean sortedDescending = false;
boolean visualizationRequested = false; // Flag to indicate if visualization is requested
CalendarView calendarView; // Add a field to store the instance of CalendarView

void setup() {
    size(1300, 700);
    bg = loadImage("databg.jpeg");
    inputScreen = this;
    loadFlights("flights_full.csv");
    cp5 = new ControlP5(this);
    

    calendarView = new CalendarView(this);
    

    noLoop();
}

void draw() {
    synchronized(lock) {
        background(240);
        image (bg, 0, 0);
        fill(0);
        textSize(12);
        textAlign(LEFT, TOP);
        
        ArrayList<Flight> flightsCopy = new ArrayList<>(matchingFlights);
        
        if (sortedDescending) {
            Collections.sort(flightsCopy, Collections.reverseOrder());
        }
        
        int y = 20;
        for (Flight flight : flightsCopy) {
            if (y > height - 20) break; 
            text(flight.toString(), 10, y);
            y += 20;
        }
    }
    
    if (visualizationRequested) {
        background(240);
        VisualizationScreen visualizationScreen = new VisualizationScreen(inputScreen, calendarView);
        visualizationScreen.drawVisualization();
    }
}

void performVisualization() {
    Date startDate = calendarView.startModel.getValue() != null ? calendarView.startModel.getValue() : null;
    Date endDate = calendarView.endModel.getValue() != null ? calendarView.endModel.getValue() : null;
    String airportCode = calendarView.airportCodeField.getText().toUpperCase();

    VisualizationScreen visualizationScreen = new VisualizationScreen(inputScreen, calendarView);
    visualizationScreen.drawVisualization();
}

void loadFlights(String filename) {
    Table table = loadTable(filename, "header");
    for (TableRow row : table.rows()) {
        flights.add(new Flight(
                row.getString("MKT_CARRIER"),
                row.getString("MKT_CARRIER_FL_NUM"),
                row.getString("ORIGIN"),
                row.getString("DEST"),
                row.getString("FL_DATE"),
                row.getString("CANCELLED").equals("1"),
                row.getString("DIVERTED").equals("1")
        ));
    }
}

void submitButton() {
    SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
    try {
        Date startDate = new Date();
        Date endDate = new Date();
        String airportCode = "JFK";
        String airlineCode = "AA";

        matchingFlights.clear();
        for (Flight flight : flights) {
            if (flight.matchesCriteria(startDate, endDate, airportCode, airlineCode)) {
                matchingFlights.add(flight);
            }
        }
        inputScreen.redraw();
    } catch (Exception ex) {
        ex.printStackTrace();
    }
}

void sortButton() {
    // Sort button click event
    sortedDescending = !sortedDescending;
    inputScreen.redraw();
}

void visualizationAction(ActionEvent e) {
    visualizationRequested = true;
    performVisualization(); // Call performVisualization() method
    inputScreen.redraw();
}

void returnAction(ActionEvent e) {
    System.out.println("Return button clicked");
    visualizationRequested = false; // Set visualizationRequested flag to false to return to flight information display
    inputScreen.redraw();
}
