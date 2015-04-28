import apwidgets.*;
import ketai.ui.*;

KetaiList selectionlist;
KetaiList selectionlist2;
ArrayList<String> teams = new ArrayList<String>();

APWidgetContainer widgetContainer_SubmitTeams;
APButton button_submit, button_team1, button_team2;

String team1 = "Team 1";
String team2 = "Team 2";
String selection = "Team ";
String season = "2014";

boolean team1_pressed = false;
boolean team2_pressed = false;

void setup () {

  orientation(LANDSCAPE);
  frameRate(60);

  teams.add("Clippers");
  teams.add("Golden State Warriors");
  teams.add("Pelicans");
  teams.add("Spurs");

  widgetContainer_SubmitTeams = new APWidgetContainer(this); //create new container for widgets in mode0

  button_submit = new APButton(width/2 - width/12, height - height/4, width/6, height/6, "Submit"); //create new button from x- and y-pos and label. size determined by text content
  button_team1 = new APButton(width/12, height/9, width/4, height/7, "Select Team 1"); 
  button_team2 = new APButton(width - width/12 - width/4, height/9, width/4, height/7, "Select Team 2"); 
  button_submit.setTextSize(25);
  button_team1.setTextSize(20);
  button_team2.setTextSize(20);

  widgetContainer_SubmitTeams.addWidget(button_submit);
  widgetContainer_SubmitTeams.addWidget(button_team1);
  widgetContainer_SubmitTeams.addWidget(button_team2);

  widgetContainer_SubmitTeams.show();
}

void draw() {

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

  triangle(width/2 + 150, height/9 + 40, 
  width/2 + 150, height/9 + 90, 
  width/2 + 200, height/9 + 65);
  triangle(width/2 - 150, height/9 + 40, 
  width/2 - 150, height/9 + 90, 
  width/2 - 200, height/9 + 65);
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
    } else {
    }
  }
}

