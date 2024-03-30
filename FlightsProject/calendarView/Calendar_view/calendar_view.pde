import javax.swing.*;
import org.jdatepicker.impl.JDatePanelImpl;
import org.jdatepicker.impl.JDatePickerImpl;
import org.jdatepicker.impl.SqlDateModel;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.sql.Date;
import java.util.Calendar;
import java.util.Properties;

 class CalendarView extends JFrame {
    JDatePickerImpl startDatePicker, endDatePicker;
    JLabel lblEnterFlightId, lblStartDate, lblEndDate;
    JTextField textFlightId;
    JButton btnSubmit;

    CalendarView() {
        // Start date picker setup
        SqlDateModel startModel = new SqlDateModel();
        Properties p = new Properties();
        startModel.setSelected(true);
        setupDateProperties(p);
        JDatePanelImpl startPanel = new JDatePanelImpl(startModel, p);
        startDatePicker = createDatePicker(startPanel);

        // End date picker setup
        SqlDateModel endModel = new SqlDateModel();
        endModel.setSelected(true);
        JDatePanelImpl endPanel = new JDatePanelImpl(endModel, p);
        endDatePicker = createDatePicker(endPanel);

        // UI setup
        setupUI();
        btnSubmit.addActionListener(this::onSubmit);
        this.pack();
        this.setLocationRelativeTo(null); // center the window on the screen
        this.setVisible(true);
    }

     void setupDateProperties(Properties p) {
        p.put("text.day", "Day");
        p.put("text.month", "Month");
        p.put("text.year", "Year");
    }

     JDatePickerImpl createDatePicker(JDatePanelImpl panel) {
        return new JDatePickerImpl(panel, new DateLabelFormatter());
    }

    void setupUI() {
        lblEnterFlightId = new JLabel("Enter Flight ID: ");
        lblStartDate = new JLabel("Enter Start Date: ");
        lblEndDate = new JLabel("Enter End Date: ");
        textFlightId = new JTextField(15);
        btnSubmit = new JButton("Submit");
        GridLayout gl = new GridLayout(5, 2);
        Container con = this.getContentPane();
        con.setLayout(gl);
        con.add(lblEnterFlightId);
        con.add(textFlightId);
        con.add(lblStartDate);
        con.add(startDatePicker);
        con.add(lblEndDate);
        con.add(endDatePicker);
        con.add(btnSubmit);
    }

     void onSubmit(ActionEvent e) {
        String id = textFlightId.getText(); // Get flight ID from text field.
        String startDate = formatCalendarDate(startDatePicker.getModel().getValue()); // Format start date.
        String endDate = formatCalendarDate(endDatePicker.getModel().getValue()); // Format end date.

        // Now you can call your function with these string values.
        // For demonstration, replacing function call with a print statement.
        println("Flight ID: " + id + ", Start Date: " + startDate + ", End Date: " + endDate);

        // Example function call: yourFunction(id, startDate, endDate);
    }

    /**
     * Formats the date obtained from the date picker to a String in the format "dd-MM-yyyy".
     * This version accepts java.sql.Date objects directly.
     */
     String formatCalendarDate(Object value) {
        if (value != null) {
            if (value instanceof java.sql.Date) {
                java.sql.Date sqlDate = (java.sql.Date) value;
                SimpleDateFormat format = new SimpleDateFormat("MM-dd-yyyy");
                return format.format(sqlDate);
            } else {
                // Log or handle the unexpected type
                System.err.println("Expected a java.sql.Date object but received: " + value.getClass().getSimpleName());
            }
        }
        return "";
    }



     class DateLabelFormatter extends JFormattedTextField.AbstractFormatter {
        private final String datePattern = "dd-MM-yyyy";
        private final SimpleDateFormat dateFormatter = new SimpleDateFormat(datePattern);

        @Override
        public Object stringToValue(String text) throws ParseException {
            return dateFormatter.parseObject(text);
        }

        @Override
        public String valueToString(Object value) throws ParseException {
            if (value != null) {
                Calendar cal = (Calendar) value;
                return dateFormatter.format(cal.getTime());
            }
            return "";
        }
    }
}
