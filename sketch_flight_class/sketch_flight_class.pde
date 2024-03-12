class Flight {
  private int id; // flight index
  private String flightDate; // yyyymmdd format
  private String iataCodeMarketingAirline; // Code to identify the carrier e.g., AA
  private String flightNumberMarketingAirline; // The flight number
  private String origin; // Origin airport code
  private String originCityName; // Origin Airport, City Name
  private String originState; // Origin Airport, State Code
  private int originWac; // World Area Code
  private String dest; // Destination Airport code
  private String destCityName;
  private String destState;
  private int destWac; // World Area Code
  private String crsDepTime; // Scheduled departure time hhmm
  private String depTime; // Actual departure time hhmm
  private String crsArrTime; // Scheduled arrival time hhmm
  private String arrTime; // Actual arrival time hhmm
  private int cancelled; // 1 = yes, 0 = no
  private int diverted; // 1 = yes, 0 = no
  private int distance; // Distance between airports in miles

  Flight(
    int id,
    String flightDate,
    String iataCodeMarketingAirline,
    String flightNumberMarketingAirline,
    String origin,
    String originCityName,
    String originState,
    int originWac,
    String dest,
    String destCityName,
    String destState,
    int destWac,
    String crsDepTime,
    String depTime,
    String crsArrTime,
    String arrTime,
    int cancelled,
    int diverted,
    int distance
    ) {
    this.id = id;
    this.flightDate = flightDate;
    this.iataCodeMarketingAirline = iataCodeMarketingAirline;
    this.origin = origin;
    this.originCityName = originCityName;
    this.originState = originState;
    this.originWac = originWac;
    this.dest = dest;
    this.destCityName = destCityName;
    this.destState = destState;
    this.destWac = destWac;
    this.crsDepTime = crsDepTime;
    this.depTime = depTime;
    this.crsArrTime = crsArrTime;
    this.arrTime = arrTime;
    this.cancelled = cancelled;
    this.diverted = diverted;
    this.distance = distance;
  }

  public String getFlightDate() {
    return this.flightDate;
  }

  public String getIataCodeMarketingAirline() {
    return this.iataCodeMarketingAirline;
  }

  public String getFlightNumberMarketingAirline() {
    return this.flightNumberMarketingAirline;
  }

  public String getOrigin() {
    return this.origin;
  }

  public String getOriginCityName() {
    return this.originCityName;
  }

  public String getOriginState() {
    return this.originState;
  }

  public int getOriginWac() {
    return this.originWac;
  }

  public String getDest() {
    return this.dest;
  }

  public String getDestCityName() {
    return this.destCityName;
  }

  public String getDestState() {
    return this.destState;
  }

  public int getDestWac() {
    return this.destWac;
  }

  public String getCrsDepTime() {
    return this.crsDepTime;
  }

  public String getDepTime() {
    return this.depTime;
  }

  public String getCrsArrTime() {
    return this.crsArrTime;
  }

  public String getArrTime() {
    return this.arrTime;
  }

  public int getCancelled() {
    return this.cancelled;
  }

  public int getDiverted() {
    return this.diverted;
  }

  public int getDistance() {
    return this.distance;
  }
}
