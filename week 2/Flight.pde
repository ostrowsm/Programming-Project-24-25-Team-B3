import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

class Flight {
  String iataCode, flightNumber;
  String origin, destination;
  Airport airport;
  FlightDateInfo dateInfo;
  
  // Flight 类的构造函数
  Flight(String iataCode, String flightNumber, String origin, String destination, Airport airport, FlightDateInfo dateInfo) {
    this.iataCode = iataCode;
    this.flightNumber = flightNumber;
    this.origin = origin;
    this.destination = destination;
    this.airport = airport;
    this.dateInfo = dateInfo;
  }
  
  // 检查航班是否满足给定的搜索条件
 boolean matchesCriteria(String startDateStr, String endDateStr, String airportCode) {
      SimpleDateFormat dateFormat = new SimpleDateFormat("M/d/yyyy hh:mm:ss a", Locale.US);
      try {
          Date start = dateFormat.parse(startDateStr);
          Date end = dateFormat.parse(endDateStr);
          Date flightDate = dateFormat.parse(this.dateInfo.flightDate);
          
          if (!flightDate.before(start) && !flightDate.after(end)) {
              return this.airport.origin.equals(airportCode) || this.airport.destination.equals(airportCode);
          }
      } catch (ParseException e) {
          System.err.println("Error parsing dates: " + e.getMessage());
      }
      return false;
  }
}
