
class Flight {
  String iataCodeMarketingAirline, flightNumberMarketingAirline;
  String crsDepTime, depTime, crsArrTime, arrTime, distance;
  Airport airport;
  FlightDateInfo dateInfo;

  Flight(String iataCodeMarketingAirline, String flightNumberMarketingAirline, 
         String crsDepTime, String depTime, String crsArrTime, String arrTime, 
         String distance, Airport airport, FlightDateInfo dateInfo) {
    this.iataCodeMarketingAirline = iataCodeMarketingAirline;
    this.flightNumberMarketingAirline = flightNumberMarketingAirline;
    this.crsDepTime = crsDepTime;
    this.depTime = depTime;
    this.crsArrTime = crsArrTime;
    this.arrTime = arrTime;
    this.distance = distance;
    this.airport = airport;
    this.dateInfo = dateInfo;
  }
  
  // 检查航班是否符合给定的搜索条件
  boolean matchesCriteria(String startDate, String endDate, String airportCode) {
    // 转换日期格式为 yyyy/mm/dd 以便进行比较
    String start = convertDate(startDate);
    String end = convertDate(endDate);
    String flightDate = convertDate(this.dateInfo.flightDate);
    
    boolean datesMatch = flightDate.compareTo(start) >= 0 && flightDate.compareTo(end) <= 0;
    boolean airportMatches = this.airport.origin.equalsIgnoreCase(airportCode) || this.airport.dest.equalsIgnoreCase(airportCode);
    return datesMatch && airportMatches;
  }
  
  // 转换日期格式从 dd/mm/yy 到 yyyy/mm/dd
  String convertDate(String date) {
    String[] parts = date.split("/");
    String day = parts[0];
    String month = parts[1];
    String year = "20" + parts[2]; // 假设所有的年份都在2000年之后
    return year + "/" + month + "/" + day;
  }
}
