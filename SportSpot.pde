// imports
import apwidgets.*;
import java.io.*;
import ketai.ui.*;
import android.os.StrictMode;
import java.util.HashMap;
import java.util.Map;
import java.util.Iterator;
import java.util.Calendar;
import java.util.Stack;

/*
  modes
 0 = team selection
 1 = team season stats
 2 = team per game stats
 3 = more team per game stats
 4 = player selection
 5 = player season stats
 6 = relational graphics
 */

// globals
int mode = 99;
XML xml;

// keys
String NBAkey = "k4mqkpzfmq24f7yatqyvztxk";
String MLBkey = "4nfwbpjthrsfsaeeh73szu8j";

//selectionlists for team1 & team2 in mode0
KetaiList selectionlist;
KetaiList selectionlist2;

//selectionlists for additional teams in relational graphs
//in mode 6
KetaiList relGraphList_team3;
KetaiList relGraphList_team4;
KetaiList relGraphList_team5;
KetaiList relGraphList_team6;

boolean relGraph_Team3Pressed = false;
boolean relGraph_Team4Pressed = false;
boolean relGraph_Team5Pressed = false;
boolean relGraph_Team6Pressed = false;
boolean relGraph_showTeam3 = false;
boolean relGraph_showTeam4 = false;
boolean relGraph_showTeam5 = false;
boolean relGraph_showTeam6 = false;
String relGraph_Team3;
String relGraph_Team4;
String relGraph_Team5;
String relGraph_Team6;

//playerlists for player1 & player2 in mode4
KetaiList playerlist;
KetaiList playerlist2;

ArrayList<String> teams = new ArrayList<String>();
ArrayList<String> players = new ArrayList<String>();


//BUTTONS

//widget containers and buttons for team selection in mode0
APWidgetContainer widgetContainer_SubmitTeams;
APButton button_submit, button_team1, button_team2;

//widget containers and buttons for graphs in mode1
APWidgetContainer widgetContainer_Graphs;
APButton button_BarGraphs, button_LineGraphs, button_Statistics, button_BackM1, button_NextM1;

//container and buttons for all the modes within mode7 (Team Comparsion Data Display)
APWidgetContainer TeamComparison_modeChanges;
APButton button_NextM7, button_BackM7, button_ReturnM7;

//widget containers and buttons for mode4
APWidgetContainer widgetContainer_SubmitPlayers;
APButton button_submit4, button_player1, button_player2;

//widget container for mode7
APWidgetContainer widgetContainer_SelectDataDisplay;
APButton button_BarGraph, button_TimeGraph, button_head2head, button_RelGraph, button_BackToTeamSelectionM7;

// widget container for home screen mode 99
APWidgetContainer WC_main = new APWidgetContainer(this);
ArrayList<APButton> WC_mainButtons = new ArrayList<APButton>();
boolean mainModeLoaded = false;

// widget container for live screen mode 98 and other mode 98 requirements
APWidgetContainer WC_live = new APWidgetContainer(this);
ArrayList<APButton> WC_LiveButtons = new ArrayList<APButton>();
ArrayList<NBAGame> gamesToday;
NBAGameSummary selectedGameSummary;
NBAGame selectedGame;
boolean liveModeLoaded = false;
int gameSelected = -1;


// stack for back button
Stack<Integer> backButtonStack = new Stack<Integer>();

/*
  GRAPHS INCLUDED:
 - 3 Pointers %
 - Field Goals %
 - Free Throws %
 */

String team1 = "Team 1";
String team2 = "Team 2";
String team3 = "Add Team";
String team4 = "Add Team";
String team5 = "Add Team";
String team6 = "Add Team";
String season = "2014";

String player1 = "Player 1";
String player2 = "Player 2";

NBATeam team1_obj;
NBATeam team2_obj;
NBATeam team3_obj;
NBATeam team4_obj;
NBATeam team5_obj;
NBATeam team6_obj;

NBATeam team1_obj2013;
NBATeam team2_obj2013; 
NBATeam team1_obj2014; 
NBATeam team2_obj2014; 

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

int moveHorizontal;
int moveVertical;

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
  button_Statistics = new APButton(width/2 + width/4 - width/12, height - height/6, "Teams");
  button_BackM1 = new APButton(width - width/8, height/18, "  Back  ");
  button_NextM1 = new APButton(width - width/8, height/5, " Next ");
  widgetContainer_Graphs.addWidget(button_BarGraphs);
  widgetContainer_Graphs.addWidget(button_LineGraphs);
  widgetContainer_Graphs.addWidget(button_Statistics);
  widgetContainer_Graphs.addWidget(button_BackM1);
  widgetContainer_Graphs.addWidget(button_NextM1);


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


  //widget container for buttons in mode7
  widgetContainer_SelectDataDisplay = new APWidgetContainer(this);
  button_BarGraph  = new APButton(width/2 - width/4, height/2 - height/7 - 30, width/2, height/7, "Bar Graphs");
  button_TimeGraph = new APButton(width/2 - width/4, height/2 - 10, width/2, height/7, "Time Graphs");
  button_RelGraph = new APButton(width/2 - width/4, height/2 + height/7 + 10, width/2, height/7, "Relational Graphs");
  button_head2head = new APButton(width/2 - width/4, height/2 + 2*(height/7) + 30, width/2, height/7, "Head to Head");
  button_BackToTeamSelectionM7 = new APButton(width - width/8, height/18, "  Back  ");
  widgetContainer_SelectDataDisplay.addWidget(button_BarGraph);
  widgetContainer_SelectDataDisplay.addWidget(button_TimeGraph);
  widgetContainer_SelectDataDisplay.addWidget(button_RelGraph);
  widgetContainer_SelectDataDisplay.addWidget(button_head2head);
  widgetContainer_SelectDataDisplay.addWidget(button_BackToTeamSelectionM7);
  button_BarGraph.setTextSize(18);
  button_TimeGraph.setTextSize(18);
  button_RelGraph.setTextSize(18);
  button_head2head.setTextSize(18);


  //widget container for buttons in mode 1-3, 8-10
  TeamComparison_modeChanges = new APWidgetContainer(this);
  //creating & adding buttons for mode1
  button_NextM7 = new APButton(width - 220, height/2 + 10, 200, 160, "Next");
  button_BackM7 = new APButton(width - 220, height/2 - 190, 200, 160, "Back");
  button_ReturnM7 = new APButton(width/2 - (width/2-100)/2, height - 210, width/2 - 100, height/7, "Return to Data Display Selection");
  TeamComparison_modeChanges.addWidget(button_NextM7);
  TeamComparison_modeChanges.addWidget(button_BackM7);
  TeamComparison_modeChanges.addWidget(button_ReturnM7);
  button_ReturnM7.setTextSize(18);

  widgetContainer_Graphs.hide();
  widgetContainer_SubmitPlayers.hide();
  widgetContainer_SelectDataDisplay.hide();
  TeamComparison_modeChanges.hide();
  widgetContainer_SubmitTeams.hide();

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
    preMode();
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

    widgetContainer_SubmitTeams.show();
  }
  //MODE 1: Bar Graphs: 3P %, Field Goal %, Free Throw % - Team Comparison
  else if (mode == 1) {

    background(0, 0, 80);

    float lineBase_h = height-height/3;
    float lineBase_w = width/6;
    float lineTop_h = height - 100;
    float lineWidth = 2*(width/3);
    float lineHeight = 2*(height/3)-100;

    moveGraph(65, 55);

    //creating x- and y-axis for the bar graphs
    stroke(255);
    fill(255);
    strokeWeight(10);
    line(width/6 + moveHorizontal, height-height/3 + moveVertical, width-(width/6) + moveHorizontal, height-height/3 + moveVertical);
    line(width/6 + moveHorizontal, height-height/3 + moveVertical, width/6 + moveHorizontal, 100 + moveVertical);

    //creating short lines to divide the y-axis to 10 parts
    strokeWeight(5);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - ((height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - ((height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (2*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (2*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (3*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (3*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (4*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (4*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (5*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (5*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (6*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (6*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (7*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (7*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (8*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (8*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (9*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (9*(height-height/3 - 100)/10) + moveVertical);

    textSize(50);
    text("0", width/6 - 60 + moveHorizontal, height-height/3 + 18 + moveVertical);
    text("50", width/6 - 70 + moveHorizontal, (height-height/3) - (5*(height-height/3 - 100)/10) + 18 + moveVertical);
    text("100", width/6 - 70 + moveHorizontal, (height-height/3) - (10*(height-height/3 - 100)/10) + 18 + moveVertical);

    fill(255);
    textSize(60);
    text("SEASON STATISTICS", width/2 + moveHorizontal, height/26 + moveVertical);

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

    //bar graph bottom titles
    fill(255);
    textSize(50);
    text("3 Pointers %", lineBase_w + lineWidth/11 + width/14 + moveHorizontal, lineBase_h+70 + moveVertical);
    text("Field Goals %", lineBase_w + 2*(lineWidth/11) + 3*(width/14) + moveHorizontal, lineBase_h+70 + moveVertical);
    text("Free Throws %", lineBase_w + 3*(lineWidth/11) + 5*(width/14) + moveHorizontal, lineBase_h+70 + moveVertical);

    //results presented on top of the bars (as numbers)
    textSize(40);
    text(String.format("%.1f", team1_3PointerPerc*100), lineBase_w + lineWidth/11 + width/28 + moveHorizontal, lineBase_h-(team1_3PointerPerc)*lineHeight + moveVertical - 10);
    text(String.format("%.1f", team2_3PointerPerc*100), lineBase_w + lineWidth/11 + width/14 + width/28 + moveHorizontal, lineBase_h-(team2_3PointerPerc)*lineHeight + moveVertical - 10);

    text(String.format("%.1f", team1_fieldGoalPerc*100), lineBase_w + 2*(lineWidth/11) + 3*(width/14) - width/28 + moveHorizontal, lineBase_h-(team1_fieldGoalPerc)*lineHeight + moveVertical - 10);
    text(String.format("%.1f", team2_fieldGoalPerc*100), lineBase_w + 2*(lineWidth/11) + 3*(width/14) + width/28 + moveHorizontal, lineBase_h-(team2_fieldGoalPerc)*lineHeight + moveVertical - 10);

    text(String.format("%.1f", team1_freeThrowPerc*100), lineBase_w + 3*(lineWidth/11) + 5*(width/14) - width/28 + moveHorizontal, lineBase_h-(team1_freeThrowPerc)*lineHeight + moveVertical  - 10);
    text(String.format("%.1f", team2_freeThrowPerc*100), lineBase_w + 3*(lineWidth/11) + 5*(width/14) + width/28 + moveHorizontal, lineBase_h-(team2_freeThrowPerc)*lineHeight + moveVertical - 10);

    //team1 bars
    fill(255, 51, 51);
    rect(lineBase_w + (lineWidth/11) + moveHorizontal, lineBase_h + moveVertical, width/14, -(team1_3PointerPerc)*lineHeight);
    rect(lineBase_w + 2*(lineWidth/11) + 2*(width/14) + moveHorizontal, lineBase_h + moveVertical, width/14, -(team1_fieldGoalPerc)*lineHeight);
    rect(lineBase_w + 3*(lineWidth/11) + 4*(width/14) + moveHorizontal, lineBase_h + moveVertical, width/14, -(team1_freeThrowPerc)*lineHeight);

    //team2 bars
    fill(255, 153, 51);
    rect(lineBase_w + (lineWidth/11 + width/14) + moveHorizontal, lineBase_h + moveVertical, width/14, -(team2_3PointerPerc)*lineHeight);
    rect(lineBase_w + 2*(lineWidth/11) + 3*(width/14) + moveHorizontal, lineBase_h + moveVertical, width/14, -(team2_fieldGoalPerc)*lineHeight);
    rect(lineBase_w + 3*(lineWidth/11) + 5*(width/14) + moveHorizontal, lineBase_h + moveVertical, width/14, -(team2_freeThrowPerc)*lineHeight);
  } 
  //MODE 2: Bar Graphs: Rebounds, Assists, Turnovers - Team Comparison
  else if (mode == 2) {
    background(0, 0, 80);

    float lineBase_h = height - height/3;  //y-coord of the left corner of the graph
    float lineBase_w = width/6;  //x-coord of the left corder of the graph
    float lineTop_h = height - 100;  //y-coord of the top of the y-axis
    float lineWidth = 2*(width/3);  //width of x-axis
    float lineHeight = 2*(height/3)-100 - 100;  //height of y-axis

    moveGraph(65, 55);

    //creating x- and y-axis for the bar graphs
    stroke(255);
    fill(255);
    strokeWeight(10);

    line(width/6 + moveHorizontal, height-height/3 + moveVertical, width-(width/6) + moveHorizontal, height-height/3 + moveVertical);
    line(width/6 + moveHorizontal, height-height/3 + moveVertical, width/6 + moveHorizontal, 100 + moveVertical);

    //creating short lines to divide the y-axis to 10 parts
    strokeWeight(5);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - ((height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - ((height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (2*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (2*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (3*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (3*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (4*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (4*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (5*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (5*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (6*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (6*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (7*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (7*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (8*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (8*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (9*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (9*(height-height/3 - 100)/10) + moveVertical);

    textSize(50);
    text("0", width/6 - 60 + moveHorizontal, height-height/3 + 18 + moveVertical);
    text("50", width/6 - 70 + moveHorizontal, (height-height/3) - (5*(height-height/3 - 100)/10) + 18 + moveVertical);
    text("100", width/6 - 70 + moveHorizontal, (height-height/3) - (10*(height-height/3 - 100)/10) + 18 + moveVertical);

    fill(255);
    textSize(60);
    text("PER GAME STATISTICS", width/2 + moveHorizontal, height/26 + moveVertical);

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
    text("Rebounds", lineBase_w + lineWidth/11 + width/14 + moveHorizontal, lineBase_h+70 + moveVertical);
    text("Assists", lineBase_w + 2*(lineWidth/11) + 3*(width/14) + moveHorizontal, lineBase_h+70 + moveVertical);
    text("Turnovers", lineBase_w + 3*(lineWidth/11) + 5*(width/14) + moveHorizontal, lineBase_h+70 + moveVertical);

    //results presented on top of the bars (as numbers)
    textSize(40);
    text(String.format("%.1f", team1_Rebounds*100), lineBase_w + lineWidth/11 + width/28 + moveHorizontal, lineBase_h-(team1_Rebounds)*lineHeight + moveVertical - 10);
    text(String.format("%.1f", team2_Rebounds*100), lineBase_w + lineWidth/11 + width/14 + width/28 + moveHorizontal, lineBase_h-(team2_Rebounds)*lineHeight + moveVertical - 10);

    text(String.format("%.1f", team1_Assists*100), lineBase_w + 2*(lineWidth/11) + 3*(width/14) - width/28 + moveHorizontal, lineBase_h-(team1_Assists)*lineHeight + moveVertical - 10);
    text(String.format("%.1f", team2_Assists*100), lineBase_w + 2*(lineWidth/11) + 3*(width/14) + width/28 + moveHorizontal, lineBase_h-(team2_Assists)*lineHeight + moveVertical - 10);

    text(String.format("%.1f", team1_Turnovers*100), lineBase_w + 3*(lineWidth/11) + 5*(width/14) - width/28 + moveHorizontal, lineBase_h-(team1_Turnovers)*lineHeight + moveVertical  - 10);
    text(String.format("%.1f", team2_Turnovers*100), lineBase_w + 3*(lineWidth/11) + 5*(width/14) + width/28 + moveHorizontal, lineBase_h-(team2_Turnovers)*lineHeight + moveVertical - 10);

    //team1 bars
    fill(255, 51, 51);
    rect(lineBase_w + (lineWidth/11) + moveHorizontal, lineBase_h + moveVertical, width/14, -(team1_Rebounds)*lineHeight);
    rect(lineBase_w + 2*(lineWidth/11) + 2*(width/14) + moveHorizontal, lineBase_h + moveVertical, width/14, -(team1_Assists)*lineHeight);
    rect(lineBase_w + 3*(lineWidth/11) + 4*(width/14) + moveHorizontal, lineBase_h + moveVertical, width/14, -(team1_Turnovers)*lineHeight);

    //team2 bars
    fill(255, 153, 51);
    rect(lineBase_w + (lineWidth/11 + width/14) + moveHorizontal, lineBase_h + moveVertical, width/14, -(team2_Rebounds)*lineHeight);
    rect(lineBase_w + 2*(lineWidth/11) + 3*(width/14) + moveHorizontal, lineBase_h + moveVertical, width/14, -(team2_Assists)*lineHeight);
    rect(lineBase_w + 3*(lineWidth/11) + 5*(width/14) + moveHorizontal, lineBase_h + moveVertical, width/14, -(team2_Turnovers)*lineHeight);
  }

  //Mode 3 displays where points come from
  else if (mode == 3) {
    background(0, 0, 80);

    float lineBase_h = height-height/3;
    float lineBase_w = width/6;
    float lineTop_h = height - 100;
    float lineWidth = 2*(width/3);
    float lineHeight = 2*(height/3)-100;

    moveGraph(65, 55);

    //creating x- and y-axis for the bar graphs
    stroke(255);
    fill(255);
    strokeWeight(10);
    line(width/6 + moveHorizontal, height-height/3 + moveVertical, width-(width/6) + moveHorizontal, height-height/3 + moveVertical);
    line(width/6 + moveHorizontal, height-height/3 + moveVertical, width/6 + moveHorizontal, 100 + moveVertical);

    //creating short lines to divide the y-axis to 10 parts
    strokeWeight(5);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - ((height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - ((height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (2*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (2*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (3*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (3*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (4*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (4*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (5*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (5*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (6*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (6*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (7*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (7*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (8*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (8*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (9*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (9*(height-height/3 - 100)/10) + moveVertical);

    textSize(50);
    text("0", width/6 - 60 + moveHorizontal, height-height/3 + 18 + moveVertical);
    text("50", width/6 - 70 + moveHorizontal, (height-height/3) - (5*(height-height/3 - 100)/10) + 18 + moveVertical);
    text("100", width/6 - 70 + moveHorizontal, (height-height/3) - (10*(height-height/3 - 100)/10) + 18 + moveVertical);

    fill(255);
    textSize(60);
    text("PER GAME STATISTICS", width/2 + moveHorizontal, height/26 + moveVertical);

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
    text("Points", lineBase_w + lineWidth/11 + width/14 + moveHorizontal, lineBase_h+70 + moveVertical);
    text("Fast Break Pts", lineBase_w + 2*(lineWidth/11) + 3*(width/14) + moveHorizontal, lineBase_h+70 + moveVertical);
    text("2nd Chance Pts", lineBase_w + 3*(lineWidth/11) + 5*(width/14) + moveHorizontal, lineBase_h+70 + moveVertical);

    //results presented on top of the bars (as numbers)
    textSize(40);
    text(String.format("%.1f", team1_Points*100), lineBase_w + lineWidth/11 + width/28 + moveHorizontal, lineBase_h-(team1_Points)*lineHeight + moveVertical - 10);
    text(String.format("%.1f", team2_Points*100), lineBase_w + lineWidth/11 + width/14 + width/28 + moveHorizontal, lineBase_h-(team2_Points)*lineHeight + moveVertical - 10);

    text(String.format("%.1f", team1_fastBreakPts*100), lineBase_w + 2*(lineWidth/11) + 3*(width/14) - width/28 + moveHorizontal, lineBase_h-(team1_fastBreakPts)*lineHeight + moveVertical - 10);
    text(String.format("%.1f", team2_fastBreakPts*100), lineBase_w + 2*(lineWidth/11) + 3*(width/14) + width/28 + moveHorizontal, lineBase_h-(team2_fastBreakPts)*lineHeight + moveVertical - 10);

    text(String.format("%.1f", team1_secondChancePts*100), lineBase_w + 3*(lineWidth/11) + 5*(width/14) - width/28 + moveHorizontal, lineBase_h-(team1_secondChancePts)*lineHeight + moveVertical  - 10);
    text(String.format("%.1f", team2_secondChancePts*100), lineBase_w + 3*(lineWidth/11) + 5*(width/14) + width/28 + moveHorizontal, lineBase_h-(team2_secondChancePts)*lineHeight + moveVertical - 10);

    //team1 bars
    fill(255, 51, 51);
    rect(lineBase_w + (lineWidth/11) + moveHorizontal, lineBase_h + moveVertical, width/14, -(team1_Points)*lineHeight);
    rect(lineBase_w + 2*(lineWidth/11) + 2*(width/14) + moveHorizontal, lineBase_h + moveVertical, width/14, -(team1_fastBreakPts)*lineHeight);
    rect(lineBase_w + 3*(lineWidth/11) + 4*(width/14) + moveHorizontal, lineBase_h + moveVertical, width/14, -(team1_secondChancePts)*lineHeight);

    //team2 bars
    fill(255, 153, 51);
    rect(lineBase_w + (lineWidth/11 + width/14) + moveHorizontal, lineBase_h + moveVertical, width/14, -(team2_Points)*lineHeight);
    rect(lineBase_w + 2*(lineWidth/11) + 3*(width/14) + moveHorizontal, lineBase_h + moveVertical, width/14, -(team2_fastBreakPts)*lineHeight);
    rect(lineBase_w + 3*(lineWidth/11) + 5*(width/14) + moveHorizontal, lineBase_h + moveVertical, width/14, -(team2_secondChancePts)*lineHeight);
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
    float lineHeight = 2*(height/3)-100;

    moveGraph(65, 55);

    //creating x- and y-axis for the bar graphs
    stroke(255);
    fill(255);
    strokeWeight(10);
    line(width/6 + moveHorizontal, height-height/3 + moveVertical, width-(width/6) + moveHorizontal, height-height/3 + moveVertical);
    line(width/6 + moveHorizontal, height-height/3 + moveVertical, width/6 + moveHorizontal, 100 + moveVertical);

    //creating short lines to divide the y-axis to 10 parts
    strokeWeight(5);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - ((height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - ((height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (2*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (2*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (3*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (3*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (4*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (4*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (5*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (5*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (6*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (6*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (7*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (7*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (8*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (8*(height-height/3 - 100)/10) + moveVertical);
    line(width/6 - 20 + moveHorizontal, (height-height/3) - (9*(height-height/3 - 100)/10) + moveVertical, width/6 + 20 + moveHorizontal, (height-height/3) - (9*(height-height/3 - 100)/10) + moveVertical);

    textSize(50);
    text("0", width/6 - 60 + moveHorizontal, height-height/3 + 18 + moveVertical);
    text("50", width/6 - 70 + moveHorizontal, (height-height/3) - (5*(height-height/3 - 100)/10) + 18 + moveVertical);
    text("100", width/6 - 70 + moveHorizontal, (height-height/3) - (10*(height-height/3 - 100)/10) + 18 + moveVertical);

    fill(255);
    textSize(60);
    text("PLAYER STATISTICS", width/2 + moveHorizontal, height/26 + moveVertical);

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

    //bar graph bottom titles
    fill(255);
    textSize(50);
    text("3 Pointers %", lineBase_w + lineWidth/11 + width/14 + moveHorizontal, lineBase_h+70 + moveVertical);
    text("Field Goals %", lineBase_w + 2*(lineWidth/11) + 3*(width/14) + moveHorizontal, lineBase_h+70 + moveVertical);
    text("Free Throws %", lineBase_w + 3*(lineWidth/11) + 5*(width/14) + moveHorizontal, lineBase_h+70 + moveVertical);

    //results presented on top of the bars (as numbers)
    textSize(40);
    text(String.format("%.1f", player1_3PointerPerc*100), lineBase_w + lineWidth/11 + width/28 + moveHorizontal, lineBase_h-(player1_3PointerPerc)*lineHeight + moveVertical - 10);
    text(String.format("%.1f", player2_3PointerPerc*100), lineBase_w + lineWidth/11 + width/14 + width/28 + moveHorizontal, lineBase_h-(player2_3PointerPerc)*lineHeight + moveVertical - 10);

    text(String.format("%.1f", player1_fieldGoalPerc*100), lineBase_w + 2*(lineWidth/11) + 3*(width/14) - width/28 + moveHorizontal, lineBase_h-(player1_fieldGoalPerc)*lineHeight + moveVertical - 10);
    text(String.format("%.1f", player2_fieldGoalPerc*100), lineBase_w + 2*(lineWidth/11) + 3*(width/14) + width/28 + moveHorizontal, lineBase_h-(player2_fieldGoalPerc)*lineHeight + moveVertical - 10);

    text(String.format("%.1f", player1_freeThrowPerc*100), lineBase_w + 3*(lineWidth/11) + 5*(width/14) - width/28 + moveHorizontal, lineBase_h-(player1_freeThrowPerc)*lineHeight + moveVertical  - 10);
    text(String.format("%.1f", player2_freeThrowPerc*100), lineBase_w + 3*(lineWidth/11) + 5*(width/14) + width/28 + moveHorizontal, lineBase_h-(player2_freeThrowPerc)*lineHeight + moveVertical - 10);

    //team1 bars
    fill(255, 51, 51);
    rect(lineBase_w + (lineWidth/11) + moveHorizontal, lineBase_h + moveVertical, width/14, -(player1_3PointerPerc)*lineHeight);
    rect(lineBase_w + 2*(lineWidth/11) + 2*(width/14) + moveHorizontal, lineBase_h + moveVertical, width/14, -(player1_fieldGoalPerc)*lineHeight);
    rect(lineBase_w + 3*(lineWidth/11) + 4*(width/14) + moveHorizontal, lineBase_h + moveVertical, width/14, -(player1_freeThrowPerc)*lineHeight);

    //team2 bars
    fill(255, 153, 51);
    rect(lineBase_w + (lineWidth/11 + width/14) + moveHorizontal, lineBase_h + moveVertical, width/14, -(player2_3PointerPerc)*lineHeight);
    rect(lineBase_w + 2*(lineWidth/11) + 3*(width/14) + moveHorizontal, lineBase_h + moveVertical, width/14, -(player2_fieldGoalPerc)*lineHeight);
    rect(lineBase_w + 3*(lineWidth/11) + 5*(width/14) + moveHorizontal, lineBase_h + moveVertical, width/14, -(player2_freeThrowPerc)*lineHeight);
  }
  //MODE 6: Relational Graph: 2p vs 3p
  else if (mode == 6) {

    background(0, 0, 80);

    float lineBase_h = height - height/3;  //y-coord of the left corner of the graph
    float lineBase_w = width/6;  //x-coord of the left corder of the graph
    float lineTop_h = height - 100;  //y-coord of the top of the y-axis
    float lineWidth = 2*(width/3);  //width of x-axis
    float lineHeight = 2*(height/3)-100;  //height of y-axis

    moveGraph(65, 55);

    //creating x- and y-axis for the bar graphs
    stroke(255);
    fill(255);
    strokeWeight(10);

    line(lineBase_w + moveHorizontal, lineBase_h + moveVertical, width-(lineBase_w) + moveHorizontal, lineBase_h + moveVertical);
    line(lineBase_w + moveHorizontal, lineBase_h + moveVertical, lineBase_w + moveHorizontal, 100 + moveVertical);

    textSize(50);
    text("0", width/6 - 60 + moveHorizontal, height-height/3 + 18 + moveVertical);
    text("50", width/6 - 70 + moveHorizontal, (height-height/3) - (5*(height-height/3 - 100)/10) + 18 + moveVertical);
    text("100", width/6 - 70 + moveHorizontal, (height-height/3) - (10*(height-height/3 - 100)/10) + 18 + moveVertical);

    //creating short lines to divide the y-axis to 10 parts
    strokeWeight(5);
    line(lineBase_w - 20 + moveHorizontal, lineBase_h - ((lineHeight)/10) + moveVertical, lineBase_w + 20 + moveHorizontal, lineBase_h - ((lineHeight)/10) + moveVertical);
    line(lineBase_w - 20 + moveHorizontal, lineBase_h - (2*(lineHeight)/10) + moveVertical, lineBase_w + 20 + moveHorizontal, lineBase_h - (2*(lineHeight)/10) + moveVertical);
    line(lineBase_w - 20 + moveHorizontal, lineBase_h - (3*(lineHeight)/10) + moveVertical, lineBase_w + 20 + moveHorizontal, lineBase_h - (3*(lineHeight)/10) + moveVertical);
    line(lineBase_w - 20 + moveHorizontal, lineBase_h - (4*(lineHeight)/10) + moveVertical, lineBase_w + 20 + moveHorizontal, lineBase_h - (4*(lineHeight)/10) + moveVertical);
    line(lineBase_w - 20 + moveHorizontal, lineBase_h - (5*(lineHeight)/10) + moveVertical, lineBase_w + 20 + moveHorizontal, lineBase_h - (5*(lineHeight)/10) + moveVertical);
    line(lineBase_w - 20 + moveHorizontal, lineBase_h - (6*(lineHeight)/10) + moveVertical, lineBase_w + 20 + moveHorizontal, lineBase_h - (6*(lineHeight)/10) + moveVertical);
    line(lineBase_w - 20 + moveHorizontal, lineBase_h - (7*(lineHeight)/10) + moveVertical, lineBase_w + 20 + moveHorizontal, lineBase_h - (7*(lineHeight)/10) + moveVertical);
    line(lineBase_w - 20 + moveHorizontal, lineBase_h - (8*(lineHeight)/10) + moveVertical, lineBase_w + 20 + moveHorizontal, lineBase_h - (8*(lineHeight)/10) + moveVertical);
    line(lineBase_w - 20 + moveHorizontal, lineBase_h - (9*(lineHeight)/10) + moveVertical, lineBase_w + 20 + moveHorizontal, lineBase_h - (9*(lineHeight)/10) + moveVertical);

    //creating short lines to divide the x-axis to 10 parts
    line(lineBase_w + ((lineWidth)/10) + moveHorizontal, lineBase_h - 20 + moveVertical, lineBase_w + ((lineWidth)/10) + moveHorizontal, lineBase_h + 20 + moveVertical);
    line(lineBase_w + (2*(lineWidth)/10) + moveHorizontal, lineBase_h - 20 + moveVertical, lineBase_w + (2*(lineWidth)/10) + moveHorizontal, lineBase_h + 20 + moveVertical);
    line(lineBase_w + (3*(lineWidth)/10) + moveHorizontal, lineBase_h - 20 + moveVertical, lineBase_w + (3*(lineWidth)/10) + moveHorizontal, lineBase_h + 20 + moveVertical);
    line(lineBase_w + (4*(lineWidth)/10) + moveHorizontal, lineBase_h - 20 + moveVertical, lineBase_w + (4*(lineWidth)/10) + moveHorizontal, lineBase_h + 20 + moveVertical);
    line(lineBase_w + (5*(lineWidth)/10) + moveHorizontal, lineBase_h - 20 + moveVertical, lineBase_w + (5*(lineWidth)/10) + moveHorizontal, lineBase_h + 20 + moveVertical);
    line(lineBase_w + (6*(lineWidth)/10) + moveHorizontal, lineBase_h - 20 + moveVertical, lineBase_w + (6*(lineWidth)/10) + moveHorizontal, lineBase_h + 20 + moveVertical);
    line(lineBase_w + (7*(lineWidth)/10) + moveHorizontal, lineBase_h - 20 + moveVertical, lineBase_w + (7*(lineWidth)/10) + moveHorizontal, lineBase_h + 20 + moveVertical);
    line(lineBase_w + (8*(lineWidth)/10) + moveHorizontal, lineBase_h - 20 + moveVertical, lineBase_w + (8*(lineWidth)/10) + moveHorizontal, lineBase_h + 20 + moveVertical);
    line(lineBase_w + (9*(lineWidth)/10) + moveHorizontal, lineBase_h - 20 + moveVertical, lineBase_w + (9*(lineWidth)/10) + moveHorizontal, lineBase_h + 20 + moveVertical);

    //vertical digits
    textSize(50);
    text("0", lineBase_w - 60 + moveHorizontal, lineBase_h + 18 + moveVertical);
    text("50", lineBase_w - 70 + moveHorizontal, lineBase_h - (5*(lineHeight)/10) + 18 + moveVertical);
    text("100", lineBase_w - 70 + moveHorizontal, lineBase_h - (10*(lineHeight)/10) + 18 + moveVertical);
    text("y", lineBase_w + moveHorizontal, lineBase_h - (10*(lineHeight)/10) - 40 + moveVertical);

    //horizontal digits
    textSize(50);
    text("0", lineBase_w + moveHorizontal, lineBase_h + 70 + moveVertical);
    text("50", lineBase_w + (5*(lineWidth)/10) + moveHorizontal, lineBase_h + 70 + moveVertical);
    text("100", lineBase_w + (lineWidth) + moveHorizontal, lineBase_h + 70 + moveVertical);
    text("x", lineBase_w + (lineWidth) + moveHorizontal + 40, lineBase_h + moveVertical + 15);

    //  fill(255);
    textSize(55);
    text("2 Pointers (x) vs. 3 Pointers (y)", width/2 + moveHorizontal, height/26 + moveVertical);

    textSize(40);
    text(team1_obj.getTeamName(), width/14, height/6);
    text(team2_obj.getTeamName(), width/14, height/6 + height/7);
    text(team3, width/14, height/6 + 2*(height/7));
    text(team4, width/14, height/6 + 3*(height/7));
    text(team5, width/14, height/6 + 4*(height/7));
    text(team6, width/14, height/6 + 5*(height/7));

    //draw small boxes to represent all the additional teams
    //on the relational graph one the left
    fill(255, 51, 51);   
    rect(width/18, height/6 + height/40, width/32, height/20);    
    fill(255, 153, 51);
    rect(width/18, height/6 + height/7 + height/40, width/32, height/20);
    fill(0, 255, 128);   
    rect(width/18, height/6 + 2*(height/7) + height/40, width/32, height/20);  
    fill(0, 128, 255);
    rect(width/18, height/6 + 3*(height/7) + height/40, width/32, height/20);
    fill(127, 0, 255);       
    rect(width/18, height/6 + 4*(height/7) + height/40, width/32, height/20);    
    fill(204, 0, 102);
    rect(width/18, height/6 + 5*(height/7) + height/40, width/32, height/20);

    float team1_2PointerPerc = team1_obj.getTwoPointsPct();
    float team1_3PointerPerc = team1_obj.getThreePointsPct(); 
    fill(255, 51, 51);
    rect(lineBase_w + (team1_2PointerPerc)*lineWidth - 10, lineBase_h - (team1_3PointerPerc)*lineHeight - 10, 20, 20);

    float team2_2PointerPerc = team2_obj.getTwoPointsPct();
    float team2_3PointerPerc = team2_obj.getThreePointsPct();
    fill(255, 153, 51);
    rect(lineBase_w + (team2_2PointerPerc)*lineWidth - 10, lineBase_h - (team2_3PointerPerc)*lineHeight - 10, 20, 20);

    if (relGraph_showTeam3) {     
      float team3_2PointerPerc = team3_obj.getTwoPointsPct();
      float team3_3PointerPerc = team3_obj.getThreePointsPct();     
      fill(0, 255, 128); 
      rect(lineBase_w + (team3_2PointerPerc)*lineWidth - 10, lineBase_h - (team3_3PointerPerc)*lineHeight - 10, 20, 20);
    } 
    if (relGraph_showTeam4) {     
      float team4_2PointerPerc = team4_obj.getTwoPointsPct();
      float team4_3PointerPerc = team4_obj.getThreePointsPct();     
      fill(0, 128, 255); 
      rect(lineBase_w + (team4_2PointerPerc)*lineWidth - 10, lineBase_h - (team4_3PointerPerc)*lineHeight - 10, 20, 20);
    }
    if (relGraph_showTeam5) {     
      float team5_2PointerPerc = team5_obj.getTwoPointsPct();
      float team5_3PointerPerc = team5_obj.getThreePointsPct();     
      fill(127, 0, 255);   
      rect(lineBase_w + (team5_2PointerPerc)*lineWidth - 10, lineBase_h - (team5_3PointerPerc)*lineHeight - 10, 20, 20);
    }
    if (relGraph_showTeam6) {     
      float team6_2PointerPerc = team6_obj.getTwoPointsPct();
      float team6_3PointerPerc = team6_obj.getThreePointsPct();     
      fill(204, 0, 102); 
      rect(lineBase_w + (team6_2PointerPerc)*lineWidth - 10, lineBase_h - (team6_3PointerPerc)*lineHeight - 10, 20, 20);
    }
  } 
  //MODE 7: Data Display Selectio mode for Team Comparison
  else if (mode == 7) {

    background(0, 0, 80);  
    fill(255); 
    textSize(70);
    text(team1 + " vs. " + team2, width/2, height/10);
    text(season, width/2, height/10 + 100);
  }
  //MODE 8: Time Graphs for Team Comparison
  else if ((mode == 8) || (mode == 9) || (mode == 10)) {

    background(0, 0, 80);

    float lineBase_h = height - height/3;  //y-coord of the left corner of the graph
    float lineBase_w = width/6;  //x-coord of the left corder of the graph
    float lineTop_h = height - 100;  //y-coord of the top of the y-axis
    float lineWidth = 2*(width/3);  //width of x-axis
    float lineHeight = 2*(height/3)-100;  //height of y-axis

    moveGraph(65, 55);

    //creating x- and y-axis for the bar graphs
    stroke(255);
    fill(255);
    strokeWeight(10);

    line(lineBase_w + moveHorizontal, lineBase_h + moveVertical, width-(lineBase_w) + moveHorizontal, lineBase_h + moveVertical);
    line(lineBase_w + moveHorizontal, lineBase_h + moveVertical, lineBase_w + moveHorizontal, 100 + moveVertical);

    textSize(50);
    text("0", width/6 - 60 + moveHorizontal, height-height/3 + 18 + moveVertical);
    text("50", width/6 - 70 + moveHorizontal, (height-height/3) - (5*(height-height/3 - 100)/10) + 18 + moveVertical);
    text("100", width/6 - 70 + moveHorizontal, (height-height/3) - (10*(height-height/3 - 100)/10) + 18 + moveVertical);

    //creating short lines to divide the y-axis to 10 parts
    strokeWeight(5);
    line(lineBase_w - 20 + moveHorizontal, lineBase_h - ((lineHeight)/10) + moveVertical, lineBase_w + 20 + moveHorizontal, lineBase_h - ((lineHeight)/10) + moveVertical);
    line(lineBase_w - 20 + moveHorizontal, lineBase_h - (2*(lineHeight)/10) + moveVertical, lineBase_w + 20 + moveHorizontal, lineBase_h - (2*(lineHeight)/10) + moveVertical);
    line(lineBase_w - 20 + moveHorizontal, lineBase_h - (3*(lineHeight)/10) + moveVertical, lineBase_w + 20 + moveHorizontal, lineBase_h - (3*(lineHeight)/10) + moveVertical);
    line(lineBase_w - 20 + moveHorizontal, lineBase_h - (4*(lineHeight)/10) + moveVertical, lineBase_w + 20 + moveHorizontal, lineBase_h - (4*(lineHeight)/10) + moveVertical);
    line(lineBase_w - 20 + moveHorizontal, lineBase_h - (5*(lineHeight)/10) + moveVertical, lineBase_w + 20 + moveHorizontal, lineBase_h - (5*(lineHeight)/10) + moveVertical);
    line(lineBase_w - 20 + moveHorizontal, lineBase_h - (6*(lineHeight)/10) + moveVertical, lineBase_w + 20 + moveHorizontal, lineBase_h - (6*(lineHeight)/10) + moveVertical);
    line(lineBase_w - 20 + moveHorizontal, lineBase_h - (7*(lineHeight)/10) + moveVertical, lineBase_w + 20 + moveHorizontal, lineBase_h - (7*(lineHeight)/10) + moveVertical);
    line(lineBase_w - 20 + moveHorizontal, lineBase_h - (8*(lineHeight)/10) + moveVertical, lineBase_w + 20 + moveHorizontal, lineBase_h - (8*(lineHeight)/10) + moveVertical);
    line(lineBase_w - 20 + moveHorizontal, lineBase_h - (9*(lineHeight)/10) + moveVertical, lineBase_w + 20 + moveHorizontal, lineBase_h - (9*(lineHeight)/10) + moveVertical);

    //creating short lines to divide the x-axis for two seasons
    line(lineBase_w + (2*(lineWidth)/10) + moveHorizontal, lineBase_h - 20 + moveVertical, lineBase_w + (2*(lineWidth)/10) + moveHorizontal, lineBase_h + 20 + moveVertical);
    line(lineBase_w + (8*(lineWidth)/10) + moveHorizontal, lineBase_h - 20 + moveVertical, lineBase_w + (8*(lineWidth)/10) + moveHorizontal, lineBase_h + 20 + moveVertical);

    textSize(50);
    text("2013", lineBase_w + (2*(lineWidth)/10) + moveHorizontal, lineBase_h + 70 + moveVertical);
    text("2014", lineBase_w + (8*(lineWidth)/10) + moveHorizontal, lineBase_h + 70 + moveVertical);
    text("time", lineBase_w + (lineWidth) + moveHorizontal + 40, lineBase_h + 70 + moveVertical);

    //vertical digits
    text("0", lineBase_w - 60 + moveHorizontal, lineBase_h + 18 + moveVertical);
    text("50", lineBase_w - 70 + moveHorizontal, lineBase_h - (5*(lineHeight)/10) + 18 + moveVertical);
    text("100", lineBase_w - 70 + moveHorizontal, lineBase_h - (10*(lineHeight)/10) + 18 + moveVertical);

    //small color boxes to identify teams on the graph
    textSize(40);
    text(team1_obj.getTeamName(), width/14, height/4);
    text(team2_obj.getTeamName(), width/14, height/2);
    fill(255, 51, 51);   
    rect(width/20, height/4 + height/20, width/22, height/16); 
    fill(255, 153, 51);
    rect(width/20, height/2 + height/20, width/22, height/16); 

    //2 Pointer %
    if (mode == 8) { 

      fill(255);
      textSize(55);
      text("2 Pointers % vs. time Graph", width/2 + moveHorizontal, height/26 + moveVertical);

      float team1_2013_2PointerPerc = team1_obj2013.getTwoPointsPct();
      float team1_2014_2PointerPerc = team1_obj2014.getTwoPointsPct();     
      float team2_2013_2PointerPerc = team2_obj2013.getTwoPointsPct();
      float team2_2014_2PointerPerc = team2_obj2014.getTwoPointsPct();

      strokeWeight(7);
      stroke(255, 51, 51); 
      line(lineBase_w + (2*(lineWidth)/10) + moveHorizontal, lineBase_h - (team1_2013_2PointerPerc)*lineHeight - 10, 
      lineBase_w + (8*(lineWidth)/10) + moveHorizontal, lineBase_h - (team1_2014_2PointerPerc)*lineHeight - 10);

      stroke(255, 153, 51);      
      line(lineBase_w + (2*(lineWidth)/10) + moveHorizontal, lineBase_h - (team2_2013_2PointerPerc)*lineHeight - 10, 
      lineBase_w + (8*(lineWidth)/10) + moveHorizontal, lineBase_h - (team2_2014_2PointerPerc)*lineHeight - 10);
      stroke(255);
    } 
    //3 Pointer %
    else if (mode == 9) {

      fill(255);
      textSize(55);
      text("3 Pointers % vs. time Graph", width/2 + moveHorizontal, height/26 + moveVertical);

      float team1_2013_3PointerPerc = team1_obj2013.getThreePointsPct();
      float team1_2014_3PointerPerc = team1_obj2014.getThreePointsPct();     
      float team2_2013_3PointerPerc = team2_obj2013.getThreePointsPct();
      float team2_2014_3PointerPerc = team2_obj2014.getThreePointsPct();

      strokeWeight(7);
      stroke(255, 51, 51); 
      line(lineBase_w + (2*(lineWidth)/10) + moveHorizontal, lineBase_h - (team1_2013_3PointerPerc)*lineHeight - 10, 
      lineBase_w + (8*(lineWidth)/10) + moveHorizontal, lineBase_h - (team1_2014_3PointerPerc)*lineHeight - 10);

      stroke(255, 153, 51);      
      line(lineBase_w + (2*(lineWidth)/10) + moveHorizontal, lineBase_h - (team2_2013_3PointerPerc)*lineHeight - 10, 
      lineBase_w + (8*(lineWidth)/10) + moveHorizontal, lineBase_h - (team2_2014_3PointerPerc)*lineHeight - 10);
      stroke(255);
    } 
    //Free Throws %
    else if (mode == 10) {

      fill(255);
      textSize(55);
      text("Free Throws % vs. time Graph", width/2 + moveHorizontal, height/26 + moveVertical);

      float team1_2013_FreeThrowPerc = team1_obj2013.getFreeThrowsPct();
      float team1_2014_FreeThrowPerc = team1_obj2014.getFreeThrowsPct();     
      float team2_2013_FreeThrowPerc = team2_obj2013.getFreeThrowsPct();
      float team2_2014_FreeThrowPerc = team2_obj2014.getFreeThrowsPct();

      strokeWeight(7);
      stroke(255, 51, 51); 
      line(lineBase_w + (2*(lineWidth)/10) + moveHorizontal, lineBase_h - (team1_2013_FreeThrowPerc)*lineHeight - 10, 
      lineBase_w + (8*(lineWidth)/10) + moveHorizontal, lineBase_h - (team1_2014_FreeThrowPerc)*lineHeight - 10);

      stroke(255, 153, 51);      
      line(lineBase_w + (2*(lineWidth)/10) + moveHorizontal, lineBase_h - (team2_2013_FreeThrowPerc)*lineHeight - 10, 
      lineBase_w + (8*(lineWidth)/10) + moveHorizontal, lineBase_h - (team2_2014_FreeThrowPerc)*lineHeight - 10);
      stroke(255);
    }
  }

  // when game is selected in mode 98 live game
  else if (mode == 97) {
    preMode();
    if (!selectedGame.getStatus().equals("scheduled")) {
      textAlign(CENTER); 
      text(selectedGameSummary.getAwayTeamName() + " @ " + selectedGameSummary.getHomeTeamName(), width/2, 200);
      textAlign(LEFT);
      // display teams score
      text(selectedGameSummary.getHomeTeamName(), width/4, 300);
      text(selectedGameSummary.getAwayTeamName(), width/4, 400);
      text(selectedGameSummary.getHomePoints(), width*2/3, 300);
      text(selectedGameSummary.getAwayPoints(), width*2/3, 400);
      stroke(255);
      line(0, 500, width, 500);
      text(selectedGameSummary.getHomeTeamName(), 200, 600);
      text(selectedGameSummary.getAwayTeamName(), width*5/6, 600);
      textAlign(LEFT);
      text(selectedGameSummary.getHomeFieldGoalsPct(), width/5, 700);
      text(selectedGameSummary.getHomeThreePointsPct(), width/5, 800);
      text(selectedGameSummary.getHomeFreeThrowsPct(), width/5, 900);
      text(selectedGameSummary.getAwayFieldGoalsPct(), width*3/4, 700);
      text(selectedGameSummary.getAwayThreePointsPct(), width*3/4, 800);
      text(selectedGameSummary.getAwayFreeThrowsPct(), width*3/4, 900);
      textAlign(CENTER);
      text("Field Goals %", width/2, 700);
      text("Three Points %", width/2, 800);
      text("Free Throws %", width/2, 900);
    } else {
      textAlign(CENTER); 
      text(selectedGame.getAwayTeamName() + " @ " + selectedGame.getHomeTeamName(), width/2, 200);
      text(selectedGame.getTitle(), width/2, 400);
      text(selectedGame.getScheduled(), width/2, 500);
    }
  }

  // this is the live game for current day
  else if (mode == 98) {
    preMode(); 
    Calendar c = Calendar.getInstance(); 
    String year = Integer.toString(c.get(Calendar.YEAR));
    String month = Integer.toString(c.get(Calendar.MONTH) + 1);
    String day = Integer.toString(c.get(Calendar.DAY_OF_MONTH));
    int buttonWidth = width/2;
    int buttonHeight = height/8;

    textAlign(CENTER); 
    text("Scheduled game for today", width/2, 100);
    text(month + "/" + day + "/" + year, width/2, 200);

    if (!liveModeLoaded) {
      gamesToday = getAllGamesOnDate(year, month, day);
      //gamesToday = getAllGamesOnDate("2015", "01", "15");

      for (int i = 0; i < gamesToday.size (); i++) {
        APButton apb = new APButton(width/2 - buttonWidth/2, 300+(i*160), buttonWidth, buttonHeight, gamesToday.get(i).getAwayTeamName() + " @ " + gamesToday.get(i).getHomeTeamName());
        WC_LiveButtons.add(apb);
      }
      for (int i = 0; i < WC_LiveButtons.size (); i++) {
        WC_live.addWidget(WC_LiveButtons.get(i));
      }
      liveModeLoaded = true;
    }

    WC_live.show();
  }
  // this is the main screen
  else if (mode == 99) {
    preMode();
    textSize(200); 
    textAlign(CENTER); 
    text("SportSpot", width/2, height/4);

    int buttonWidth = width/3;
    int buttonHeight = height/8;

    if (!mainModeLoaded) {
      WC_mainButtons.add(new APButton(width/4 - buttonWidth/2, height/2+300, buttonWidth, buttonHeight, "Live Data"));
      WC_mainButtons.add(new APButton(width*3/4 - buttonWidth/2, height/2, buttonWidth, buttonHeight, "Player Comparison"));
      WC_mainButtons.add(new APButton(width/4 - buttonWidth/2, height/2, buttonWidth, buttonHeight, "Team Comparison"));
      WC_mainButtons.add(new APButton(width*3/4 - buttonWidth/2, height/2+300, buttonWidth, buttonHeight, "PLACEHOLDER"));

      for (int i = 0; i < WC_mainButtons.size (); i++) {
        WC_main.addWidget(WC_mainButtons.get(i));
      }

      mainModeLoaded = true;
    }

    WC_main.show();


    //APWidgetContainer WC_main;
    //ArrayList<APButton> WC_mainButtons = new ArrayList<APButton>();
    //    Map<String, String> roster = getTeamRoster("583ec825-fb46-11e1-82cb-f4ce4684ea4c");
    //    Iterator it = roster.entrySet().iterator();
    //    while (it.hasNext ()) {
    //      Map.Entry pair = (Map.Entry)it.next();
    //      System.out.println(pair.getKey() + " = " + pair.getValue());
    //      it.remove(); // avoids a ConcurrentModificationException
    //    }
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
  } else if ((mode == 6) && ((mouseX > width/22) && (mouseX < width/18 + width/30)) && 
    ((mouseY > height/6 + 2*(height/7) + height/40) && (mouseY <height/6 + 2*(height/7) + height/40 + height/16))) { 
    relGraphList_team3 = new KetaiList(this, teams);
    relGraph_Team3Pressed = true;
  } else if ((mode == 6) && ((mouseX > width/22) && (mouseX < width/18 + width/30)) && 
    ((mouseY > height/6 + 3*(height/7) + height/40) && (mouseY <height/6 + 3*(height/7) + height/40 + height/16))) { 
    relGraphList_team4 = new KetaiList(this, teams);
    relGraph_Team4Pressed = true;
  } else if ((mode == 6) && ((mouseX > width/22) && (mouseX < width/18 + width/30)) && 
    ((mouseY > height/6 + 4*(height/7) + height/40) && (mouseY <height/6 + 4*(height/7) + height/40 + height/16))) { 
    relGraphList_team5 = new KetaiList(this, teams);
    relGraph_Team5Pressed = true;
  } else if ((mode == 6) && ((mouseX > width/22) && (mouseX < width/18 + width/30)) && 
    ((mouseY > height/6 + 5*(height/7) + height/40) && (mouseY <height/6 + 5*(height/7) + height/40 + height/16))) { 
    relGraphList_team6 = new KetaiList(this, teams);
    relGraph_Team6Pressed = true;
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
    } else if (relGraph_Team3Pressed) {
      team3 = selection;
      team3_obj = getNBATeamSeasonTotalStats(Database.teamNameAndIDHash.get(team3), season);
      team3_obj.setTeamName(team3);
      relGraph_showTeam3 = true;
    } else if (relGraph_Team4Pressed) {
      team4 = selection;
      team4_obj = getNBATeamSeasonTotalStats(Database.teamNameAndIDHash.get(team4), season);
      team4_obj.setTeamName(team4);
      relGraph_showTeam4 = true;
    } else if (relGraph_Team5Pressed) {
      team5 = selection;
      team5_obj = getNBATeamSeasonTotalStats(Database.teamNameAndIDHash.get(team5), season);
      team5_obj.setTeamName(team5);
      relGraph_showTeam5 = true;
    } else if (relGraph_Team6Pressed) {
      team6 = selection;
      team6_obj = getNBATeamSeasonTotalStats(Database.teamNameAndIDHash.get(team6), season);
      team6_obj.setTeamName(team6);
      relGraph_showTeam6 = true;
    }
  }
  team1_pressed = false;
  team2_pressed = false;
  player1_pressed = false;
  player2_pressed = false;
  relGraph_Team3Pressed = false;
  relGraph_Team4Pressed = false;
  relGraph_Team5Pressed = false;
  relGraph_Team6Pressed = false;

  redraw();
}

void onClickWidget(APWidget widget) {

  StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build(); 
  StrictMode.setThreadPolicy(policy); 

  //BUTTONS OF MODE0 
  if (widget == button_team1) {    
    selectionlist = new KetaiList(this, teams); 
    team1_pressed = true;
  } else if (widget == button_team2) {
    selectionlist2 = new KetaiList(this, teams); 
    team2_pressed = true;
  } else if (widget == button_submit) {
    if (team1 == team2) {
      KetaiAlertDialog.popup(this, "Nice try...", "Please choose two different teams.");
    } else if ((team1 == "Team 1") || (team2 == "Team 2")) {
      KetaiAlertDialog.popup(this, "Not ready yet!", "Make sure you pick 2 teams.");
    } else {
      // required for calling network on newer versions of android
      //      StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build(); 
      //      StrictMode.setThreadPolicy(policy); 

      team1_obj = getNBATeamSeasonTotalStats(Database.teamNameAndIDHash.get(team1), season); 
      team2_obj = getNBATeamSeasonTotalStats(Database.teamNameAndIDHash.get(team2), season); 
      team1_obj.setTeamName(team1); 
      team2_obj.setTeamName(team2); 

      mode = 7;
      widgetContainer_SelectDataDisplay.show();
      widgetContainer_SubmitTeams.hide();
    }
  }


  //BUTTONS OF MODE7
  else if (widget == button_BarGraph) {
    mode = 1;
    widgetContainer_SelectDataDisplay.hide();
    TeamComparison_modeChanges.show();
  } else if (widget == button_TimeGraph) {

    team1_obj2013 = getNBATeamSeasonTotalStats(Database.teamNameAndIDHash.get(team1), "2013");
    team2_obj2013 = getNBATeamSeasonTotalStats(Database.teamNameAndIDHash.get(team2), "2013");
    team1_obj2013.setTeamName(team1);
    team2_obj2013.setTeamName(team2);  

    team1_obj2014 = getNBATeamSeasonTotalStats(Database.teamNameAndIDHash.get(team1), "2014");
    team2_obj2014 = getNBATeamSeasonTotalStats(Database.teamNameAndIDHash.get(team2), "2014");
    team1_obj2014.setTeamName(team1);
    team2_obj2014.setTeamName(team2);  

    mode = 8;
    widgetContainer_SelectDataDisplay.hide();
    TeamComparison_modeChanges.show();
  } else if (widget == button_RelGraph) {
    mode = 6;
    widgetContainer_SelectDataDisplay.hide();
    TeamComparison_modeChanges.show();
  } else if (widget == button_head2head) {
    mode = 1;
    widgetContainer_SelectDataDisplay.hide();
    TeamComparison_modeChanges.show();
  } else if (widget == button_BackToTeamSelectionM7) {
    mode = 0;
    widgetContainer_SelectDataDisplay.hide();
    widgetContainer_SubmitTeams.show();
    fill(255);
  } else if (widget == button_BackM7) {
    if (mode == 2) {
      mode = 1;
    } else if (mode == 3) {
      mode = 2;
    } else if (mode == 9) {
      mode = 8;
    } else if (mode == 10) {
      mode = 9;
    }
  } else if (widget == button_NextM7) {
    if (mode == 1) {
      mode = 2;
    } else if (mode == 2) {
      mode = 3;
    } else if (mode == 8) {
      mode = 9;
    } else if (mode == 9) {
      mode = 10;
    }
  } else if (widget == button_ReturnM7) {
    mode = 7;
    TeamComparison_modeChanges.hide();
    widgetContainer_SelectDataDisplay.show();
  }


  //BUTTONS OF MODE1
  else if (widget == button_BarGraphs) {
    mode = 1;
  } else if (widget == button_LineGraphs) {
    mode = 6;
  } else if (widget == button_Statistics) {
    mode = 0; 
    widgetContainer_Graphs.hide(); 
    widgetContainer_SubmitTeams.show(); 
    fill(255);
  } else if (widget == button_BackM1) {
    if (mode == 1) {
      mode = 7;
      widgetContainer_Graphs.hide();
      widgetContainer_SelectDataDisplay.show();
      fill(255);
    } else if (mode == 2) {
      mode = 1; 
      widgetContainer_Graphs.show();
    } else if (mode == 3) {
      mode = 2; 
      widgetContainer_Graphs.show();
    } else if (mode == 6) {
      mode = 7;
      widgetContainer_Graphs.hide();
      widgetContainer_SelectDataDisplay.show();
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
      //      StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build(); 
      //      StrictMode.setThreadPolicy(policy); 

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

  // used for selecting live game in mode 98 (live games)
  int WC_LiveButtons_counter = 0;
  boolean LiveButtonWidgetFound = false;
  for (int i = 0; i < WC_LiveButtons.size (); i++) {
    if (widget == WC_LiveButtons.get(i)) {
      backButtonStack.push(mode);
      mode = 97;
      LiveButtonWidgetFound = true;
      break;
    }
    WC_LiveButtons_counter++;
  }
  if (LiveButtonWidgetFound) {
    selectedGame = gamesToday.get(WC_LiveButtons_counter);
    if (!selectedGame.getStatus().equals("scheduled")) {
      selectedGameSummary = getNBAGameSummary(selectedGame.getId());
    }
    WC_live.hide();
  }

  // main screen mode
  int WC_mainButtons_counter = 0;
  boolean mainButtonWidgetFound = false;
  for (int i = 0; i < WC_mainButtons.size (); i++) {
    if (widget == WC_mainButtons.get(i)) {
      mainButtonWidgetFound = true;
      break;
    }
    WC_mainButtons_counter++;
  }
  if (mainButtonWidgetFound) {
    // live data
    if (WC_mainButtons_counter == 0) {
      backButtonStack.push(mode);
      mode = 98;
    }
    // player comparison
    else if (WC_mainButtons_counter == 1) {
      //      backButtonStack.push(mode);
      //      mode = 99;
    } 
    // team comparison
    else if (WC_mainButtons_counter == 2) {
      backButtonStack.push(mode);
      mode = 0;
      widgetContainer_SubmitTeams.show();
    }
    // PLACEHOLDER
    else if (WC_mainButtons_counter == 3) {
      //      backButtonStack.push(mode);
      //      mode = 99;
    }
    WC_main.hide();
  }

  redraw();
}

NBAGameSummary getNBAGameSummary(String gameID) {
  pauseFor(1000); 
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
  pauseFor(1000); 
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
  pauseFor(1000); 
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
  pauseFor(1000); 
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

// argument is team ID for a specific team
Map<String, String> getTeamRoster(String teamID) {
  pauseFor(1000); 
  println("********** Getting roster for " + teamID + " **********"); 
  Map<String, String> roster = new HashMap<String, String>(); // Player Name -> Player ID
  String URI = "http://api.sportradar.us/nba-t3/teams/" + teamID + "/profile.xml?api_key=" + NBAkey; 
  println("URI is: " + URI); 
  xml = loadXML(URI);

  XML players = xml.getChild("players");
  XML [] player = players.getChildren("player");

  for (int i = 0; i < player.length; i++) {
    roster.put(player[i].getString("full_name"), player[i].getString("id"));
  }

  return roster;
}

/*
  This method will print out all the nba teams
 ONLY FOR DEBUGGING AND TESTING
 */
void leagueHierarchy() {
  pauseFor(1000); 
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

void moveGraph (int x, int y) {
  moveHorizontal = x; 
  moveVertical = y;
}

void pauseFor(int timeInMiliSec) {
  try {
    Thread.sleep(timeInMiliSec);
  } 
  catch(InterruptedException ex) {
    Thread.currentThread().interrupt();
  }
}

void preMode() {
  WC_live.hide();
  WC_main.hide();
  widgetContainer_SubmitPlayers.hide();
  widgetContainer_SubmitTeams.hide();
  widgetContainer_Graphs.hide();
  widgetContainer_SelectDataDisplay.hide();
  TeamComparison_modeChanges.hide();
  widgetContainer_SubmitTeams.hide();
  background(0, 0, 80);
  fill(255);
  textSize(80); 
  textAlign(LEFT);
}

@ Override
void onBackPressed() {
  if (!backButtonStack.empty()) {
    mode = backButtonStack.pop();
    redraw();
  } else {
    super.onBackPressed();
  }
}

