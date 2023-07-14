color dark = #003434; // bottom right
color light = #00b3b3; //top
color med = #008080; // bottom left
float radius;
float angle = 0;
float apothem; // sqrt(3) / 2
int amt_shapes;
int cnt_shapes;

void setup() {
    // size(600,600);
    // fullScreen();
    // 8k
    //size(7680, 4320
    // HD
    size(1920, 1080);
    fullScreen();
    
    // amt_shapes = ceil(width / radius);
    amt_shapes = 30;
    radius = width / amt_shapes;
    apothem = radius * sqrt(3) / 2;
    angle = -PI /6;
    cnt_shapes = ceil(height / radius);
}
void tbdraw() {
  // background mauve to show imperfections
    background(#581019);
    for (int i = 0; i < amt_shapes; i++) {
        PVector prev_center = new PVector( (3* i - 1) * (radius/2), -(i%2+1)*apothem-radius);
        for (int j = 0; j < cnt_shapes; j++) {
            // if i is even, then the shape is on the bottom
            // if i is odd, then the shape is on the top
            
            // only variable directly dependent on i
            PVector center = new PVector(prev_center.x, prev_center.y + 2*apothem);
            Cube cube = new Cube(center, radius, angle, light, med, dark);
            cube.draw();
            prev_center = new PVector(center.x, center.y);
        }
    }
}
void lrdraw() {
 // background mauve to show imperfections
    background(#581019);
    for (int j = 0; j < cnt_shapes; j++) {
        PVector prev_center = new PVector( -3*radius, 0);
        for (int i = 0; i < amt_shapes/2; i++) {

            // only variable directly dependent on i
            PVector center = new PVector(prev_center.x + 3 * radius,(2 * j) * (apothem));
            Cube cube = new Cube(center, radius, angle, light, med, dark);
            //if(i == 5 && j == 3)cube.debug = true;
            cube.draw();
            prev_center = new PVector(center.x, center.y);
        }
        prev_center = new PVector( -9*radius/2, 0);
        for (int i = 0; i < amt_shapes-amt_shapes/2; i++) {

            // only variable directly dependent on i
            PVector center = new PVector(prev_center.x + 3 * radius,(2 * j+1) * apothem);
            Cube cube = new Cube(center, radius, angle, light, med, dark);
            cube.draw();
            prev_center = new PVector(center.x, center.y);
        }
    }
}
void draw() {
    lrdraw();
}

/*void mousePressed() {
    save("output/output.png");
}*/
void mouseWheel(MouseEvent event) {
  angle += PI * event.getCount()/180.0;
  println(angle);
}
