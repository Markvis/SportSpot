// imports
import apwidgets.*;
import java.io.*;
import ketai.ui.*;

// globals
int mode = 0;
XML xml;

// keys
String NBAkey = "k4mqkpzfmq24f7yatqyvztxk";
String MLBkey = "4nfwbpjthrsfsaeeh73szu8j";

//selectionlists for team1 & team2 in mode0
KetaiList selectionlist;
KetaiList selectionlist2;
ArrayList<String> teams = new ArrayList<String>();

//widget containers and buttons for team selection in mode0
APWidgetContainer widgetContainer_SubmitTeams;
APButton button_submit, button_team1, button_team2;

//widget containers and buttons for graphs in mode1
APWidgetContainer widgetContainer_Graphs;
APButton button_3Pointers, button_FieldGoalPerc, button_FreeThrowPerc;

/*
  GRAPHS INCLUDED:
 - 3 Pointers %
 - Field Goals %
 - Free Throws %
 */

String team1 = "Team 1";
String team2 = "Team 2";
String season = "2014";
NBATeam team1_obj;
NBATeam team2_obj;


//variables for mode0
String selection = "Team ";
boolean team1_pressed = false;
boolean team2_pressed = false;

int ThreePointPerc;
int FieldGoalsPerc;
int FreeThrowsPerc;
int bar_w, bar_h;

float score = 65;
float score2 = 38;

/*
  COMPLETE WORKING METHODS SO FAR
 AND METHODS YOU SHOULD USE
 - getNBATeamSeasonTotalStats
 - getNBAPlayerStats
 - getAllGamesOnDate
 */

void setup() {
  orientation(LANDSCAPE);
  frameRate(60);  
  //noLoop();
  println("START SETUP");

  //adding teams to teams ArrayList
  teams.add("76ers");
  teams.add("Bucks");
  teams.add("Bulls");
  teams.add("Cavaliers");
  teams.add("Celtics");
  teams.add("Clippers");
  teams.add("Grizzlies");
  teams.add("Hawks");
  teams.add("Heat");
  teams.add("Hornets");
  teams.add("Jazz");
  teams.add("Kings");
  teams.add("Knicks");
  teams.add("Lakers");
  teams.add("Magic");
  teams.add("Mavericks");
  teams.add("Nets");
  teams.add("Nuggets");
  teams.add("Pacers");
  teams.add("Pelicans");
  teams.add("Pistons");
  teams.add("Raptors");
  teams.add("Rockets");
  teams.add("Spurs");
  teams.add("Suns");
  teams.add("Thunder");
  teams.add("Timberwolves");
  teams.add("Trail Blazers");
  teams.add("Warriors");
  teams.add("Wizards");

  //widget container for buttons in mode0
  widgetContainer_SubmitTeams = new APWidgetContainer(this); 
  //creating & adding buttons for mode0
  button_submit = new APButton(width/2 - width/12, height - height/4, width/6, height/6, "Submit"); //create new button from x- and y-pos and label. size determined by text content
  button_team1 = new APButton(width/12, height/9, width/4, height/7, "Select Team 1"); 
  button_team2 = new APButton(width - width/12 - width/4, height/9, width/4, height/7, "Select Team 2"); 
  button_submit.setTextSize(20);
  button_team1.setTextSize(18);
  button_team2.setTextSize(18);
  widgetContainer_SubmitTeams.addWidget(button_submit);
  widgetContainer_SubmitTeams.addWidget(button_team1);
  widgetContainer_SubmitTeams.addWidget(button_team2);

  //widget container for buttons in mode1
  widgetContainer_Graphs = new APWidgetContainer(this);
  //creating & adding buttons for mode1
  button_3Pointers  = new APButton(width/2 - width/4 - width/12, height - height/6, "3 Pointers %");
  button_FieldGoalPerc = new APButton(width/2 - width/12, height - height/6, "Field Goal %");
  button_FreeThrowPerc = new APButton(width/2 + width/4 - width/12, height - height/6, "Free Throw %");
  widgetContainer_Graphs.addWidget(button_3Pointers);
  widgetContainer_Graphs.addWidget(button_FieldGoalPerc);
  widgetContainer_Graphs.addWidget(button_FreeThrowPerc);

  widgetContainer_SubmitTeams.show();
  widgetContainer_Graphs.hide();

  /*
  // ****** START OF TESTS / EXAMPLES ******
   NBATeam Warriors = new NBATeam();
   println(today.toString());
   
   // get list of games in a specific year month day
   ArrayList <NBAGame> allGames = getAllGamesOnDate("2015", "04", "26");
   println("Warriors game id: " + Database.teamNameAndIDHash.get("Warriors"));
   
   // GET Player Stat and test
   NBAPlayer Curry = getNBAPlayerStats("8ec91366-faea-4196-bbfd-b8fab7434795", "2014");
   if (Curry != null) {
   println(Curry.getFullName());
   
   NBATeam celtics = getNBATeamSeasonTotalStats(Database.teamNameAndIDHash.get("Celtics"), season);
   celtics.getTeamName();
   
   NBATeam team1 = getNBATeamSeasonTotalStats(Database.teamNameAndIDHash.get(team1), season);
   }
   
   
   // ****** END OF TESTS / EXAMPLES ******
   */

  println("END SETUP");
} // END SETUP

void draw() {

  //mode 0 - TEAM SELECTIONS & SUBMISSIONS
  if (mode == 0) {
    background(0, 0, 80);
    textAlign(CENTER);

    textSize(65);
    text(team1, width/2, height/2 - height/8);
    text(team2, width/2, height/2 + height/8);
    textSize(50);
    text("vs.", width/2, height/2);
    textSize(70);
    text("SEASON", width/2, height/9 - 20);
    text(season, width/2, height/9 + 90);

    //selections triangles for SEASON
    triangle(width/2 + 150, height/9 + 40, 
    width/2 + 150, height/9 + 90, 
    width/2 + 200, height/9 + 65);
    triangle(width/2 - 150, height/9 + 40, 
    width/2 - 150, height/9 + 90, 
    width/2 - 200, height/9 + 65);
  }
  //mode1 - GRAPH COMPARISONS
  else if (mode == 1) {
    
    background(0, 0, 80);
    
    float lineBase_h = height-height/3;
    float lineBase_w = width/6;
    float lineTop_h = height - 100;
    float lineWidth = 2*(width/3);
    float lineHeight = height-(height/3)-100;
    
    //creating x- and y-axis for the bar graphs
    stroke(255);
    strokeWeight(10);
    line(width/6, height-height/3, width-(width/6), height-height/3);
    line(width/6, height-height/3, width/6, 100);
    //creating short lines to divide the y-axis to 10 parts
    strokeWeight(5);
    line(width/6 - 20, (height-height/3) - ((height-height/3 - 100)/10), width/6 + 20, (height-height/3) - ((height-height/3 - 100)/10));
    line(width/6 - 20, (height-height/3) - (2*(height-height/3 - 100)/10), width/6 + 20, (height-height/3) - (2*(height-height/3 - 100)/10));
    line(width/6 - 20, (height-height/3) - (3*(height-height/3 - 100)/10), width/6 + 20, (height-height/3) - (3*(height-height/3 - 100)/10));
    line(width/6 - 20, (height-height/3) - (4*(height-height/3 - 100)/10), width/6 + 20, (height-height/3) - (4*(height-height/3 - 100)/10));
    line(width/6 - 20, (height-height/3) - (5*(height-height/3 - 100)/10), width/6 + 20, (height-height/3) - (5*(height-height/3 - 100)/10));
    line(width/6 - 20, (height-height/3) - (6*(height-height/3 - 100)/10), width/6 + 20, (height-height/3) - (6*(height-height/3 - 100)/10));
    line(width/6 - 20, (height-height/3) - (7*(height-height/3 - 100)/10), width/6 + 20, (height-height/3) - (7*(height-height/3 - 100)/10));
    line(width/6 - 20, (height-height/3) - (8*(height-height/3 - 100)/10), width/6 + 20, (height-height/3) - (8*(height-height/3 - 100)/10));
    line(width/6 - 20, (height-height/3) - (9*(height-height/3 - 100)/10), width/6 + 20, (height-height/3) - (9*(height-height/3 - 100)/10));

    //first bar graphs
    fill(255,51,51);
    rect(lineBase_w + (lineWidth/9), lineBase_h, width/12, -(score/100)*lineHeight);
    fill(255,153,51);
    rect(lineBase_w + (lineWidth/9 + width/12), lineBase_h, width/12, -(score2/100)*lineHeight);
      
    //second bar graphs
    
  }
}

void mousePressed() {

  //if right triangle is pressed, change season
  if ((mouseX <= width/2 + 230)&&(mouseX >= width/2 + 100)
    &&(mouseY <= height/9 + 130 )&&(mouseY >= height/9 + 10)) {

    if (season == "2014") {
      season = "2013";
    } else season = "2014";
  }
  //if left triangle is pressed, change season
  else if ((mouseX <= width/2 - 120)&&(mouseX >= width/2 - 230)
    &&(mouseY <= height/9 + 130)&&(mouseY >= height/9 + 10 )) {

    if (season == "2014") {
      season = "2013";
    } else season = "2014";
  }
}

void onKetaiListSelection(KetaiList klist) {

  selection = klist.getSelection(); 

  //change the team name to selection variable from
  //selectionlist in mode0
  if (selection != "") { 
    if (team1_pressed) {
      team1 = selection;
    } else if (team2_pressed) {
      team2 = selection;
    }
  }
  team1_pressed = false;
  team2_pressed = false;
}

void onClickWidget(APWidget widget) {

  //BUTTONS OF MODE0
  if (widget == button_team1) {    
    selectionlist = new KetaiList(this, teams);
    team1_pressed = true;
    // team1 = selection;
  } else if (widget == button_team2) {
    selectionlist2 = new KetaiList(this, teams);
    team2_pressed = true;
    // team2 = selection;
  } else if (widget == button_submit) {
    if (team1 == team2) {
      KetaiAlertDialog.popup(this, "Nice try...", "Please choose two different teams.");
    } else if ((team1 == "Team 1") || (team2 == "Team 2")) {
      KetaiAlertDialog.popup(this, "Not ready yet!", "Make sure you pick 2 teams.");
    } else {
      //team1_obj = getNBATeamSeasonTotalStats(Database.teamNameAndIDHash.get(team1), season);
      //team2_obj = getNBATeamSeasonTotalStats(Database.teamNameAndIDHash.get(team2), season);
      mode = 1;
      widgetContainer_Graphs.show();
      widgetContainer_SubmitTeams.hide();
    }
  }
  //BUTTONS OF MODE1
  else if (widget == button_3Pointers) {
  } else if (widget == button_FieldGoalPerc) {
  } else if (widget == button_FreeThrowPerc) {
  }
}


ArrayList <NBAGame> getNBAGameBoxScore(String gameID) {
  println("********** getNBAGameBoxScore **********");
  String URI = "http://api.sportradar.us/nba-t3/games/" + gameID + "/boxscore.xml?api_key=" + NBAkey;
  ArrayList <NBAGame> liveGameTeamsStats = new ArrayList<NBAGame>();


  // load test file DELETE TODO
  xml = loadXML("cache/BoxScoreExample.xml");

  // xml = loadXML(URI);

  XML [] team = xml.getChildren("team");

  return liveGameTeamsStats;
}

/*
  This method will return an Object of class NBATEAM
 based on the team id and the season year (2014 or 2013)
 which will contain all the total statistical data 
 */
NBATeam getNBATeamSeasonTotalStats(String teamID, String year) {
  println("********** getNBATeamSeasonStats **********");
  String URI = "http://api.sportradar.us/nba-t3/seasontd/" + year + "/REG/teams/" + teamID + "/statistics.xml?api_key=" + NBAkey;

  println("URI is: " + URI);

  xml = loadXML(URI);

  // get season total stats
  XML teamXML = xml.getChild("team");
  XML teamRecordsXML = teamXML.getChild("team_records");
  XML overallXML = teamRecordsXML.getChild("overall");
  XML totalXML = overallXML.getChild("total");

  // parse data to the Team object
  String teamName = teamXML.getString("market") + " " + teamXML.getString("name");
  int gamesPlayed = Integer.parseInt(totalXML.getString("games_played"));
  float minutes = Float.parseFloat(totalXML.getString("minutes"));
  int fieldGoalsMade = Integer.parseInt(totalXML.getString("field_goals_made"));
  int fieldGoalsAtt = Integer.parseInt(totalXML.getString("field_goals_att"));
  int threePointsMade = Integer.parseInt(totalXML.getString("three_points_made"));
  int threePointsAtt = Integer.parseInt(totalXML.getString("three_points_att"));
  int blockedAtt = Integer.parseInt(totalXML.getString("blocked_att"));
  int freeThrowsMade = Integer.parseInt(totalXML.getString("free_throws_made"));
  int freeThrowsAtt = Integer.parseInt(totalXML.getString("free_throws_att"));
  int offensiveRebounds = Integer.parseInt(totalXML.getString("offensive_rebounds"));
  int defensiveRebounds = Integer.parseInt(totalXML.getString("defensive_rebounds"));
  int assists = Integer.parseInt(totalXML.getString("assists"));
  int turnovers = Integer.parseInt(totalXML.getString("turnovers"));
  int steals = Integer.parseInt(totalXML.getString("steals"));
  int blocks = Integer.parseInt(totalXML.getString("blocks"));
  int personalFouls = Integer.parseInt(totalXML.getString("personal_fouls"));
  int techFouls = Integer.parseInt(totalXML.getString("tech_fouls"));
  int points = Integer.parseInt(totalXML.getString("points"));
  int fastBreakPoints = Integer.parseInt(totalXML.getString("fast_break_pts"));
  int paintPts = Integer.parseInt(totalXML.getString("paint_pts"));
  int flagrantFouls = Integer.parseInt(totalXML.getString("flagrant_fouls"));
  int pointsOffTurnovers = Integer.parseInt(totalXML.getString("points_off_turnovers"));
  int secondChancePoints = Integer.parseInt(totalXML.getString("second_chance_pts"));
  float freeThrowsPct = Float.parseFloat(totalXML.getString("free_throws_pct"));
  float twoPointsPct = Float.parseFloat(totalXML.getString("two_points_pct"));
  float threePointsPct = Float.parseFloat(totalXML.getString("three_points_pct"));
  float fieldGoalsPct = Float.parseFloat(totalXML.getString("field_goals_pct"));
  int rebounds = Integer.parseInt(totalXML.getString("rebounds"));
  float assistsTurnoverRatio = Float.parseFloat(totalXML.getString("assists_turnover_ratio"));
  int twoPointsMade = Integer.parseInt(totalXML.getString("two_points_made"));
  int twoPointsAtt = Integer.parseInt(totalXML.getString("two_points_att"));

  NBATeam team = new NBATeam(teamName, gamesPlayed, minutes, fieldGoalsMade, fieldGoalsAtt, threePointsMade, threePointsAtt, 
  blockedAtt, freeThrowsMade, freeThrowsAtt, offensiveRebounds, defensiveRebounds, assists, 
  turnovers, steals, blocks, personalFouls, techFouls, points, fastBreakPoints, paintPts, flagrantFouls, 
  pointsOffTurnovers, secondChancePoints, freeThrowsPct, twoPointsPct, threePointsPct, fieldGoalsPct, 
  rebounds, assistsTurnoverRatio, twoPointsMade, twoPointsAtt);

  println(team.toString());

  return team;
}

/*
  This method will return an object of class NBAPlayer based on the 
 playerID and the season year(2014 or 2013)
 This method will return null if the input is invalid
 Refer to NBAPlayer in what types of data will be returned
 */
NBAPlayer getNBAPlayerStats(String playerID, String year) {
  println("********** getNBAPlayerStats **********");
  String URI = "http://api.sportradar.us/nba-t3/players/" + playerID + "/profile.xml?api_key=" + NBAkey;
  println("URI is: " + URI);
  xml = loadXML(URI);
  NBAPlayer player;
  boolean NBAPlayerInit = false;

  String id = xml.getString("id");
  String fullName = xml.getString("full_name");
  String jerseyNumber = xml.getString("jersey_number");
  String primaryPosition = xml.getString("primary_position");
  String college = xml.getString("college");

  XML seasons = xml.getChild("seasons");
  XML [] season = seasons.getChildren("season");

  for (int i = 0; i < season.length; i++) {
    if (season[i].getString("year").equals(year)) {
      XML team = season[i].getChild("team");
      XML statistics = team.getChild("statistics");
      XML total = statistics.getChild("total");

      int gamesPlayed = Integer.parseInt(total.getString("games_played"));
      int gamesStarted = Integer.parseInt(total.getString("games_started"));
      float minutes = Float.parseFloat(total.getString("minutes"));
      int fieldGoalsMade = Integer.parseInt(total.getString("field_goals_made"));
      int fieldGoalsAtt = Integer.parseInt(total.getString("field_goals_att"));
      int threePointsMade = Integer.parseInt(total.getString("three_points_made"));
      int threePointsAtt = Integer.parseInt(total.getString("three_points_att"));
      int blockedAtt = Integer.parseInt(total.getString("blocked_att"));
      int freeThrowsMade = Integer.parseInt(total.getString("free_throws_made"));
      int freeThrowsAtt = Integer.parseInt(total.getString("free_throws_att"));
      int offensiveRebounds = Integer.parseInt(total.getString("offensive_rebounds"));
      int defensiveRebounds = Integer.parseInt(total.getString("defensive_rebounds"));
      int assists = Integer.parseInt(total.getString("assists"));
      int turnovers = Integer.parseInt(total.getString("turnovers"));
      int steals = Integer.parseInt(total.getString("steals"));
      int blocks = Integer.parseInt(total.getString("blocks"));
      int personalFouls = Integer.parseInt(total.getString("personal_fouls"));
      int techFouls = Integer.parseInt(total.getString("tech_fouls"));
      int points = Integer.parseInt(total.getString("points"));
      int flagrantFouls = Integer.parseInt(total.getString("flagrant_fouls"));
      float freeThrowsPct = Float.parseFloat(total.getString("free_throws_pct"));
      float twoPointsPct = Float.parseFloat(total.getString("two_points_pct"));
      float threePointsPct = Float.parseFloat(total.getString("three_points_pct"));
      float fieldGoalsPct = Float.parseFloat(total.getString("field_goals_pct"));
      int rebounds = Integer.parseInt(total.getString("rebounds"));
      float assistsTurnoverRatio = Float.parseFloat(total.getString("assists_turnover_ratio"));
      int twoPointsMade = Integer.parseInt(total.getString("two_points_made"));
      int twoPointsAtt = Integer.parseInt(total.getString("two_points_att"));

      // initialize the player
      player = new NBAPlayer(id, fullName, jerseyNumber, primaryPosition, college, 
      gamesPlayed, gamesStarted, minutes, fieldGoalsMade, fieldGoalsAtt, 
      threePointsMade, threePointsAtt, blockedAtt, freeThrowsMade, freeThrowsAtt, 
      offensiveRebounds, defensiveRebounds, assists, turnovers, steals, blocks, 
      personalFouls, techFouls, points, flagrantFouls, freeThrowsPct, twoPointsPct, 
      threePointsPct, fieldGoalsPct, rebounds, assistsTurnoverRatio, twoPointsMade, 
      twoPointsAtt);

      // exit loop since data is already found
      NBAPlayerInit = true;
      return player;
    }
  }

  return null;
}

/*
  This method will return the list of all NBA games based on the 
 year, month and day
 */
ArrayList <NBAGame> getAllGamesOnDate(String year, String month, String day) {
  println("********** Getting all games for " + year + "/" + month + "/" + day + " **********");
  ArrayList <NBAGame> allGames = new ArrayList<NBAGame>();
  String URI = "http://api.sportradar.us/nba-t3/games/" + year + "/" + month + "/" + day + "/schedule.xml?api_key=" + NBAkey;
  println("URI is: " + URI);
  xml = loadXML(URI);

  XML dailyScheduleXML = xml.getChild("daily-schedule");
  XML gamesXML = dailyScheduleXML.getChild("games");
  XML [] gameXML = gamesXML.getChildren("game");

  for (int i = 0; i < gameXML.length; i++) {
    XML home = gameXML[i].getChild("home");
    XML away = gameXML[i].getChild("away");

    // place holders for data to be pushed into Game objects
    String id = gameXML[i].getString("id");
    String title = gameXML[i].getString("title");
    String status = gameXML[i].getString("status");
    String coverage = gameXML[i].getString("coverage");
    String homeTeamID = gameXML[i].getString("home_team");
    String awayTeamID = gameXML[i].getString("away_team");
    String scheduled = gameXML[i].getString("scheduled");
    String homeTeamName = home.getString("name");
    String awayTeamName = away.getString("name");

    NBAGame newGame = new NBAGame(id, title, status, coverage, homeTeamID, awayTeamID, scheduled, homeTeamName, awayTeamName);
    allGames.add(newGame);
  }

  return allGames;
}

/*
  This method will print out all the nba teams
 ONLY FOR DEBUGGING AND TESTING
 */
void leagueHierarchy() {
  println("********** LEAGUE HIERARCHY **********");
  xml = loadXML("cache/LeagueHierarchy.xml");
  XML [] conference = xml.getChildren("conference");

  for (int i = 0; i < conference.length; i++) {
    println(conference[i].getString("name"));
    XML [] division = conference[i].getChildren("division");
    for (int j = 0; j < division.length; j++) {
      println(division[j].getString("name"));
      XML [] team = division[j].getChildren("team");
      for (int k = 0; k < team.length; k++) {
        String name = team[k].getString("name");
        String id = team[k].getString("id");
        String market = team[k].getString("market");
        println(market + " " + name + ", " + id);
      }
    }
  }
}

/*
  This method will check if a file exists based on the path
 This method will return true if the file exists or false otherwise
 */
boolean checkIfFileExists(String path) {
  File fileDir = getFilesDir();
  // check if file exists
  File f = new File(fileDir.getAbsolutePath() + path);
  if (f.exists() && !f.isDirectory()) {
    return true;
  } else {
    return false;
  }
}

