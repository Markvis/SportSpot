// imports
import apwidgets.*;
import java.io.*;
import ketai.ui.*;
import android.os.StrictMode; 

// globals
int mode = 4;
XML xml;

// keys
String NBAkey = "k4mqkpzfmq24f7yatqyvztxk";
String MLBkey = "4nfwbpjthrsfsaeeh73szu8j";

//selectionlists for team1 & team2 in mode0
KetaiList selectionlist;
KetaiList selectionlist2;

//playerlists for player1 & player2 in mode4
KetaiList playerlist;
KetaiList playerlist2;

ArrayList<String> teams = new ArrayList<String>();
ArrayList<String> players = new ArrayList<String>();

//widget containers and buttons for team selection in mode0
APWidgetContainer widgetContainer_SubmitTeams;
APButton button_submit, button_team1, button_team2;

//widget containers and buttons for graphs in mode1
APWidgetContainer widgetContainer_Graphs;
APButton button_BarGraphs, button_LineGraphs, button_Statistics, button_BackM1, button_NextM1;

//widget containers and buttons for mode4
APWidgetContainer widgetContainer_SubmitPlayers;
APButton button_submit4, button_player1, button_player2;

/*
  GRAPHS INCLUDED:
 - 3 Pointers %
 - Field Goals %
 - Free Throws %
 */

String team1 = "Team 1";
String team2 = "Team 2";
String season = "2014";

String player1 = "Player 1";
String player2 = "Player 2";

NBATeam team1_obj;
NBATeam team2_obj;

NBAPlayer player1_obj;
NBAPlayer player2_obj;

//variables for mode0
String selection = "";
boolean team1_pressed = false;
boolean team2_pressed = false;
boolean player1_pressed = false;
boolean player2_pressed = false;

int ThreePointPerc;
int FieldGoalsPerc;
int FreeThrowsPerc;
int bar_w, bar_h;

float score65 = 65;
float score38 = 38;
float score14 = 14;
float score81 = 81;
float score55 = 55;

int moveLeft;
int moveRight;
int moveUp;
int moveDown;

/*
  COMPLETE WORKING METHODS SO FAR
 AND METHODS YOU SHOULD USE
 - getNBATeamSeasonTotalStats
 - getNBAPlayerStats
 - getAllGamesOnDate
 */

void setup() {
  orientation(LANDSCAPE);
  //frameRate(15);  
  noLoop();
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

  //adding players to players ArrayList
  players.add("Stephen Curry");
  players.add("Lebron James");

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
  button_BarGraphs  = new APButton(width/2 - width/4 - width/12, height - height/6, "Bar Graphs");
  button_LineGraphs = new APButton(width/2 - width/12, height - height/6, "Line Graphs");
  button_Statistics = new APButton(width/2 + width/4 - width/12, height - height/6, "    ?    ");
  button_BackM1 = new APButton(width - width/8, height/18, "  Back  ");
  button_NextM1 = new APButton(width - width/8, height/5, " Next ");
  widgetContainer_Graphs.addWidget(button_BarGraphs);
  widgetContainer_Graphs.addWidget(button_LineGraphs);
  widgetContainer_Graphs.addWidget(button_Statistics);
  widgetContainer_Graphs.addWidget(button_BackM1);
  widgetContainer_Graphs.addWidget(button_NextM1);
  widgetContainer_SubmitTeams.show();
  widgetContainer_Graphs.hide();

  //widget container for buttons in mode4
  widgetContainer_SubmitPlayers = new APWidgetContainer(this);
  button_submit4 = new APButton(width/2 - width/12, height - height/4, width/6, height/6, "Submit");
  button_player1 = new APButton(width/12, height/9, width/4, height/7, "Select Player 1");
  button_player2 = new APButton(width - width/12 - width/4, height/9, width/4, height/7, "Select Player 2");
  button_submit4.setTextSize(20);
  button_player1.setTextSize(18);
  button_player2.setTextSize(18);
  widgetContainer_SubmitPlayers.addWidget(button_submit4);
  widgetContainer_SubmitPlayers.addWidget(button_player1);
  widgetContainer_SubmitPlayers.addWidget(button_player2);
  //widgetContainer_SubmitPlayers.hide();

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
   
   NBAGameSummary gameSum = getNBAGameSummary("c786959b-97bd-45e2-ba4f-77377633e87e");
   println(gameSum.getHomeTeamName() + " vs. " + gameSum.getAwayTeamName());
   
   // ****** END OF TESTS / EXAMPLES ******
   */

  println("END SETUP");
} // END SETUP

void draw() {

  //mode 0 - TEAM SELECTIONS & SUBMISSIONS
  if (mode == 0) {
    background(0, 0, 80);
    textAlign(CENTER);

    fill(255);

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

    moveGraph(0, 80, 0, 50);

    //creating x- and y-axis for the bar graphs
    stroke(255);
    fill(255);
    strokeWeight(10);
    line(width/6 - moveLeft + moveRight, height-height/3 - moveUp + moveDown, width-(width/6) - moveLeft + moveRight, height-height/3 - moveUp + moveDown);
    line(width/6 - moveLeft + moveRight, height-height/3 - moveUp + moveDown, width/6 - moveLeft + moveRight, 100 - moveUp + moveDown);
    //creating short lines to divide the y-axis to 10 parts
    strokeWeight(5);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - ((height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - ((height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (2*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (2*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (3*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (3*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (4*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (4*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (5*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (5*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (6*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (6*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (7*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (7*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (8*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (8*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (9*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (9*(height-height/3 - 100)/10) - moveUp + moveDown);

    text("0", width/6 - 60 - moveLeft + moveRight, height-height/3 + 18 - moveUp + moveDown);
    text("50", width/6 - 70 - moveLeft + moveRight, (height-height/3) - (5*(height-height/3 - 100)/10) + 18 - moveUp + moveDown);
    text("100", width/6 - 70 - moveLeft + moveRight, (height-height/3) - (10*(height-height/3 - 100)/10) + 18 - moveUp + moveDown);

    fill(255);
    textSize(60);
    text("SEASON STATISTICS", width/2 - moveLeft + moveRight, height/14 - moveUp + moveDown);

    textSize(40);
    text(team1_obj.getTeamName(), width/14, height/4);
    text(team2_obj.getTeamName(), width/14, height/2);
    fill(255, 51, 51);   
    rect(width/20, height/4 + height/20, width/22, height/16); 
    fill(255, 153, 51);
    rect(width/20, height/2 + height/20, width/22, height/16); 

    float team1_3PointerPerc = team1_obj.getThreePointsPct();
    float team2_3PointerPerc = team2_obj.getThreePointsPct();   
    float team1_fieldGoalPerc = team1_obj.getFieldGoalsPct();
    float team2_fieldGoalPerc = team2_obj.getFieldGoalsPct();   
    float team1_freeThrowPerc = team1_obj.getFreeThrowsPct();
    float team2_freeThrowPerc = team2_obj.getFreeThrowsPct();

    //first bar graphs

    //bar graph bottom titles
    fill(255);
    textSize(50);
    text("3 Pointers %", lineBase_w + lineWidth/11 + width/14 - moveLeft + moveRight, lineBase_h+70 - moveUp + moveDown);
    text("Field Goals %", lineBase_w + 2*(lineWidth/11) + 3*(width/14) - moveLeft + moveRight, lineBase_h+70 - moveUp + moveDown);
    text("Free Throws %", lineBase_w + 3*(lineWidth/11) + 5*(width/14) - moveLeft + moveRight, lineBase_h+70 - moveUp + moveDown);

    //team1 bars
    fill(255, 51, 51);
    rect(lineBase_w + (lineWidth/11) - moveLeft + moveRight, lineBase_h - moveUp + moveDown, width/14, -(team1_3PointerPerc)*lineHeight - moveUp + moveDown);
    rect(lineBase_w + 2*(lineWidth/11) + 2*(width/14) - moveLeft + moveRight, lineBase_h - moveUp + moveDown, width/14, -(team1_fieldGoalPerc)*lineHeight - moveUp + moveDown);
    rect(lineBase_w + 3*(lineWidth/11) + 4*(width/14) - moveLeft + moveRight, lineBase_h - moveUp + moveDown, width/14, -(team1_freeThrowPerc)*lineHeight - moveUp + moveDown);

    //team2 bars
    fill(255, 153, 51);
    rect(lineBase_w + (lineWidth/11 + width/14) - moveLeft + moveRight, lineBase_h - moveUp + moveDown, width/14, -(team2_3PointerPerc)*lineHeight - moveUp + moveDown);
    rect(lineBase_w + 2*(lineWidth/11) + 3*(width/14) - moveLeft + moveRight, lineBase_h - moveUp + moveDown, width/14, -(team2_fieldGoalPerc)*lineHeight - moveUp + moveDown);
    rect(lineBase_w + 3*(lineWidth/11) + 5*(width/14) - moveLeft + moveRight, lineBase_h - moveUp + moveDown, width/14, -(team2_freeThrowPerc)*lineHeight - moveUp + moveDown);


    //        if (velocity1 < -(score/100)*lineHeight) {
    //          fill(255, 51, 51);
    //          rect(lineBase_w + (lineWidth/9), lineBase_h, width/12, velocity1);
    //        }
    //        if (velocity2 < -(score2/100)*lineHeight) {
    //          fill(255, 153, 51);
    //          rect(lineBase_w + (lineWidth/9 + width/12), lineBase_h, width/12, velocity2);
    //        }  
    //        
    //        velocity1 -= 0.1;
    //        velocity2 -= 0.1;
  }

  //Mode 2 PER game statistics
  else if (mode == 2) {
    background(0, 0, 80);

    float lineBase_h = height-height/3;
    float lineBase_w = width/6;
    float lineTop_h = height - 100;
    float lineWidth = 2*(width/3);
    float lineHeight = height-(height/3)-100;

    moveGraph(0, 80, 0, 50);

    //creating x- and y-axis for the bar graphs
    stroke(255);
    fill(255);
    strokeWeight(10);
    line(width/6 - moveLeft + moveRight, height-height/3 - moveUp + moveDown, width-(width/6) - moveLeft + moveRight, height-height/3 - moveUp + moveDown);
    line(width/6 - moveLeft + moveRight, height-height/3 - moveUp + moveDown, width/6 - moveLeft + moveRight, 100 - moveUp + moveDown);
    //creating short lines to divide the y-axis to 10 parts
    strokeWeight(5);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - ((height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - ((height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (2*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (2*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (3*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (3*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (4*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (4*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (5*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (5*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (6*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (6*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (7*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (7*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (8*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (8*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (9*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (9*(height-height/3 - 100)/10) - moveUp + moveDown);

    text("0", width/6 - 60 - moveLeft + moveRight, height-height/3 + 18 - moveUp + moveDown);
    text("50", width/6 - 70 - moveLeft + moveRight, (height-height/3) - (5*(height-height/3 - 100)/10) + 18 - moveUp + moveDown);
    text("100", width/6 - 70 - moveLeft + moveRight, (height-height/3) - (10*(height-height/3 - 100)/10) + 18 - moveUp + moveDown);

    fill(255);
    textSize(60);
    text("PER GAME STATISTICS", width/2 - moveLeft + moveRight, height/14 - moveUp + moveDown);

    textSize(40);
    text(team1_obj.getTeamName(), width/14, height/4);
    text(team2_obj.getTeamName(), width/14, height/2);
    fill(255, 51, 51);   
    rect(width/20, height/4 + height/20, width/22, height/16); 
    fill(255, 153, 51);
    rect(width/20, height/2 + height/20, width/22, height/16); 

    float team1_Rebounds = (((float)team1_obj.getOffensiveRebounds() + (float)team1_obj.getDefensiveRebounds())/82)/100;
    float team2_Rebounds = (((float)team2_obj.getOffensiveRebounds() + (float)team2_obj.getDefensiveRebounds())/82)/100;   
    float team1_Assists = ((float)team1_obj.getAssists()/82)/100;
    float team2_Assists = ((float)team2_obj.getAssists()/82)/100;   
    float team1_Turnovers = ((float)team1_obj.getTurnovers()/82)/100;
    float team2_Turnovers = ((float)team2_obj.getTurnovers()/82)/100;

    //bar graph bottom titles
    fill(255);
    textSize(50);
    text("Rebounds", lineBase_w + lineWidth/11 + width/14 - moveLeft + moveRight, lineBase_h+70 - moveUp + moveDown);
    text("Assists", lineBase_w + 2*(lineWidth/11) + 3*(width/14) - moveLeft + moveRight, lineBase_h+70 - moveUp + moveDown);
    text("Turnovers", lineBase_w + 3*(lineWidth/11) + 5*(width/14) - moveLeft + moveRight, lineBase_h+70 - moveUp + moveDown);

    //team1 bars
    fill(255, 51, 51);
    rect(lineBase_w + (lineWidth/11) - moveLeft + moveRight, lineBase_h - moveUp + moveDown, width/14, - (team1_Rebounds)*lineHeight - moveUp + moveDown);
    rect(lineBase_w + 2*(lineWidth/11) + 2*(width/14) - moveLeft + moveRight, lineBase_h - moveUp + moveDown, width/14, - (team1_Assists)*lineHeight - moveUp + moveDown);
    rect(lineBase_w + 3*(lineWidth/11) + 4*(width/14) - moveLeft + moveRight, lineBase_h - moveUp + moveDown, width/14, - (team1_Turnovers)*lineHeight - moveUp + moveDown);

    //team2 bars
    fill(255, 153, 51);
    rect(lineBase_w + (lineWidth/11 + width/14) - moveLeft + moveRight, lineBase_h - moveUp + moveDown, width/14, - (team2_Rebounds)*lineHeight - moveUp + moveDown);
    rect(lineBase_w + 2*(lineWidth/11) + 3*(width/14) - moveLeft + moveRight, lineBase_h - moveUp + moveDown, width/14, - (team2_Assists)*lineHeight - moveUp + moveDown);
    rect(lineBase_w + 3*(lineWidth/11) + 5*(width/14) - moveLeft + moveRight, lineBase_h - moveUp + moveDown, width/14, - (team2_Turnovers)*lineHeight - moveUp + moveDown);
  }

  //Mode 3 displays where points come from
  else if (mode == 3) {
    background(0, 0, 80);

    float lineBase_h = height-height/3;
    float lineBase_w = width/6;
    float lineTop_h = height - 100;
    float lineWidth = 2*(width/3);
    float lineHeight = height-(height/3)-100;

    moveGraph(0, 80, 0, 50);

    //creating x- and y-axis for the bar graphs
    stroke(255);
    fill(255);
    strokeWeight(10);
    line(width/6 - moveLeft + moveRight, height-height/3 - moveUp + moveDown, width-(width/6) - moveLeft + moveRight, height-height/3 - moveUp + moveDown);
    line(width/6 - moveLeft + moveRight, height-height/3 - moveUp + moveDown, width/6 - moveLeft + moveRight, 100 - moveUp + moveDown);
    //creating short lines to divide the y-axis to 10 parts
    strokeWeight(5);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - ((height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - ((height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (2*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (2*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (3*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (3*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (4*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (4*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (5*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (5*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (6*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (6*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (7*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (7*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (8*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (8*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (9*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (9*(height-height/3 - 100)/10) - moveUp + moveDown);

    text("0", width/6 - 60 - moveLeft + moveRight, height-height/3 + 18 - moveUp + moveDown);
    text("50", width/6 - 70 - moveLeft + moveRight, (height-height/3) - (5*(height-height/3 - 100)/10) + 18 - moveUp + moveDown);
    text("100", width/6 - 70 - moveLeft + moveRight, (height-height/3) - (10*(height-height/3 - 100)/10) + 18 - moveUp + moveDown);

    fill(255);
    textSize(60);
    text("PER GAME STATISTICS", width/2 - moveLeft + moveRight, height/14 - moveUp + moveDown);

    textSize(40);
    text(team1_obj.getTeamName(), width/14, height/4);
    text(team2_obj.getTeamName(), width/14, height/2);
    fill(255, 51, 51);   
    rect(width/20, height/4 + height/20, width/22, height/16); 
    fill(255, 153, 51);
    rect(width/20, height/2 + height/20, width/22, height/16); 

    float team1_Points = (((float)team1_obj.getPoints())/82)/100;
    float team2_Points = (((float)team2_obj.getPoints())/82)/100;   
    float team1_fastBreakPts = ((float)team1_obj.getFastBreakPoints()/82)/100;
    float team2_fastBreakPts = ((float)team2_obj.getFastBreakPoints()/82)/100;   
    float team1_secondChancePts = ((float)team1_obj.getSecondChancePoints()/82)/100;
    float team2_secondChancePts = ((float)team2_obj.getSecondChancePoints()/82)/100;

    //bar graph bottom titles
    fill(255);
    textSize(50);
    text("Points", lineBase_w + lineWidth/11 + width/14 - moveLeft + moveRight, lineBase_h+70 - moveUp + moveDown);
    text("Fast Break Pts", lineBase_w + 2*(lineWidth/11) + 3*(width/14) - moveLeft + moveRight, lineBase_h+70 - moveUp + moveDown);
    text("2nd Chance Pts", lineBase_w + 3*(lineWidth/11) + 5*(width/14) - moveLeft + moveRight, lineBase_h+70 - moveUp + moveDown);

    //team1 bars
    fill(255, 51, 51);
    rect(lineBase_w + (lineWidth/11) - moveLeft + moveRight, lineBase_h - moveUp + moveDown, width/14, - (team1_Points)*lineHeight - moveUp + moveDown);
    rect(lineBase_w + 2*(lineWidth/11) + 2*(width/14) - moveLeft + moveRight, lineBase_h - moveUp + moveDown, width/14, - (team1_fastBreakPts)*lineHeight - moveUp + moveDown);
    rect(lineBase_w + 3*(lineWidth/11) + 4*(width/14) - moveLeft + moveRight, lineBase_h - moveUp + moveDown, width/14, - (team1_secondChancePts)*lineHeight - moveUp + moveDown);

    //team2 bars
    fill(255, 153, 51);
    rect(lineBase_w + (lineWidth/11 + width/14) - moveLeft + moveRight, lineBase_h - moveUp + moveDown, width/14, - (team2_Points)*lineHeight - moveUp + moveDown);
    rect(lineBase_w + 2*(lineWidth/11) + 3*(width/14) - moveLeft + moveRight, lineBase_h - moveUp + moveDown, width/14, - (team2_fastBreakPts)*lineHeight - moveUp + moveDown);
    rect(lineBase_w + 3*(lineWidth/11) + 5*(width/14) - moveLeft + moveRight, lineBase_h - moveUp + moveDown, width/14, - (team2_secondChancePts)*lineHeight - moveUp + moveDown);
  }
  // mode 4 - PLAYER SELECTIONS & SUBMISSIONS 
  else if (mode == 4) {
    background(0, 0, 80);
    textAlign(CENTER);

    fill(255);

    textSize(65);
    text(player1, width/2, height/2 - height/8);
    text(player2, width/2, height/2 + height/8);
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
  // mode 5 - PLAYER COMPARISONS
  else if (mode == 5) {
    background(0, 0, 80);

    float lineBase_h = height-height/3;
    float lineBase_w = width/6;
    float lineTop_h = height - 100;
    float lineWidth = 2*(width/3);
    float lineHeight = height-(height/3)-100;

    moveGraph(0, 80, 0, 50);

    //creating x- and y-axis for the bar graphs
    stroke(255);
    fill(255);
    strokeWeight(10);
    line(width/6 - moveLeft + moveRight, height-height/3 - moveUp + moveDown, width-(width/6) - moveLeft + moveRight, height-height/3 - moveUp + moveDown);
    line(width/6 - moveLeft + moveRight, height-height/3 - moveUp + moveDown, width/6 - moveLeft + moveRight, 100 - moveUp + moveDown);
    //creating short lines to divide the y-axis to 10 parts
    strokeWeight(5);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - ((height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - ((height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (2*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (2*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (3*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (3*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (4*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (4*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (5*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (5*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (6*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (6*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (7*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (7*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (8*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (8*(height-height/3 - 100)/10) - moveUp + moveDown);
    line(width/6 - 20 - moveLeft + moveRight, (height-height/3) - (9*(height-height/3 - 100)/10) - moveUp + moveDown, width/6 + 20 - moveLeft + moveRight, (height-height/3) - (9*(height-height/3 - 100)/10) - moveUp + moveDown);

    text("0", width/6 - 60 - moveLeft + moveRight, height-height/3 + 18 - moveUp + moveDown);
    text("50", width/6 - 70 - moveLeft + moveRight, (height-height/3) - (5*(height-height/3 - 100)/10) + 18 - moveUp + moveDown);
    text("100", width/6 - 70 - moveLeft + moveRight, (height-height/3) - (10*(height-height/3 - 100)/10) + 18 - moveUp + moveDown);

    fill(255);
    textSize(60);
    text("PLAYER SEASON STATISTICS", width/2 - moveLeft + moveRight, height/14 - moveUp + moveDown);

    textSize(40);
    text(player1_obj.getFullName(), width/14, height/4);
    text(player2_obj.getFullName(), width/14, height/2);
    fill(255, 51, 51);   
    rect(width/20, height/4 + height/20, width/22, height/16); 
    fill(255, 153, 51);
    rect(width/20, height/2 + height/20, width/22, height/16); 

    float player1_3PointerPerc = player1_obj.getThreePointsPct();
    float player2_3PointerPerc = player2_obj.getThreePointsPct();   
    float player1_fieldGoalPerc = player1_obj.getFieldGoalsPct();
    float player2_fieldGoalPerc = player2_obj.getFieldGoalsPct();   
    float player1_freeThrowPerc = player1_obj.getFreeThrowsPct();
    float player2_freeThrowPerc = player2_obj.getFreeThrowsPct();

    //first bar graphs

    //bar graph bottom titles
    fill(255);
    textSize(50);
    text("3 Pointers %", lineBase_w + lineWidth/11 + width/14 - moveLeft + moveRight, lineBase_h+70 - moveUp + moveDown);
    text("Field Goals %", lineBase_w + 2*(lineWidth/11) + 3*(width/14) - moveLeft + moveRight, lineBase_h+70 - moveUp + moveDown);
    text("Free Throws %", lineBase_w + 3*(lineWidth/11) + 5*(width/14) - moveLeft + moveRight, lineBase_h+70 - moveUp + moveDown);

    //player1 bars
    fill(255, 51, 51);
    rect(lineBase_w + (lineWidth/11) - moveLeft + moveRight, lineBase_h - moveUp + moveDown, width/14, - (player1_3PointerPerc)*lineHeight - moveUp + moveDown);
    rect(lineBase_w + 2*(lineWidth/11) + 2*(width/14) - moveLeft + moveRight, lineBase_h - moveUp + moveDown, width/14, - (player1_fieldGoalPerc)*lineHeight - moveUp + moveDown);
    rect(lineBase_w + 3*(lineWidth/11) + 4*(width/14) - moveLeft + moveRight, lineBase_h - moveUp + moveDown, width/14, - (player1_freeThrowPerc)*lineHeight - moveUp + moveDown);

    //player2 bars
    fill(255, 153, 51);
    rect(lineBase_w + (lineWidth/11 + width/14) - moveLeft + moveRight, lineBase_h - moveUp + moveDown, width/14, - (player2_3PointerPerc)*lineHeight - moveUp + moveDown);
    rect(lineBase_w + 2*(lineWidth/11) + 3*(width/14) - moveLeft + moveRight, lineBase_h - moveUp + moveDown, width/14, - (player2_fieldGoalPerc)*lineHeight - moveUp + moveDown);
    rect(lineBase_w + 3*(lineWidth/11) + 5*(width/14) - moveLeft + moveRight, lineBase_h - moveUp + moveDown, width/14, - (player2_freeThrowPerc)*lineHeight - moveUp + moveDown);
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
  redraw();
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
    } else if (player1_pressed) {
      player1 = selection;
    } else if (player2_pressed) {
      player2 = selection;
    }
  }
  team1_pressed = false;
  team2_pressed = false;
  player1_pressed = false;
  player2_pressed = false;
  redraw();
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
      // required for calling network on newer versions of android
      StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
      StrictMode.setThreadPolicy(policy);

      team1_obj = getNBATeamSeasonTotalStats(Database.teamNameAndIDHash.get(team1), season);
      team2_obj = getNBATeamSeasonTotalStats(Database.teamNameAndIDHash.get(team2), season);
      team1_obj.setTeamName(team1);
      team2_obj.setTeamName(team2);    

      mode = 1;
      widgetContainer_Graphs.show();
      widgetContainer_SubmitTeams.hide();
    }
  }

  //BUTTONS OF MODE1
  else if (widget == button_BarGraphs) {
  } else if (widget == button_LineGraphs) {
  } else if (widget == button_Statistics) {
    mode = 0;
    widgetContainer_Graphs.hide();
    widgetContainer_SubmitTeams.show();
    fill(255);
  } else if (widget == button_BackM1) {
    if (mode == 1) {
      mode = 0;
      widgetContainer_Graphs.hide();
      widgetContainer_SubmitTeams.show();
      fill(255);
    } else if (mode == 2) {
      mode = 1;
      widgetContainer_Graphs.show();
    } else if (mode == 3) {
      mode = 2;
      widgetContainer_Graphs.show();
    }
  }

  //Next button changes modes
  if (widget == button_NextM1) {  
    if (mode == 1) {
      mode = 2;
    } else if (mode == 2) {
      mode = 3;
    }
    widgetContainer_Graphs.show();
  }

  //BUTTONS OF MODE4
  if (widget == button_player1) {    
    playerlist = new KetaiList(this, players);
    player1_pressed = true;
  } else if (widget == button_player2) {
    playerlist2 = new KetaiList(this, players);
    player2_pressed = true;
  } else if (widget == button_submit4) {
    if (player1 == player2) {
      KetaiAlertDialog.popup(this, "Nice try...", "Please choose two different players.");
    } else if ((player1 == "Player 1") || (player2 == "Player 2")) {
      KetaiAlertDialog.popup(this, "Not ready yet!", "Make sure you pick 2 players.");
    } else {
      // required for calling network on newer versions of android
      StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
      StrictMode.setThreadPolicy(policy);

      player1_obj = getNBAPlayerStats(Database.playerNameAndIDHash.get(player1), season);
      player2_obj = getNBAPlayerStats(Database.playerNameAndIDHash.get(player2), season);
      player1_obj.setFullName(player1);
      player2_obj.setFullName(player2);    

      mode = 5;
      widgetContainer_Graphs.show();
      widgetContainer_SubmitPlayers.hide();
      widgetContainer_SubmitTeams.hide();
    }
  }
  redraw();
}

NBAGameSummary getNBAGameSummary(String gameID) {
  println("********** getNBALiveGameData **********");
  String URI = "http://api.sportradar.us/nba-t3/games/" + gameID +"/summary.xml?api_key=" + NBAkey;
  NBAGameSummary nbaGameSummary;
  xml = loadXML(URI);
  //xml = loadXML("cache/LiveGameExample.xml");

  // get xml lines
  XML [] team = xml.getChildren("team");
  XML homeTeamScoring = team[0].getChild("scoring");
  XML awayTeamScoring = team[1].getChild("scoring");
  XML [] homeTeamQuarter = homeTeamScoring.getChildren("quarter");
  XML [] awayTeamQuarter = awayTeamScoring.getChildren("quarter");
  XML homeTeamStats = team[0].getChild("statistics");
  XML awayTeamStats = team[1].getChild("statistics");

  // ***** GAME INFO *****
  String gametitle = xml.getString("title");
  String gameStatus = xml.getString("status");
  String gameScheduled = xml.getString("scheduled");
  String gameAttendance = xml.getString("attendance");
  String gameClock = xml.getString("clock");
  String gameQuarter = xml.getString("quarter");

  // ***** START HOME ****
  // Home Team Data
  String homeTeamName = team[0].getString("name");
  String homeTeamID = team[0].getString("id");

  // Quarterly Points
  int homeQuarterOnePoints = Integer.parseInt(homeTeamQuarter[0].getString("points"));
  int homeQuarterTwoPoints = Integer.parseInt(homeTeamQuarter[1].getString("points"));
  int homeQuarterThreePoints = Integer.parseInt(homeTeamQuarter[2].getString("points"));
  int homeQuarterFourPoints = Integer.parseInt(homeTeamQuarter[3].getString("points"));

  // Team Statistics
  String homeMinutes = homeTeamStats.getString("minutes");
  int homeFieldGoalsMade = Integer.parseInt(homeTeamStats.getString("field_goals_made"));
  int homeFieldGoalsAtt = Integer.parseInt(homeTeamStats.getString("field_goals_att"));
  float homeFieldGoalsPct = Float.parseFloat(homeTeamStats.getString("field_goals_pct"));
  int homeThreePointsMade = Integer.parseInt(homeTeamStats.getString("three_points_made"));
  int homeThreePointsAtt = Integer.parseInt(homeTeamStats.getString("three_points_att"));
  float homeThreePointsPct = Float.parseFloat(homeTeamStats.getString("three_points_pct"));
  int homeTwoPointsMade = Integer.parseInt(homeTeamStats.getString("two_points_made"));
  int homeTwoPointsAtt = Integer.parseInt(homeTeamStats.getString("two_points_att"));
  float homeTwoPointsPct = Float.parseFloat(homeTeamStats.getString("two_points_pct"));
  int homeBlockedAtt = Integer.parseInt(homeTeamStats.getString("blocked_att"));
  int homeFreeThrowsMade = Integer.parseInt(homeTeamStats.getString("free_throws_made"));
  int homeFreeThrowsAtt = Integer.parseInt(homeTeamStats.getString("free_throws_att"));
  float homeFreeThrowsPct = Float.parseFloat(homeTeamStats.getString("free_throws_pct"));
  int homeOffensiveRebounds = Integer.parseInt(homeTeamStats.getString("offensive_rebounds"));
  int homeDefensiveRebounds = Integer.parseInt(homeTeamStats.getString("defensive_rebounds"));
  int homeRebounds = Integer.parseInt(homeTeamStats.getString("rebounds"));
  int homeAssists = Integer.parseInt(homeTeamStats.getString("assists"));
  int homeTurnovers = Integer.parseInt(homeTeamStats.getString("turnovers"));
  int homeSteals = Integer.parseInt(homeTeamStats.getString("steals"));
  int homeBlocks = Integer.parseInt(homeTeamStats.getString("blocks"));
  float homeAssistsTurnoverRatio = Float.parseFloat(homeTeamStats.getString("assists_turnover_ratio"));
  int homePersonalFouls = Integer.parseInt(homeTeamStats.getString("personal_fouls"));
  int homePoints = Integer.parseInt(homeTeamStats.getString("points"));
  int homeTeamTurnovers = Integer.parseInt(homeTeamStats.getString("team_turnovers"));
  int homeTeamRebounds = Integer.parseInt(homeTeamStats.getString("team_rebounds"));
  int homeFlagrantFouls = Integer.parseInt(homeTeamStats.getString("flagrant_fouls"));
  int homePlayerTechFouls = Integer.parseInt(homeTeamStats.getString("player_tech_fouls"));
  int homeTeamTechFouls = Integer.parseInt(homeTeamStats.getString("team_tech_fouls"));
  int homeCoachTechFouls = Integer.parseInt(homeTeamStats.getString("coach_tech_fouls"));
  // ***** END HOME ****

  // ***** START AWAY ****
  // Away Team Data
  String awayTeamName = team[1].getString("name");
  String awayTeamID = team[1].getString("id");

  // Quarterly Points
  int awayQuarterOnePoints = Integer.parseInt(awayTeamQuarter[0].getString("points"));
  int awayQuarterTwoPoints = Integer.parseInt(awayTeamQuarter[1].getString("points"));
  int awayQuarterThreePoints = Integer.parseInt(awayTeamQuarter[2].getString("points"));
  int awayQuarterFourPoints = Integer.parseInt(awayTeamQuarter[3].getString("points"));

  // Team Statistics
  String awayMinutes = awayTeamStats.getString("minutes");
  int awayFieldGoalsMade = Integer.parseInt(awayTeamStats.getString("field_goals_made"));
  int awayFieldGoalsAtt = Integer.parseInt(awayTeamStats.getString("field_goals_att"));
  float awayFieldGoalsPct = Float.parseFloat(awayTeamStats.getString("field_goals_pct"));
  int awayThreePointsMade = Integer.parseInt(awayTeamStats.getString("three_points_made"));
  int awayThreePointsAtt = Integer.parseInt(awayTeamStats.getString("three_points_att"));
  float awayThreePointsPct = Float.parseFloat(awayTeamStats.getString("three_points_pct"));
  int awayTwoPointsMade = Integer.parseInt(awayTeamStats.getString("two_points_made"));
  int awayTwoPointsAtt = Integer.parseInt(awayTeamStats.getString("two_points_att"));
  float awayTwoPointsPct = Float.parseFloat(awayTeamStats.getString("two_points_pct"));
  int awayBlockedAtt = Integer.parseInt(awayTeamStats.getString("blocked_att"));
  int awayFreeThrowsMade = Integer.parseInt(awayTeamStats.getString("free_throws_made"));
  int awayFreeThrowsAtt = Integer.parseInt(awayTeamStats.getString("free_throws_att"));
  float awayFreeThrowsPct = Float.parseFloat(awayTeamStats.getString("free_throws_pct"));
  int awayOffensiveRebounds = Integer.parseInt(awayTeamStats.getString("offensive_rebounds"));
  int awayDefensiveRebounds = Integer.parseInt(awayTeamStats.getString("defensive_rebounds"));
  int awayRebounds = Integer.parseInt(awayTeamStats.getString("rebounds"));
  int awayAssists = Integer.parseInt(awayTeamStats.getString("assists"));
  int awayTurnovers = Integer.parseInt(awayTeamStats.getString("assists"));
  int awaySteals = Integer.parseInt(awayTeamStats.getString("steals"));
  int awayBlocks = Integer.parseInt(awayTeamStats.getString("blocks"));
  float awayAssistsTurnoverRatio = Float.parseFloat(awayTeamStats.getString("assists_turnover_ratio"));
  int awayPersonalFouls = Integer.parseInt(awayTeamStats.getString("personal_fouls"));
  int awayPoints = Integer.parseInt(awayTeamStats.getString("points"));
  int awayTeamTurnovers = Integer.parseInt(awayTeamStats.getString("team_turnovers"));
  int awayTeamRebounds = Integer.parseInt(awayTeamStats.getString("team_rebounds"));
  int awayFlagrantFouls = Integer.parseInt(awayTeamStats.getString("flagrant_fouls"));
  int awayPlayerTechFouls = Integer.parseInt(awayTeamStats.getString("player_tech_fouls"));
  int awayTeamTechFouls = Integer.parseInt(awayTeamStats.getString("team_tech_fouls"));
  int awayCoachTechFouls = Integer.parseInt(awayTeamStats.getString("coach_tech_fouls"));
  // ***** END AWAY ****

  nbaGameSummary = new NBAGameSummary(gametitle, gameStatus, gameScheduled, gameAttendance, 
  gameClock, gameQuarter, homeTeamName, homeTeamID, homeQuarterOnePoints, homeQuarterTwoPoints, 
  homeQuarterThreePoints, homeQuarterFourPoints, homeMinutes, homeFieldGoalsMade, homeFieldGoalsAtt, 
  homeFieldGoalsPct, homeThreePointsMade, homeThreePointsAtt, homeThreePointsPct, homeTwoPointsMade, 
  homeTwoPointsAtt, homeTwoPointsPct, homeBlockedAtt, homeFreeThrowsMade, homeFreeThrowsAtt, 
  homeFreeThrowsPct, homeOffensiveRebounds, homeDefensiveRebounds, homeRebounds, homeAssists, 
  homeTurnovers, homeSteals, homeBlocks, homeAssistsTurnoverRatio, homePersonalFouls, homePoints, 
  homeTeamTurnovers, homeTeamRebounds, homeFlagrantFouls, homePlayerTechFouls, homeTeamTechFouls, 
  homeCoachTechFouls, awayTeamName, awayTeamID, awayQuarterOnePoints, awayQuarterTwoPoints, 
  awayQuarterThreePoints, awayQuarterFourPoints, awayMinutes, awayFieldGoalsMade, awayFieldGoalsAtt, 
  awayFieldGoalsPct, awayThreePointsMade, awayThreePointsAtt, awayThreePointsPct, awayTwoPointsMade, 
  awayTwoPointsAtt, awayTwoPointsPct, awayBlockedAtt, awayFreeThrowsMade, awayFreeThrowsAtt, 
  awayFreeThrowsPct, awayOffensiveRebounds, awayDefensiveRebounds, awayRebounds, awayAssists, 
  awayTurnovers, awaySteals, awayBlocks, awayAssistsTurnoverRatio, awayPersonalFouls, awayPoints, 
  awayTeamTurnovers, awayTeamRebounds, awayFlagrantFouls, awayPlayerTechFouls, awayTeamTechFouls, 
  awayCoachTechFouls);

  return nbaGameSummary;
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

  //println(team.toString());

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

void moveGraph (int left, int right, int up, int down) {

  moveLeft = left;
  moveRight = right;
  moveUp = up;
  moveDown = down;
}

