class Airport {
  String origin, originCityName, originState, originWac;
  String dest, destCityName, destState, destWac;

  Airport(String origin, String originCityName, String originState, String originWac, 
          String dest, String destCityName, String destState, String destWac) {
    this.origin = origin;
    this.originCityName = originCityName;
    this.originState = originState;
    this.originWac = originWac;
    this.dest = dest;
    this.destCityName = destCityName;
    this.destState = destState;
    this.destWac = destWac;
  }
}
