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
  size(800, 600, P2D);
  frameRate(30);
  println("setup");
  int mode = 0;
  //File file = new File("data/cache/TimDuncan.xml");
  //File file = getActivity().getFileStreamPath("data/cache/TimDuncan.xml");
  xml = loadXML("cache/TimDuncan.xml");
  XML[] children = xml.getChildren("team");

  for (int i = 0; i < children.length; i++) {
    String id = children[i].getString("id");
    String market = children[i].getString("market");
    String name = children[i].getString("name");
    println(id + ", " + market + ", " + name);
  }
  
  sTrace  = new ScatterTrace();
    
    g = new Graph2D(this, 400,400, true);
    g.setAxisColour(220, 220, 220);
    g.setFontColour(255, 255, 255);
        
    g.position.y = 50;
    g.position.x = 100;
        
    g.setYAxisTickSpacing(1f);
    g.setXAxisTickSpacing(1f);
    
    g.setXAxisMinorTicks(1);
    g.setYAxisMinorTicks(1);
    
    g.setYAxisMin(0f);
    g.setYAxisMax(10f);
        
    g.setXAxisMin(0f);
    g.setXAxisMax(10f);
    g.setXAxisLabelAccuracy(0);
    
    g.addTrace(sTrace);
        
    for(int i=0;i<100;i++){
      sTrace.addPoint(random(0,10),random(0,10));
    }
}

void draw() {
  background(0);
//  if(mode == 1){
//    g.draw();
//  }
}

void retrieve(){
  
}
