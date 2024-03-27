import java.util.ArrayList;
import processing.data.Table;
import processing.data.TableRow;

ArrayList<Flight> flights = new ArrayList<Flight>();
String startDate = "", endDate = "", airportCode = "";
boolean buttonPressed = false;
//int buttonX = 250, buttonY = 220, buttonWidth = 100, buttonHeight = 40;
//int inputBoxY = 30, inputBoxWidth = 200, inputBoxHeight = 30;
int margin = 10;

int currentInputBox = -1; // -1: none, 0: startDate, 1: endDate, 2: airportCode

DailyDelaysGraph delaysGraph; 

void setup1() {
  //size(800, 600);
  loadFlights("flights_full.csv");
  textAlign(CENTER, CENTER); 
  delaysGraph = new DailyDelaysGraph();
  delaysGraph.graphSetup(flights); 
}

void loadFlights(String filename) {
  Table table = loadTable(filename, "header");
  for (TableRow row : table.rows()) {
    String iataCode = row.getString("MKT_CARRIER");
    String flightNumber = row.getString("MKT_CARRIER_FL_NUM");
    String crsDepTime = row.getString("CRS_DEP_TIME");
    String depTime = row.getString("DEP_TIME");
    String crsArrTime = row.getString("CRS_ARR_TIME");
    String arrTime = row.getString("ARR_TIME");
    String distance = row.getString("DISTANCE");
    
    String origin = row.getString("ORIGIN");
    String originCityName = row.getString("ORIGIN_CITY_NAME");
    String originState = row.getString("ORIGIN_STATE_ABR");
    String originWac = row.getString("ORIGIN_WAC");
    String dest = row.getString("DEST");
    String destCityName = row.getString("DEST_CITY_NAME");
    String destState = row.getString("DEST_STATE_ABR");
    String destWac = row.getString("DEST_WAC");
    
    String flightDate = row.getString("FL_DATE"); // Assuming dd/mm/yy format
    String cancelled = row.getString("CANCELLED");
    String diverted = row.getString("DIVERTED");

    Airport airport = new Airport(origin, originCityName, originState, originWac, 
                                  dest, destCityName, destState, destWac);
    FlightDateInfo dateInfo = new FlightDateInfo(flightDate, cancelled, diverted);
    Flight flight = new Flight(iataCode, flightNumber, crsDepTime, depTime, crsArrTime, 
                               arrTime, distance, airport, dateInfo);
    flights.add(flight);
  }
}

void draw1() {
  //background(255);
  //drawInputBox(1, startDate, "Start Date (dd/mm/yy)");
  //drawInputBox(2, endDate, "End Date (dd/mm/yy)");
  //drawInputBox(3, airportCode, "Airport Code");
  //drawSubmitButton();

  /*if (buttonPressed) {
    displayMatchingFlights();
    buttonPressed = false; // Reset the buttonPressed to allow for another search
  }*/
  delaysGraph.drawGraph();
}

/*oid drawSubmitButton() {
  fill(200);
  if (overButton()) fill(150);
  rect(buttonX, buttonY, buttonWidth, buttonHeight, 5);
  fill(0);
  text("Submit", buttonX + buttonWidth / 2, buttonY + buttonHeight / 2);
}

void drawInputBox(int order, String text, String placeholder) {
  int boxY = inputBoxY + (order * (inputBoxHeight + margin));
  fill(currentInputBox == order - 1 ? 230 : 255); // 根据是否选中改变填充颜色
  stroke(0);
  rect(200, boxY, inputBoxWidth, inputBoxHeight, 5); // 绘制输入框
  fill(0);
  
  // 设置文本对齐方式为左对齐，并稍微向右移动文本的起始位置，以避免文本与输入框边界重叠
  textAlign(LEFT, CENTER); // 改变文本对齐方式为左对齐
  float textX = 200 + 5; // 在输入框左边界基础上向右移动5像素
  String displayText = text.equals("") ? placeholder : text;
  text(displayText, textX, boxY + inputBoxHeight / 2);
}*/


/*void mousePressed() {
  if (overButton()) {
    buttonPressed = true;
  } else {
    // Check which input box was clicked, if any
    for (int i = 0; i < 3; i++) {
      int boxY = inputBoxY + ((i + 1) * (inputBoxHeight + margin));
      if (mouseX > 200 && mouseX < 200 + inputBoxWidth && mouseY > boxY && mouseY < boxY + inputBoxHeight) {
        currentInputBox = i;
        return;
      }
    }
    currentInputBox = -1; // No input box was clicked
  }
}

void keyPressed() {
  if (currentInputBox == -1) return;
  if (keyCode == BACKSPACE) {
    if (currentInputBox == 0 && startDate.length() > 0) 
      startDate = startDate.substring(0, startDate.length() - 1);
    else if (currentInputBox == 1 && endDate.length() > 0) 
      endDate = endDate.substring(0, endDate.length() - 1);
    else if (currentInputBox == 2 && airportCode.length() > 0) 
      airportCode = airportCode.substring(0, airportCode.length() - 1);
  } else {
    // Allow numeric, slash, and letter input depending on the active input box
    if (currentInputBox == 2 || key == '/' || (key >= '0' && key <= '9')) { // Airport code or date
      String input = key + ""; // Convert char to String
      if (currentInputBox == 0) startDate += input;
      else if (currentInputBox == 1) endDate += input;
      else if (currentInputBox == 2) airportCode += input.toUpperCase(); // Convert airport code to uppercase
    }
  }
}

void displayMatchingFlights() {
  int y = 270;
  for (Flight flight : flights) {
    if (flight.matchesCriteria(startDate, endDate, airportCode)) {
      String displayText = flight.iataCodeMarketingAirline + flight.flightNumberMarketingAirline + ": " +
                           flight.airport.origin + " to " + flight.airport.dest + " on " + flight.dateInfo.flightDate;
      if (y < height - 20) { // Simple overflow check
        text(displayText, width / 2, y);
        y += 20;
      }
    }
  }
}

boolean overButton() {
  return mouseX >= buttonX && mouseX <= buttonX + buttonWidth && mouseY >= buttonY && mouseY <= buttonY + buttonHeight;
}*/

// Auxiliary classes like Airport, FlightDateInfo, and Flight with matchesCriteria method need to be implemented as well.
