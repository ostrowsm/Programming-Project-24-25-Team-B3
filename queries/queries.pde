// Hubert Stanowski

// Paste this into main program
import java.util.*;
import java.util.Map;
import java.util.HashSet;
import java.util.Arrays;


// Paste this into the main program when everyone finishes their part
HashMap<String, HashSet<Integer>> loadQueryData(String fileName)
{
  String[] lines = loadStrings(fileName);
  HashMap<String, HashSet<Integer>> map = new HashMap<String, HashSet<Integer>>();
  for (int i = 0; i<lines.length; i++)
  {
    String[] curr = lines[i].split("  ");
    String k = curr[0];
    String[] ids = curr[1].split(",");
    HashSet<Integer> data = new HashSet<Integer>();
    for (int j = 0; j < ids.length; j++)
    {
      data.add(Integer.parseInt(ids[j]));
    }
    map.put(k, data);
  }

  return map;
}

// Flights associated with an airport on a certain day; to detect wrong dates put the function call inside try-catch
HashSet<Integer> getFlightsByAirportAndDate(String airport, String date)
{
  HashSet<Integer> flightsFromAirport = airports.get(airport);
  //println(airports.get(airport));
  //println("");
  HashSet<Integer> flightsAtDate = dates.get(date);
  //println(dates.get(date));
  flightsAtDate.retainAll(flightsFromAirport);
  //println("\n");

  return flightsAtDate;
}

// Flights accociated with an airport in a date range (inclusive) with wrong date detection
HashSet<Integer> getFlightsByAirportAndDateRange(String airport, String startDate, String endDate)
{

  HashSet<Integer> currentFlights = getFlightsByAirportAndDate(airport, startDate);
  HashSet<Integer> result = new HashSet<Integer>(currentFlights);

  while (!startDate.equals(endDate))
  {

    // Date increment
    String[] dateArr = startDate.split("/");
    String nextDay = Integer.toString(Integer.parseInt(dateArr[1])+1);
    if (nextDay.length() < 2)
      nextDay = "0" + nextDay;

    dateArr[1] = nextDay;

    startDate = String.join("/", dateArr);
    // end date increment


    //println(startDate);
    // set union with previous dates in the range
    try
    {
      currentFlights = getFlightsByAirportAndDate(airport, startDate);
      result.addAll(currentFlights);
    }
    catch (Exception e)
    {
      break;
    }
  }

  return result;
}


// Add delays, dates and airports as global variables in main and load in setup in main
HashMap<String, HashSet<Integer>> delays;
HashMap<String, HashSet<Integer>> dates;
HashMap<String, HashSet<Integer>> airports;


void setup()
{
  String dataSet = "flights2k";
  delays = loadQueryData(dataSet + "_delays.txt");
  //println(delays);

  dates = loadQueryData(dataSet + "_dates.txt");
  //for (var entry : dates.entrySet())
  //{
  //  println(entry.getKey());
  //  println(entry.getValue());
  //  println("");
  //}

  airports = loadQueryData(dataSet + "_airports.txt");
  //println(airports);

  //println(getFlightsByAirportAndDate("HNL", "01/10/2022 00:00"));

  println(getFlightsByAirportAndDateRange("HNL", "01/01/2022 00:00", "01/12/2022 00:00"));
}
