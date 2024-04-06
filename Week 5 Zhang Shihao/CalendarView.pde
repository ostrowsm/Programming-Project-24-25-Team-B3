class CalendarView {
    UtilDateModel startModel = new UtilDateModel();
    UtilDateModel endModel = new UtilDateModel();
    Properties p = new Properties();
    JDatePickerImpl startDatePicker, endDatePicker;
    JTextField airportCodeField, airlineCodeField;
    JButton searchButton, sortButton;
    JButton visualizationButton; // Add visualization button
    JButton returnButton; // Add return button

    CalendarView(PApplet parent) {
        JFrame frame = new JFrame("Select Date Range");
        frame.setLayout(new FlowLayout());

        p.put("text.today", "Today");
        p.put("text.month", "Month");
        p.put("text.year", "Year");

        JDatePanelImpl startDatePanel = new JDatePanelImpl(startModel, p);
        JDatePanelImpl endDatePanel = new JDatePanelImpl(endModel, p);

        startDatePicker = new JDatePickerImpl(startDatePanel, new DateLabelFormatter());
        endDatePicker = new JDatePickerImpl(endDatePanel, new DateLabelFormatter());

        airportCodeField = new JTextField(5);
        airlineCodeField = new JTextField(5);
        searchButton = new JButton("Search");
        sortButton = new JButton("Sort Descending");

        visualizationButton = new JButton("Visualization"); // Add visualization button
        returnButton = new JButton("Return"); // Add return button

        frame.add(new JLabel("Start Date:"));
        frame.add(startDatePicker);
        frame.add(new JLabel("End Date:"));
        frame.add(endDatePicker);
        frame.add(new JLabel("Airport Code:"));
        frame.add(airportCodeField);
        frame.add(new JLabel("Airline Code (optional):"));
        frame.add(airlineCodeField);
        frame.add(searchButton);
        frame.add(sortButton);

        // Add visualization button and return button to the interface
        frame.add(visualizationButton);
        frame.add(returnButton);

        searchButton.addActionListener(e -> searchAction(e));
        sortButton.addActionListener(e -> sortAction(e));

        visualizationButton.addActionListener(e -> visualizationAction(e)); // Add click event handling logic for visualization button
        returnButton.addActionListener(e -> returnAction(e)); // Add click event handling logic for return button

        frame.pack();
        frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        frame.setVisible(true);
    }

    void searchAction(ActionEvent e) {
        SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
        try {
            Date startDate = startModel.getValue() != null ? formatter.parse(formatter.format(startModel.getValue())) : null;
            Date endDate = endModel.getValue() != null ? formatter.parse(formatter.format(endModel.getValue())) : null;
            String airportCode = airportCodeField.getText().toUpperCase();
            String airlineCode = airlineCodeField.getText().toUpperCase();

            matchingFlights.clear();
            for (Flight flight : flights) {
                if (flight.matchesCriteria(startDate, endDate, airportCode, airlineCode)) {
                    matchingFlights.add(flight);
                }
            }
            inputScreen.redraw();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    void sortAction(ActionEvent e) {
        sortedDescending = !sortedDescending;
        inputScreen.redraw();
    }

    class DateLabelFormatter extends JFormattedTextField.AbstractFormatter {
        private String datePattern = "MM/dd/yyyy";
        private SimpleDateFormat dateFormatter = new SimpleDateFormat(datePattern);

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
