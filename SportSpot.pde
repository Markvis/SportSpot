// imports
import apwidgets.*;
import java.io.*;

// globals
int mode;
XML xml;
TeamNameAndIDHash teamNameAndIDHash;

// keys
String NBAkey = "k4mqkpzfmq24f7yatqyvztxk";
String MLBkey = "4nfwbpjthrsfsaeeh73szu8j";

void setup() {
  orientation(PORTRAIT);
  //frameRate(30);
  noLoop();
  println("setup");
  int mode = 0;

  // TESTS
  Team Warriors = new Team();
  teamNameAndIDHash = new TeamNameAndIDHash();
  println(teamNameAndIDHash.toString());

  //dayScreduleRetrieve("2015", "04", "21");
  //goldenStateProfile();
  //leagueHierarchy();

  // stephen curry
  //playerProfile("8ec91366-faea-4196-bbfd-b8fab7434795");
  // lebron james 0afbe608-940a-4d5d-a1f7-468718c67d91
  //playerProfile("0afbe608-940a-4d5d-a1f7-468718c67d91");

  // getNBATeamSeasonTotalStats EXAMPLE
  //getNBATeamSeasonTotalStats("583ec825-fb46-11e1-82cb-f4ce4684ea4c", "2014");

  println("END SETUP");
} // END SETUP

void draw() {
  background(0);
}

Team getNBATeamSeasonTotalStats(String teamID, String year) {
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

  Team team = new Team(teamName, gamesPlayed, minutes, fieldGoalsMade, fieldGoalsAtt, threePointsMade, threePointsAtt, 
  blockedAtt, freeThrowsMade, freeThrowsAtt, offensiveRebounds, defensiveRebounds, assists, 
  turnovers, steals, blocks, personalFouls, techFouls, points, fastBreakPoints, paintPts, flagrantFouls, 
  pointsOffTurnovers, secondChancePoints, freeThrowsPct, twoPointsPct, threePointsPct, fieldGoalsPct, 
  rebounds, assistsTurnoverRatio, twoPointsMade, twoPointsAtt);

  println(team.toString());

  return team;
}

Player getNBAPlayerStats(String playerID, String year) {
  Player player = new Player();

  return player;
}

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

void dayScreduleRetrieve(String year, String month, String day) {
  println("********** DAILY SCHEDULE **********");
  File fileDir = getFilesDir();
  String dayScheduleURI = "http://api.sportradar.us/nba-t3/games/" + year + "/" + month + "/" + day + "/schedule.xml?api_key=" + NBAkey;
  println("URI is: " + dayScheduleURI);

  // check if file exists
  File f = new File(fileDir.getAbsolutePath() + "/daySchedule" + year + month + day + ".xml");
  if (f.exists() && !f.isDirectory()) {
    println("loading XML from local cache");
    xml = loadXML(fileDir.getAbsolutePath() + "/daySchedule" + year + month + day + ".xml");
  } else {
    println("loading XML from online");
    xml = loadXML(dayScheduleURI);
    saveXML(xml, fileDir.getAbsolutePath() + "/daySchedule" + year + month + day + ".xml");
  }

  //  println(xml.listChildren("daily-schedule"));

  XML dailySchedule = xml.getChild("daily-schedule");

  println("Date: " + dailySchedule.getString("date"));

  XML games = dailySchedule.getChild("games");
  XML [] game = games.getChildren("game");

  for (int i = 0; i < game.length; i++) {
    //String id = game[i].getString("id");
    String title = game[i].getString("title");
    String status = game[i].getString("status");
    println(title + ", " + status);

    XML homeTeam = game[i].getChild("home");
    XML awayTeam = game[i].getChild("away");

    println(homeTeam.getString("name") + " vs. " + awayTeam.getString("name"));
  }
}

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

void goldenStateProfile() {
  println("********** GOLDEN STATE PROFILE **********");
  File fileDir = getFilesDir();
  String gwURI = "http://api.sportradar.us/nba-t3/teams/583ec825-fb46-11e1-82cb-f4ce4684ea4c/profile.xml?api_key=k4mqkpzfmq24f7yatqyvztxk";

  // check if file exists
  File f = new File(fileDir.getAbsolutePath() + "/goldenStateProfile.xml");
  if (f.exists() && !f.isDirectory()) {
    println("loading XML from local cache");
    xml = loadXML(fileDir.getAbsolutePath() + "/goldenStateProfile.xml");
  } else {
    println("loading XML from online database");
    xml = loadXML(gwURI);
    saveXML(xml, fileDir.getAbsolutePath() + "/goldenStateProfile.xml");
  }

  XML players = xml.getChild("players");
  XML [] player = players.getChildren("player");

  for (int i = 0; i < player.length; i++) {
    String playerName = player[i].getString("full_name");
    String college = player[i].getString("college");
    String jerseyNumber = player[i].getString("jersey_number");
    String primaryPos = player[i].getString("primary_position");
    println(playerName + ", " + college + ", " + jerseyNumber + ", " + primaryPos);
  }
}

void playerProfile(String playerID) {
  println("********** PLAYER PROFILE **********");
  File fileDir = getFilesDir();
  //String curry = "http://api.sportradar.us/nba-t3/players/8ec91366-faea-4196-bbfd-b8fab7434795/profile.xml?api_key=k4mqkpzfmq24f7yatqyvztxk";
  //String lebron = "";
  String playerXML = "http://api.sportradar.us/nba-t3/players/" + playerID + "/profile.xml?api_key=" + NBAkey;
  println("URI: " + playerXML);

  // check if file exists
  File f = new File(fileDir.getAbsolutePath() + "/player/" + playerID + ".xml");
  if (f.exists() && !f.isDirectory()) {
    println("loading XML from local cache");
    xml = loadXML(fileDir.getAbsolutePath() + "/player/" + playerID + ".xml");
  } else {
    println("loading XML from online database");
    xml = loadXML(playerXML);
    saveXML(xml, fileDir.getAbsolutePath() + "/player/" + playerID + ".xml");
  }

  //XML player = xml.getParent();
  String playerFullName = xml.getString("full_name");
  String jerseyNumber = xml.getString("jersey_number");
  println("Player: " + playerFullName + ", #" + jerseyNumber);

  XML seasons = xml.getChild("seasons");
  XML[] season = seasons.getChildren("season");
  for (int i = 0; i < season.length; i++) {
    String year = season[i].getString("year");
    println("Year: " + year);

    // show team
    XML team = season[i].getChild("team");
    String teamName = team.getString("name");
    String teamMarket = team.getString("market");
    XML stat = team.getChild("statistics");

    // display totals
    XML total = stat.getChild("total");
    String totalThreePointsMade = total.getString("three_points_made");
    String totalThreePointsAttempted = total.getString("three_points_att");

    // number of games
    String total_games_played = total.getString("games_played");
    String total_games_started = total.getString("games_started");

    // field goals
    String total_field_goals_made = total.getString("field_goals_made");
    String total_field_goals_att = total.getString("field_goals_att");

    println("Games played: " + total_games_played + ", Games started: " + total_games_started);
    println("Field goals made: " + total_field_goals_made + ", Field goals attempted: " + total_field_goals_att);
    println("Three points made: " + totalThreePointsMade + ", Three points attempted: " + totalThreePointsAttempted);
  }
}

