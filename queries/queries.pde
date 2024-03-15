// Hubert Stanowski

// Paste this into main program
import java.util.Map;
import java.util.HashSet;
import java.util.Arrays;

//HashMap<String, Set<String>> get_delays()
//{

//}

// Paste this into setup in main program when everyone finishes their part
HashMap<String, HashSet<String>> loadQuery(String fileName)
{
  String[] lines = loadStrings(fileName);
  HashMap<String, HashSet<String>> delays = new HashMap<String, HashSet<String>>();
  for (int i = 0; i<lines.length; i++)
  {
    String[] curr = lines[i].split("  ");
    delays.put(curr[0], new HashSet<>(Arrays.asList(curr[1])));
  }
  
  return delays;
}


void setup()
{
  String dataSet = "flights2k";
  HashMap<String, HashSet<String>> delays = loadQuery(dataSet + "_delays.txt");
  //println(delays);
  
  HashMap<String, HashSet<String>> dates = loadQuery(dataSet + "_dates.txt");
  //for (var entry : dates.entrySet())
  //{
  //  println(entry.getKey());
  //  println(entry.getValue());
  //  println("");
  //}
  HashMap<String, HashSet<String>> airports = loadQuery(dataSet + "_airports.txt");
  //println(airports);
}
