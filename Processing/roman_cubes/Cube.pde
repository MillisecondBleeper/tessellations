class Cube {
    public PVector center;
    public float radius;
    public IntDict properties;
    public float angle;
    public float stretchFactor = 1.0;
    public boolean debug = false;
    private PVector currentCenter;
    private float apothem;
    public Cube(PVector center, float radius, float angle, IntDict properties) {
        this.center = center;
        this.currentCenter = center;
        this.radius = radius;
        this.angle = angle;
        this.apothem = radius * 0.866025403784;
        this.properties = properties;
    }
    
    public float getApothem() {
        return apothem;
    }
    public boolean hovered() {
        float xcoord = mouseX-this.currentCenter.x;
        float ycoord = mouseY-this.currentCenter.y;
        float theta = (float)Math.atan2(ycoord, xcoord);
        float dist = sqrt(ycoord*ycoord+xcoord*xcoord);
        return (theta >= angle - 2 * PI / 3 && theta <= angle && dist<=this.radius);
    }
    
    public void draw() {
        noStroke();
        PVector left = new PVector(this.center.x - cos(angle) * this.radius, this.center.y + sin(-angle) * this.radius);
        PVector botright = new PVector(this.center.x + cos((PI / 3) + angle) * this.radius, this.center.y + sin((PI / 3) + angle) * this.radius);
        PVector botleft = new PVector(this.center.x + cos((TWO_PI / 3) + angle) * this.radius, this.center.y + sin((TWO_PI / 3) + angle) * this.radius);
        color lightfill = this.properties.get("light");
        color medfill = this.properties.get("med");
        color darkfill = this.properties.get("dark");
        if(hovered()) {
          if(!mousePressed) {
            currentCenter = new PVector(this.center.x - cos((TWO_PI / 3) + angle) *radius / 3, this.center.y-sin((TWO_PI / 3) + angle) *radius/3);
          }
          lightfill = this.properties.get("light_hover");
          medfill = this.properties.get("med_hover");
          darkfill = this.properties.get("dark_hover");
        }
        else {
          currentCenter = new PVector(this.center.x, this.center.y);
        }
        PVector right = new PVector(currentCenter.x + cos(angle) * this.radius, currentCenter.y + sin(angle) * this.radius);
        PVector topleft = new PVector(currentCenter.x + cos((4 * PI / 3) + angle) * this.radius, currentCenter.y + sin((4 * PI / 3) + angle) * this.radius);
        PVector topright = new PVector(currentCenter.x + cos((5 * PI / 3) + angle) * this.radius, currentCenter.y + sin((5 * PI / 3) + angle) * this.radius);
        
        PShape tr = createShape();
        tr.beginShape();
        tr.fill(lightfill);
        tr.vertex(currentCenter.x,currentCenter.y);
        tr.vertex(right.x,right.y);
        tr.vertex(topright.x,topright.y);
        tr.vertex(topleft.x,topleft.y);
        tr.endShape(CLOSE);
        shape(tr);
        
        PShape br = createShape();
        br.beginShape();
        br.fill(darkfill);
        br.vertex(currentCenter.x,currentCenter.y);
        br.vertex(right.x,right.y);
        br.vertex(botright.x,botright.y);
        br.vertex(botleft.x,botleft.y);
        br.endShape(CLOSE);
        shape(br);
        
        PShape bl = createShape();
        bl.beginShape();
        bl.fill(medfill);
        bl.vertex(currentCenter.x,currentCenter.y);
        bl.vertex(botleft.x,botleft.y);
        bl.vertex(left.x,left.y);
        bl.vertex(topleft.x,topleft.y);
        bl.endShape(CLOSE);
        shape(bl);
        
        if(debug) {
          stroke(#FF00FF);
          noFill();
          arc(currentCenter.x,currentCenter.y, 2*this.radius, 2*this.radius, angle - 2 * PI / 3, angle, PIE);
          float xcoord = mouseX-this.center.x;
          float ycoord = mouseY-this.center.y;
          float theta = (float)Math.atan2(ycoord, xcoord);
          float dist = sqrt(ycoord*ycoord+xcoord*xcoord);
          if(theta >= angle - 2 * PI / 3 && theta <= angle && dist<=this.radius) stroke(#00FF00);
          line(currentCenter.x,currentCenter.y, mouseX, mouseY);
        }
    }
}
