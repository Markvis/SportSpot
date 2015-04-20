// imports
import org.gwoptics.graphics.graph2D.Graph2D;
import org.gwoptics.graphics.graph2D.traces.Blank2DTrace;

// globals
int mode;
XML xml;
ScatterTrace sTrace;
Graph2D g;

void setup() {
  //orientation(PORTRAIT);
  size(800, 600);
  frameRate(30);
  println("setup");
  int mode = 0;
  xml = loadXML("data/cache/TimDuncan.xml");
  XML[] children = xml.getChildren("team");

  for (int i = 0; i < children.length; i++) {
    String id = children[i].getString("id");
    String market = children[i].getString("market");
    String name = children[i].getString("name");
    println(id + ", " + market + ", " + name);
  }
}

void draw() {
  background(0);
  //g.draw();
}

