class FlightDate{
  
  private String FlightDate;
  private String Cancelled;
  private String Diverted;
  
  FlightDate(String FlightDate, String Cancelled, String Diverted){
    this.FlightDate = FlightDate;
    this.Cancelled = Cancelled;
    this.Diverted = Diverted;
  }
  
  public String getFlightDate(){
    return this.FlightDate;
  }
  
  public String getCancelled(){
    return this.Cancelled;
  }
  
  public String getDivertede(){
    return this.Diverted;
  }
  
}
