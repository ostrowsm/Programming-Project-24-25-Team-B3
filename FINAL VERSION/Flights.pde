//Author by Zhang Shihao
class Flights implements Comparable<Flights> {
    String iataCode, flightNumber, origin, destination, date;
    boolean cancelled, diverted;

    Flights(String iataCode, String flightNumber, String origin, String destination, String date, boolean cancelled, boolean diverted) {
        this.iataCode = iataCode;
        this.flightNumber = flightNumber;
        this.origin = origin;
        this.destination = destination;
        this.date = date; 
        this.cancelled = cancelled;
        this.diverted = diverted;
    }

    boolean matchesCriteria(Date startDate, Date endDate, String airportCode, String airlineCode) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss");
            Date flightDate = sdf.parse(this.date);

            return !this.cancelled && !this.diverted
                    && (flightDate.equals(startDate) || flightDate.after(startDate))
                    && (flightDate.equals(endDate) || flightDate.before(endDate))
                    && (this.origin.equals(airportCode) || this.destination.equals(airportCode))
                    && (airlineCode == null || airlineCode.isEmpty() || this.iataCode.equals(airlineCode));
        } catch (ParseException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public int compareTo(Flights other) {
        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss");
        try {
            Date thisDate = sdf.parse(this.date);
            Date otherDate = sdf.parse(other.date);
            return thisDate.compareTo(otherDate);
        } catch (ParseException e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public String toString() {
        return String.format("%s flight %s from %s to %s on %s", iataCode, flightNumber, origin, destination, date);
    }
}
