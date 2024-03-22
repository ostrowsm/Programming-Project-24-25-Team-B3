class Airport {
  String origin, originCityName, originState, originWac;
  String destination, destCityName, destState, destWac;

  Airport(String origin, String originCityName, String originState, String originWac, 
          String destination, String destCityName, String destState, String destWac) {
    this.origin = origin;
    this.originCityName = originCityName;
    this.originState = originState;
    this.originWac = originWac;
    this.destination = destination;
    this.destCityName = destCityName;
    this.destState = destState;
    this.destWac = destWac;
  }
}
