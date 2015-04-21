// imports
import org.gwoptics.graphics.graph2D.Graph2D;
import org.gwoptics.graphics.graph2D.traces.Blank2DTrace;
import apwidgets.*;
import java.io.*;

// globals
int mode;
XML xml;
ScatterTrace sTrace;
Graph2D g;

// keys
String NBAkey = "k4mqkpzfmq24f7yatqyvztxk";
String MLBkey = "4nfwbpjthrsfsaeeh73szu8j";

void setup() {
  orientation(PORTRAIT);
  //size(800, 600, P2D);
  frameRate(30);
  println("setup");
  int mode = 0;
  //  xml = loadXML("cache/TimDuncan.xml");
  //  XML[] children = xml.getChildren("team");
  //
  //  for (int i = 0; i < children.length; i++) {
  //    String id = children[i].getString("id");
  //    String market = children[i].getString("market");
  //    String name = children[i].getString("name");
  //    println(id + ", " + market + ", " + name);
  //  }

  //  sTrace  = new ScatterTrace();
  //
  //  g = new Graph2D(this, 400, 400, true);
  //  g.setAxisColour(220, 220, 220);
  //  g.setFontColour(255, 255, 255);
  //
  //  g.position.y = 50;
  //  g.position.x = 100;
  //
  //  g.setYAxisTickSpacing(1f);
  //  g.setXAxisTickSpacing(1f);
  //
  //  g.setXAxisMinorTicks(1);
  //  g.setYAxisMinorTicks(1);
  //
  //  g.setYAxisMin(0f);
  //  g.setYAxisMax(10f);
  //
  //  g.setXAxisMin(0f);
  //  g.setXAxisMax(10f);
  //  g.setXAxisLabelAccuracy(0);
  //
  //  g.addTrace(sTrace);
  //
  //  for (int i=0; i<100; i++) {
  //    sTrace.addPoint(random(0, 10), random(0, 10));
  //  }

  dayScreduleRetrieve("2015", "04", "20");

  println("END SETUP");
} // END SETUP

void draw() {
  background(0);
  //  if(mode == 1){
  //    g.draw();
  //  }
}

void dayScreduleRetrieve(String year, String month, String day) {
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
XML games = dailySchedule.getChild("games");
XML [] game = games.getChildren("game");
  
  for (int i = 0; i < game.length; i++) {
    String id = game[i].getString("id");
    String title = game[i].getString("title");
    String status = game[i].getString("status");
    println(id + ", " + title + ", " + status);
  }
}

