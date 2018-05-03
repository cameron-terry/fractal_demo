class RandomIFS {
  float[][] coeffs;
  int eqns;

  // Constructor
  RandomIFS(float[][] given_coeffs) {  
    this.eqns = given_coeffs.length;

    // build matrix of size eqns x 7
    this.coeffs = new float[eqns][7];

    // store values
    for (int i = 0; i < eqns; i++) {
      for (int j = 0; j < 7; j++) {
        this.coeffs[i][j] = given_coeffs[i][j];
      }
    }
  }

  float[] transform(float[] orig_coords) {
    if (orig_coords.length != 2)
      print("Dimension of coordinates expected: 2, recieved: " + orig_coords.length);

    float[] transf_coords = new float[2];

    // choose an equation based on probabilities
    boolean chosen = false;
    int to_sel = 0;

    while (!chosen) {
      if (to_sel == this.eqns) {
        to_sel = 0;
      } else if (random(1) < this.coeffs[to_sel][6]) {
        chosen = true;
      }

      to_sel++;
    }


    float[] eqn = this.coeffs[to_sel - 1];

    // transform the point using
    // x' = ax + by + e, y' = cx + dy + f
    transf_coords[0] = eqn[0] * orig_coords[0] + eqn[1] * orig_coords[1] + eqn[4];
    transf_coords[1] = eqn[2] * orig_coords[0] + eqn[3] * orig_coords[1] + eqn[5];

    //print(transf_coords[0] + "||" + transf_coords[1] + "\n");
    return transf_coords;
  }
}