
public void slider(){
 noFill();
 stroke(250); 
 line(20, 20, w-20, 20);
 
 if(mouseY <50 && mouseX>15 && mouseX < w-15){
  
   fill(0,200, 200);
   
    if(mousePressed){
      lastMouseX = mouseX;
      theta= map(lastMouseX,15,w-15,0.0,360.9);
      angle = theta-90;
      
      
   }
 
 } else {
   fill(250);
 }

 noStroke();
 ellipse(lastMouseX, 20,10, 10); 
 textAlign(LEFT,TOP);
 text(theta, 50,50); 
}
