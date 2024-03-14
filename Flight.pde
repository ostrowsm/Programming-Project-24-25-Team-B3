class FlightData {
  String iataCode, flightNumber, crsDepTime, depTime, crsArrTime, arrTime, distance;
  String origin, originCityName, originState, originWac, dest, destCityName, destState, destWac;
  String flightDate, cancelled, diverted;
  
  FlightData(String iataCode, String flightNumber, String crsDepTime, String depTime, 
             String crsArrTime, String arrTime, String distance, String origin, 
             String originCityName, String originState, String originWac, String dest, 
             String destCityName, String destState, String destWac, String flightDate, 
             String cancelled, String diverted) {
    this.iataCode = iataCode;
    this.flightNumber = flightNumber;
    this.crsDepTime = crsDepTime;
    this.depTime = depTime;
    this.crsArrTime = crsArrTime;
    this.arrTime = arrTime;
    this.distance = distance;
    this.origin = origin;
    this.originCityName = originCityName;
    this.originState = originState;
    this.originWac = originWac;
    this.dest = dest;
    this.destCityName = destCityName;
    this.destState = destState;
    this.destWac = destWac;
    this.flightDate = flightDate;
    this.cancelled = cancelled;
    this.diverted = diverted;
  }
  
  public String toString() {
    return iataCode + ", " + flightNumber + ", " + crsDepTime + ", " + depTime + ", " +
           crsArrTime + ", " + arrTime + ", " + distance + ", " + origin + ", " +
           originCityName + ", " + originState + ", " + originWac + ", " + dest + ", " +
           destCityName + ", " + destState + ", " + destWac + ", " + flightDate + ", " +
           cancelled + ", " + diverted;
  }
}
