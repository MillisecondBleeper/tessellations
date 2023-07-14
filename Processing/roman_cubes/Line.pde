class Line {
      private PVector base;
      private PVector tip;
      public Line(PVector base, PVector tip) {
        this.base = base;
        this.tip = tip;
      }
      
      public void draw() {
        PShape tr = createShape();
        tr.beginShape();
        tr.stroke(#FF00FF);
        tr.vertex(base.x, base.y);
        tr.vertex(tip.x, tip.y);
        tr.endShape(OPEN);
        shape(tr);
      }
}
