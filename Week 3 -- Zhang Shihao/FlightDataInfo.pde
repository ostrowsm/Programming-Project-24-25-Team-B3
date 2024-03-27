import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

class FlightDateInfo {
    String flightDate; // Assuming this is in a format like "MM/dd/yyyy hh:mm:ss a" or another complete date format
    String cancelled;
    String diverted;

    FlightDateInfo(String flightDate, String cancelled, String diverted) {
        this.flightDate = flightDate;
        this.cancelled = cancelled;
        this.diverted = diverted;
    }

    // Method to return the flight date in "yyyy-MM-dd" format
    String getSimpleDate() {
        SimpleDateFormat originalFormat = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss a", Locale.US);
        SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date date = originalFormat.parse(this.flightDate);
            return targetFormat.format(date);
        } catch (ParseException e) {
            // Handle the case where the original flightDate is not in the expected format
            System.err.println("Error parsing the date: " + e.getMessage());
            return ""; // Return an empty string or a default value
        }
    }
}
