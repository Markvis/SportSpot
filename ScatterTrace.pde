class ScatterTrace extends Blank2DTrace {
  private ArrayList _data;
  private float pSize = 4f;

  public ScatterTrace() {
    _data = new ArrayList();
  }

  public void addPoint(float x, float y) {
    _data.add(new Point2D(x, y));
  }

  private void drawPoint(Point2D p, Blank2DTrace.PlotRenderer pr) {
    // p.X and p.Y are values of the point in Graph space, here 
    // we convert them into the screen space, i.e. pixels.
    float x = pr.valToX(p.X);
    float y = pr.valToX(p.Y);

    pr.canvas.pushStyle();
    pr.canvas.stroke(255, 0, 0);
    pr.canvas.line(x-pSize, y, x+pSize, y);
    pr.canvas.line(x, y-pSize, x, y+pSize);      
    pr.canvas.popStyle();
  }

  public void TraceDraw(Blank2DTrace.PlotRenderer pr) {
    if (_data != null) {            
      for (int i = 0; i < _data.size (); i++) {
        drawPoint((Point2D)_data.get(i), pr);
      }
    }
  }
}
