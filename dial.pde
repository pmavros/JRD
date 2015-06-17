public void dial(){
  noFill();
  stroke(250);

  strokeWeight(1);
  ellipse(w/2, h/2, 400, 400);
  
  strokeWeight(2);
  line(w/2, h/2 - 200 - 10, w/2, h/2 - 200 + 10 );
  
  fixationCross(10);
  textSize(14);
  textAlign(LEFT, TOP);
  text("Use the slider to change the orientation of the dial", 20, 60);

  
  
  fill(250);
  textAlign(CENTER, TOP);
  text("You are standing at:", w/2, h/2+10);
  text(location_A, w/2, h/2+30);
 
  textAlign(CENTER, BOTTOM);
  text("You are facing towards:", w/2, h/2-235);
  text(location_B, w/2, h/2-215);
}
