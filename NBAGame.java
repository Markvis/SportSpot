public class NBAGame {
  String id;
  String title;
  String status;
  String coverage;
  String homeTeamID;
  String awayTeamID;
  String scheduled
  String homeTeamName;
  String awayTeamName;

  public NBAGame() {
    id = "";
    title = "";
    status = "";
    coverage = "";
    homeTeamID = "";
    awayTeamID = "";
    scheduled = "";
    homeTeamName = "";
    awayTeamName = "";
  }

  public NBAGame(String id, String title, String status, String coverage, String homeTeamID, 
  String awayTeamID, String scheduled, String homeTeamName, String awayTeamName) {
    this.id = id;
    this.title = title;
    this.status = status;
    this.coverage = coverage;
    this.homeTeamID = homeTeamID;
    this.awayTeamID = awayTeamID;
    this.scheduled = scheduled;
    this.homeTeamName = homeTeamName;
    this.awayTeamName = awayTeamName;
  }

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public String getCoverage() {
    return coverage;
  }

  public void setCoverage(String coverage) {
    this.coverage = coverage;
  }

  public String getHomeTeamID() {
    return homeTeamID;
  }

  public void setHomeTeamID(String homeTeamID) {
    this.homeTeamID = homeTeamID;
  }

  public String getAwayTeamID() {
    return awayTeamID;
  }

  public void setAwayTeamID(String awayTeamID) {
    this.awayTeamID = awayTeamID;
  }
  
  public String getScheduled() {
    return scheduled;
  }

  public void setScheduled(String scheduled) {
    this.scheduled = scheduled;
  }

  public String getHomeTeamName() {
    return homeTeamName;
  }

  public void setHomeTeamName(String homeTeamName) {
    this.homeTeamName = homeTeamName;
  }

  public String getAwayTeamName() {
    return awayTeamName;
  }

  public void setAwayTeamName(String awayTeamName) {
    this.awayTeamName = awayTeamName;
  }
  
  @Override
  public String toString(){
    String result = "****** " + awayTeamName + " @ " + homeTeamName + " ******\n";
    
    result += "Game ID: " + this.id + "\n";
    result += "Game Status: " + this.status + "\n";
    result += "Game Coverage: " + this.coverage + "\n";
    result += "Game Home Team ID: " + this.homeTeamID + "\n";
    result += "Game Away Team ID: " + this.awayTeamID + "\n";
    result += "Scheduled: " + this.scheduled + "\n";
    result += "Game Home Team Name: " + this.homeTeamName + "\n";
    result += "Game Away Team Name: " + this.awayTeamName + "\n";
    
    return result;
  }
}

