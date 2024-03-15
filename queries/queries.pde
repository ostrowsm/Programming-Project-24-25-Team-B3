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
  HashMap<String, HashSet<Integer>> delays = new HashMap<String, HashSet<Integer>>();
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
    delays.put(k, data);
  }
  
  return delays;
}

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
  
  
  println(getFlightsByAirportAndDate("HNL", "01/02/2022 00:00"));
}
