public void dial(){
  noFill();
  stroke(250);
  ellipse(w/2, h/2, 400, 400);
  
  fixationCross(10);
  fill(250);
  textAlign(CENTER, TOP);
  text("You are standing at:", w/2, h/2+10);
  text(location_A, w/2, h/2+30);
 
  textAlign(CENTER, BOTTOM);
  text("You are facing towards:", w/2, h/2-220);
  text(location_B, w/2, h/2-200);
}
