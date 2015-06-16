public void fixationCross(int a){
  pushMatrix();
    translate(w/2, h/2);
    line(-a, 0, a, 0);
    line(0, -a, 0, a);
  popMatrix();
}
