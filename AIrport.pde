class Airport{
  
  private String Origin;
  private String OriginCityName;
  private String OriginState;
  private String OriginWac;
  private String Dest;
  private String DestCityName;
  private String DestState;
  private String DestWac;

  Airport(String Origin, String OriginCityName, String OriginState, String OriginWac, 
          String Dest, String DestCityName, String DestState, String DestWac){
    this.Origin = Origin;
    this.OriginCityName = OriginCityName;
    this.OriginState = OriginState;
    this.OriginWac = OriginWac;
    this.Dest = Dest;
    this.DestCityName = DestCityName;
    this.DestState = DestState;
    this.DestWac = DestWac;
  }
  
  public String getOrigin(){
    return this.Origin;
  }
  
    public String getOriginCityName(){
    return this.OriginCityName;
  }
  
    public String getOriginState(){
    return this.OriginState;
  }
  
    public String getOriginWac(){
    return this.OriginWac;
  }
  
    public String getDest(){
    return this.Dest;
  }
  
    public String getDestCityName(){
    return this.DestCityName;
  }
  
    public String getDestState(){
    return this.DestState;
  }
  
    public String getDestWac(){
    return this.DestWac;
  }
  
}
