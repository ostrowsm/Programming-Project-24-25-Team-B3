// Author: Hao She

import javax.swing.*;
import org.jdatepicker.impl.JDatePanelImpl;
import org.jdatepicker.impl.JDatePickerImpl;
import org.jdatepicker.impl.SqlDateModel;
import java.awt.*; // for GUI component layout an event handling
import java.awt.event.ActionEvent;
import java.text.ParseException;
import java.text.SimpleDateFormat;
//import java.sql.Date;
import java.util.Calendar;
import java.util.Properties;

 class CalendarView extends JFrame { // extends JFrame for GUI
    JDatePickerImpl startDatePicker, endDatePicker; // declare JDatePickerImpl objects for start and end dates
    JLabel lblEnterFlightId, lblStartDate, lblEndDate; // declare JLabels for input prompts
    JTextField textFlightId; // declare JTextField for flight ID input
    JButton btnSubmit; // Declare JButton for submitting the form

    CalendarView() {
        // Start date picker setup
        SqlDateModel startModel = new SqlDateModel(); // new SqlDateModel for the start date
        Properties p = new Properties(); // Properties object for configuring the date picker
        startModel.setSelected(true); // set the start date model as selected
        setupDateProperties(p); // setup properties for date picker
        JDatePanelImpl startPanel = new JDatePanelImpl(startModel, p); // new JDatePanelImpl with the start model and properties
        startDatePicker = createDatePicker(startPanel); // create a date picker with the start panel

        // End date picker setup
        SqlDateModel endModel = new SqlDateModel();
        endModel.setSelected(true);
        JDatePanelImpl endPanel = new JDatePanelImpl(endModel, p);
        endDatePicker = createDatePicker(endPanel);

        // UI setup
        setupUI();
        btnSubmit.addActionListener(this::onSubmit); // add an action listener to th submit button to handle clicks
        this.pack(); // pack the frame's components to their preferred sizes
        this.setLocationRelativeTo(null); // center the window on the screen
        this.setVisible(true); // make the window visible
    }

     void setupDateProperties(Properties p) { // method to setup properties for the date pickers
        p.put("text.day", "Day"); // set the day text property
        p.put("text.month", "Month");
        p.put("text.year", "Year");
    }

     JDatePickerImpl createDatePicker(JDatePanelImpl panel) { // create a date picker with a given panel
        return new JDatePickerImpl(panel, new DateLabelFormatter());
    }

    void setupUI() { // setup the user interface components
        lblEnterFlightId = new JLabel("Enter Flight ID: ");
        lblStartDate = new JLabel("Enter Start Date: ");
        lblEndDate = new JLabel("Enter End Date: ");
        textFlightId = new JTextField(15); // text field with a column size of 15
        btnSubmit = new JButton("Submit");
        GridLayout gl = new GridLayout(5, 2); // 5 rows and 2 columns
        Container con = this.getContentPane(); // get the content pane of the frame for component addition
        con.setLayout(gl); // set the layout of the content pane to the GridLayout
        // add the components to the content pane in order
        con.add(lblEnterFlightId);
        con.add(textFlightId);
        con.add(lblStartDate);
        con.add(startDatePicker);
        con.add(lblEndDate);
        con.add(endDatePicker);
        con.add(btnSubmit);
    }

     void onSubmit(ActionEvent e) { // handle the submit button click
        String id = textFlightId.getText(); // Get flight ID from text field.
        String startDate = formatCalendarDate(startDatePicker.getModel().getValue()); // Format and retrieve the start date from the date picker
        String endDate = formatCalendarDate(endDatePicker.getModel().getValue()); // Format and retrieve end date

        // you can call your function with these string values.
        // For demonstration, replacing function call with a print statement.
        println("Flight ID: " + id + ", Start Date: " + startDate + ", End Date: " + endDate);

        // Example function call: yourFunction(id, startDate, endDate);
    }

    /**
     * Formats the date obtained from the date picker into a String 
     * @param vlaue The date object to format, expected to be a java.sql.Date instance
     * @return A String representation of the date in the format "MM-dd-yyyy" or an empty string if the input is null
     */
     String formatCalendarDate(Object value) {
        if (value != null) {
            if (value instanceof java.sql.Date) {
                java.sql.Date sqlDate = (java.sql.Date) value;
                SimpleDateFormat format = new SimpleDateFormat("MM-dd-yyyy");
                return format.format(sqlDate); // return the formatted date string
            } else {
                // Log or handle the unexpected type
                System.err.println("Expected a java.sql.Date object but received: " + value.getClass().getSimpleName());
            }
        }
        return ""; // return an empty string if the input is null or not a java.sql.Date instance
    }
     // this inner class provides a custom formatter for the date labels in the JDatePickerImpl components
     class DateLabelFormatter extends JFormattedTextField.AbstractFormatter {
        private final String datePattern = "MM-dd-yyyy"; // define the date pattern for formatting
        private final SimpleDateFormat dateFormatter = new SimpleDateFormat(datePattern);

        @Override
        public Object stringToValue(String text) throws ParseException {
            // convert a String to a Date object based on the defined date pattern
            return dateFormatter.parseObject(text);
        }

        @Override
        public String valueToString(Object value) throws ParseException {
            if (value != null) {
                Calendar cal = (Calendar) value;
                return dateFormatter.format(cal.getTime()); // return the formatted date string based on the Calendars time value
            }
            return ""; // return an empty string if the input is null
        }
    }
}
