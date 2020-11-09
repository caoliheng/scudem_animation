// Liheng Cao
// NYU
// SCUDEM 2020, Problem B


PImage bird;
float bird_scaling = 0.5;
String[] input_file;
int counter = 1;

int anim_x = 500;
int anim_y = 500;

void setup() {
  size(1500, 1000);
  //translate(anim_x, anim_y);
  textSize(20);

  bird = loadImage("bird.png"); // loads the bird png
  imageMode(CENTER); // images get placed by their center points, instead of a corner

  input_file = loadStrings("input.csv"); // read our theta, psi input file
  println(input_file.length);
}

void draw() {
  background(255); // white background
  
  String[] input = split(input_file[counter], ','); // read file and split up using comma as delimiter
  float theta = -Float.parseFloat(input[2]); // parse to numher and adjust sign
  float psi = -Float.parseFloat(input[3]); // parse to number and adjust sign
  
  ++counter; // move to next line of file
  if (counter == 1200) counter = 1; // restart animation

  draw_wheel(anim_x, anim_y, 300, 8, theta, psi); // draw left side
  draw_info(anim_x + 500, anim_y, theta, psi); // draw right side
}

// draws wheel, bird (on wheel) and spokes
void draw_wheel(float x, float y, float radius, int spokes, float theta, float psi) {
  pushMatrix();
  translate(x, y);
  rotate(-theta);
  
  circle(0, 0, 2 * radius); // outer wheel
  draw_bird(0, 0, psi, radius); // bird
  if (spokes != 0) { // spokes
    for (float spoke_theta = 0; spoke_theta <= 2.0; spoke_theta += 2.0/spokes) {
      line(0, 0, radius*sin(spoke_theta*PI), radius*cos(spoke_theta * PI));
    }
  }
  
  popMatrix();
}


void draw_bird(float x, float y,  float psi, float radius) {
  pushMatrix();
  translate(x, y- radius - bird.height/2 * bird_scaling);
  rotate(-psi);
  
  image(bird, 0, 0, bird.width * bird_scaling, bird.height * bird_scaling);
  
  popMatrix();
}

void draw_info(float x, float y, float theta, float psi){
  pushMatrix();
  translate(x+250, y-300);
  rotate(-psi);
  
  image(bird, 0, 0, bird.width * bird_scaling, bird.height * bird_scaling); // bird
  
  popMatrix();
  
  arc(x+250, y + bird.height/2 * bird_scaling, 600, 600, -3 * PI/4 , -PI/4); // wheel
  fill(0);
  
  
  text(
  "Time: " + Math.floorDiv(counter * 10, 60)/10.0 + // round to 1 decimal place
  "\nAngle of the wheel and the world: " + -theta +  
  "\nAngle of the wheel and the bird:   " + -psi
  , x, y+100);
  fill(255);
}
