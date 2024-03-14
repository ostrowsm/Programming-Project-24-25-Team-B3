ArrayList<FlightData> flights = new ArrayList<FlightData>();

void setup() {
  size (1500, 1500);
  loadFlightData("flights_full.csv");
  println("Data loaded. Total flights: " + flights.size());
  noLoop(); // 不需要连续调用draw()
}

void draw() {
  background(255);
  fill(0);
  textSize(12);
  for (int i = 0; i < flights.size(); i++) {
    text(flights.get(i).toString(), 10, 20 + i * 15);
    if (i > 50) break; // 为了演示，只打印前50条数据
  }
}

void loadFlightData(String filename) {
  Table table = loadTable(filename, "header");
  for (TableRow row : table.rows()) {
    FlightData flight = new FlightData(row.getString("MKT_CARRIER"),
                                        row.getString("MKT_CARRIER_FL_NUM"),
                                        row.getString("CRS_DEP_TIME"),
                                        row.getString("DEP_TIME"),
                                        row.getString("CRS_ARR_TIME"),
                                        row.getString("ARR_TIME"),
                                        row.getString("DISTANCE"),
                                        row.getString("ORIGIN"),
                                        row.getString("ORIGIN_CITY_NAME"),
                                        row.getString("ORIGIN_STATE_ABR"),
                                        row.getString("ORIGIN_WAC"),
                                        row.getString("DEST"),
                                        row.getString("DEST_CITY_NAME"),
                                        row.getString("DEST_STATE_ABR"),
                                        row.getString("DEST_WAC"),
                                        row.getString("FL_DATE"),
                                        row.getString("CANCELLED"),
                                        row.getString("DIVERTED"));
    flights.add(flight);
  }
}
