import java.util.ArrayList;
import processing.data.Table;
import processing.data.TableRow;
import java.text.SimpleDateFormat;
import java.util.Date;

ArrayList<Flight> flights = new ArrayList<Flight>();
String startDate = "", endDate = "", airportCode = "";
boolean buttonPressed = false;
int buttonX = 250, buttonY = 220, buttonWidth = 100, buttonHeight = 40;
int inputBoxY = 30, inputBoxWidth = 200, inputBoxHeight = 30;
int margin = 10;
int currentInputBox = -1; // -1: none, 0: startDate, 1: endDate, 2: airportCode
SimpleDateFormat dateFormat = new SimpleDateFormat("M/d/yyyy hh:mm:ss a");

void setup() {
  size(600, 400);
  loadFlights("flights_full.csv");
  textAlign(CENTER, CENTER);
}

void loadFlights(String filename) {
  Table table = loadTable(filename, "header");

  for (TableRow row : table.rows()) {
    String iataCode = row.getString("MKT_CARRIER");
    String flightNumber = row.getString("MKT_CARRIER_FL_NUM");
    String origin = row.getString("ORIGIN");
    String originCityName = row.getString("ORIGIN_CITY_NAME");
    String originState = row.getString("ORIGIN_STATE_ABR");
    String originWac = row.getString("ORIGIN_WAC");
    String dest = row.getString("DEST");
    String destCityName = row.getString("DEST_CITY_NAME");
    String destState = row.getString("DEST_STATE_ABR");
    String destWac = row.getString("DEST_WAC");
    String flightDate = row.getString("FL_DATE");
    String cancelled = row.getString("CANCELLED");
    String diverted = row.getString("DIVERTED");

    Airport airport = new Airport(origin, originCityName, originState, originWac, dest, destCityName, destState, destWac);
    FlightDateInfo dateInfo = new FlightDateInfo(flightDate, cancelled, diverted);
    Flight flight = new Flight(iataCode, flightNumber, origin, dest, airport, dateInfo);
    flights.add(flight);
  }
}

void draw() {
  background(255);
  drawInputBoxes();
  drawSubmitButton();

  if (buttonPressed) {
    displayMatchingFlights();
    buttonPressed = false;
  }
}

void drawInputBoxes() {
  drawInputBox(0, startDate, "Start Date (dd/mm/yyyy hh:mm:ss am/pm)");
  drawInputBox(1, endDate, "End Date (dd/mm/yyyy hh:mm:ss am/pm)");
  drawInputBox(2, airportCode, "Airport Code (IATA)");
}

void drawSubmitButton() {
  fill(200);
  if (overButton()) fill(150);
  rect(buttonX, buttonY, buttonWidth, buttonHeight, 5);
  fill(0);
  text("Submit", buttonX + buttonWidth / 2, buttonY + buttonHeight / 2);
}

void drawInputBox(int order, String text, String placeholder) {
  int boxY = inputBoxY + (order * (inputBoxHeight + margin));
  fill(currentInputBox == order ? 230 : 255);
  stroke(0);
  rect(200, boxY, inputBoxWidth, inputBoxHeight, 5);
  fill(0);
  textAlign(LEFT, CENTER);
  float textX = 200 + 5;
  String displayText = text.equals("") ? placeholder : text;
  text(displayText, textX, boxY + inputBoxHeight / 2);
}

void mousePressed() {
  if (overButton()) {
    buttonPressed = true;
  } else {
    for (int i = 0; i < 3; i++) {
      int boxY = inputBoxY + (i * (inputBoxHeight + margin));
      if (mouseX > 200 && mouseX < (200 + inputBoxWidth) && mouseY > boxY && mouseY < (boxY + inputBoxHeight)) {
        currentInputBox = i;
        break;
      }
    }
    if (currentInputBox < 0 || currentInputBox > 2) currentInputBox = -1;
  }
}

void keyPressed() {
    if (currentInputBox == -1) return;
    if (keyCode == BACKSPACE) {
      if (currentInputBox == 0 && startDate.length() > 0) startDate = startDate.substring(0, startDate.length() - 1);
      else if (currentInputBox == 1 && endDate.length() > 0) endDate = endDate.substring(0, endDate.length() - 1);
      else if (currentInputBox == 2 && airportCode.length() > 0) airportCode = airportCode.substring(0, airportCode.length() - 1);
    } else {
      if (currentInputBox == 0 || currentInputBox == 1) {
        if ((key >= '0' && key <= '9') || key == '/' || key == ':' || key == ' ' || key == 'A' || key == 'P' || key == 'M' || key == 'a' || key == 'p' || key == 'm') {
          if (currentInputBox == 0) startDate += key;
          else if (currentInputBox == 1) endDate += key;
        }
      } else if (currentInputBox == 2) {
        // Convert airport code to uppercase
        if ((key >= 'A' && key <= 'Z') || (key >= 'a' && key <= 'z')) {
          airportCode += Character.toUpperCase(key);
        }
      }
    }
  }


void displayMatchingFlights() {
  int y = 270;
  for (Flight flight : flights) {
    if (flight.matchesCriteria(startDate, endDate, airportCode)) {
      String displayText = flight.iataCode + flight.flightNumber + ": " +
      flight.airport.origin + " to " + flight.airport.destination + " on " + flight.dateInfo.flightDate;
      if (y < height - 20) { // Simple overflow check
        text(displayText, width / 2, y);
        y += 20;
      }
    }
  }
}

boolean overButton() {
  return mouseX >= buttonX && mouseX <= buttonX + buttonWidth && mouseY >= buttonY && mouseY <= buttonY + buttonHeight;
}

// Auxiliary classes and methods as previously defined
