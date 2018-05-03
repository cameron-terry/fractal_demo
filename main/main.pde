float[][] outputs;

RandomIFS[] set;

int PIXELS = 100000;
float xmin, xmax, ymin, ymax;

void setup() {
  int SET_NO = 2;
  background(0);
  
  outputs = new float[PIXELS][2];
  
  // three samples:
  set = new RandomIFS[3];
  
  // Barnsley fern
  set[0] = new RandomIFS(new float[][]{
                      {0.0, 0.0, 0.0, 0.16, 0.0, 0.0, 0.01},
                      {0.2, -0.26, 0.23, 0.22, 0.0, 1.6, 0.07},
                      {-0.15, 0.28, 0.26, 0.24, 0.0, 0.44, 0.07},
                      {0.85, 0.04, -0.04, 0.85, 0.0, 1.6, 0.85}
                    });
                    
  // Heighway Dragon
  set[1] = new RandomIFS(new float[][]{
                      {-0.4, 0.0, 0.0, -0.4, -1.0, 0.1, 0.5},
                      {0.76, -0.4, 0.4, 0.76, 0.0, 0.0, 0.5}
                    });
    
  // a tree thing
  set[2] = new RandomIFS(new float[][]{
                      {0.000, 0.000, 0.000, 0.600, 0.00, -0.065, 0.1},
                      {0.440, 0.000, 0.000, 0.550, 0.00, 0.200, 0.18},
                      {0.343, -0.248, 0.199, 0.429, -0.03, 0.100, 0.18},
                      {0.343, 0.248, -0.199, 0.429, 0.03, 0.100, 0.18},
                      {0.280, -0.350, 0.280, 0.350, -0.05, 0.000, 0.18},
                      {0.280, 0.350, -0.280, 0.350, 0.05, 0.000, 0.18}
                    });
  
  outputs[0] = set[SET_NO].transform(new float[]{1.0, 1.0});
  
  // generate next pixel based on last
  for (int pixel = 1; pixel < PIXELS; pixel++) {
    outputs[pixel] = set[SET_NO].transform(outputs[pixel - 1]);
  }  
  
  xmin = ymin = MAX_FLOAT;
  xmax = ymax = -1;
  
  for (int i = 0; i < PIXELS; i++) {
    if (outputs[i][0] > xmax)
      xmax = outputs[i][0];
    if (outputs[i][0] < xmin)
      xmin = outputs[i][0];
    if (outputs[i][1] > ymax)
      ymax = outputs[i][1];
    if (outputs[i][1] < ymin)
      ymin = outputs[i][0];
    
    // scale to screen coords
    outputs[i] = to_scale(outputs[i]);
  }
  
  print("[(<xmin>, <xmax>)], [(<ymin>, <ymax>)]\n");
  print("----------------------------------------\n");
  print("[(" + xmin + ", " + xmax + ")], [(" + ymin + ", " + ymax + ")]");
  
  size(800, 800);
}

void draw() {
  for (int i = 0; i < outputs.length; i++)
    // translate coord to point on screen
    ellipse(int(outputs[i][0]), int(outputs[i][1]), 3, 3);
}

float[] to_scale(float[] values) {
  float[] t_values = new float[2];
  
  t_values[0] = width / (xmax - xmin) * (values[0] - xmin);
  t_values[1] = -height / (ymax - ymin) * (values[1] - ymax);
  
  return t_values;
}