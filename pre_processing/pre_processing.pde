// Hubert Stanowski

import java.util.Map;



String convert(String date)
{
  if (date.length() == 1)
  {
    date = "0" + date;
  }
  if (date.length() == 2)
  {
    date = "24" + date;
  }
  if (date.length() == 3)
  {
    int hour = date.charAt(0) - '0';
    hour += 24;
    date = Integer.toString(hour) + date.substring(1, 3);
  }

  return date;
}


int getDelay(String scheduled, String actual)
{
  if (actual == "")
    return 0;
  
  scheduled = convert(scheduled);
  actual = convert(actual);
  
  int schH = Integer.parseInt(scheduled.substring(0,2));
  int schM = Integer.parseInt(scheduled.substring(2,4));
  
  int actH = Integer.parseInt(actual.substring(0,2));
  int actM = Integer.parseInt(actual.substring(2,4));
  
  int schTotal = schH * 60 + schM;
  int actTotal = actH * 60 + actM;
  
  if (actTotal <= schTotal)
    return 0;
  
  return actTotal - schTotal;
  
}

void setup()
{

  String fileName = "flights_full";
  String[] lines = loadStrings(fileName + ".csv");

  HashMap<String, ArrayList> airports = new HashMap<String, ArrayList>();
  HashMap<String, ArrayList> dates = new HashMap<String, ArrayList>();
  HashMap<String, ArrayList> delays = new HashMap<String, ArrayList>();
  delays.put("CANCELLED", new ArrayList());


  for (int i=1; i<lines.length; i++)
  {

    String[] current = lines[i].split(",");
    String date = current[0];
    String origin = current[3];
    String dest = current[8];
    String scheduled = current[15];
    String actual = current[16];
    String cancelled = current[17];
    String delay = Integer.toString(getDelay(scheduled, actual));
    
    if (airports.get(origin) == null)
      airports.put(origin, new ArrayList());
    airports.get(origin).add(i);
    
    if (airports.get(dest) == null)
      airports.put(dest, new ArrayList());
    airports.get(dest).add(i);


    if (dates.get(date) == null)
      dates.put(date, new ArrayList());
    dates.get(date).add(i);
    if (cancelled.equals("1") || cancelled.equals("1.00"))
    {
      delays.get("CANCELLED").add(i);
    }
    else
    {
      if (delays.get(delay) == null)
       delays.put(delay, new ArrayList());
    delays.get(delay).add(i);
    }
  }

  PrintWriter outputAirports;
  outputAirports = createWriter("processed/" + fileName + "/" + fileName + "_airports" + ".txt");


  for (var entry : airports.entrySet()) {
    outputAirports.print(entry.getKey() + "  ");
    for (int i=0; i<entry.getValue().size()-1; i++)
    {
      outputAirports.print(entry.getValue().get(i) + ",");
    }
    outputAirports.print(entry.getValue().get(entry.getValue().size()-1) + "\n");
  }

  PrintWriter outputDates;
  outputDates = createWriter("processed/" + fileName + "/" + fileName + "_dates" + ".txt");

  for (var entry : dates.entrySet()) {
    outputDates.print(entry.getKey() + "  ");
    for (int i=0; i<entry.getValue().size()-1; i++)
    {
      outputDates.print(entry.getValue().get(i) + ",");
    }
    outputDates.print(entry.getValue().get(entry.getValue().size()-1) + "\n");
  }

  outputDates.close();
  
  PrintWriter outputDelays;
  outputDelays = createWriter("processed/" + fileName + "/" + fileName + "_delays" + ".txt");

  for (var entry : delays.entrySet()) {
    outputDelays.print(entry.getKey() + "  ");
    for (int i=0; i<entry.getValue().size()-1; i++)
    {
      outputDelays.print(entry.getValue().get(i) + ",");
    }
    if (entry.getValue().size() != 0)
    {
      outputDelays.print(entry.getValue().get(entry.getValue().size()-1) + "\n");
    }
  }

  outputDelays.close();
}

void draw()
{
  background(0,0,255);
}
