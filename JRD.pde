/**
 * Load and Display 
 * 
 * Images can be loaded and displayed to the screen at their actual size
 * or any other size. 
 */

// The next line is needed if running in JavaScript Mode with Processing.js
/* @pjs preload="moonwalk.jpg"; */


import controlP5.*;
ControlP5 cp5;


String participant_ID = null;
PFont font32 = createFont("arial", 32);
PFont font20 = createFont("arial", 20);

int w = 700;
int h = 800;
int jrdCounter = 0;
long startCount = 0;
boolean recording = false;
boolean responded = false;
float angle = 0;
String location_A = "location A";
String location_B = "location B";
String location_C = "location C";
int slider_knob_x =0, slider_knob_y= 0;
int lastMouseX = w/2;
PrintWriter output;
float theta;


void setup() {
  size(w, h);
  textAlign(LEFT, TOP);


  cp5 = new ControlP5(this);

  cp5.mapKeyFor(new ControlKey() {public void keyEvent() {
      dataCollectionFinished();
    }
  }, ALT, SHIFT, 'd', ENTER);

 setupUI();


}

void draw() {
  background(0);
    showTest();
    slider();

  
//  if (participant_ID!=null) {
//    showTest();
//  } else {
//    showStart();
//  }
}



void keyPressed() {
  if (key==27)
    key=0;

}





void log (String thisLog) {

  output.println(thisLog);
  output.flush(); // Writes the remaining data to the file
}

void dataCollectionFinished() {
  
  if(recording){
    
    String j = "stop,"+ "NA" +", NA,"+ millis() +","+  System.currentTimeMillis();
    log(j);  // Write data to the file
  
    output.flush();  // Writes the remaining data to the file
    output.close();  // Finishes the file
    exit();  // Stops the program
  } else {
    exit();  // Stops the program
  }
}

// let's set a filter (which returns true if file's extension is .jpg)
java.io.FilenameFilter jpgFilter = new java.io.FilenameFilter() {
  boolean accept(File dir, String name) {
    return name.toLowerCase().endsWith(".jpg");
  }
};


public void controlEvent(ControlEvent theEvent) {

//  println(
//  "## controlEvent / id:"+theEvent.controller().id()+
//    " / name:"+theEvent.controller().name()+
//    " / label:"+theEvent.controller().label()+
//    " / value:"+theEvent.controller().value()
//    );
    
    switch(theEvent.controller().id()){
      
      case 3:
         // clear participant id textfield
         cp5.get(Textfield.class, "Participant_ID").clear();
         break;
      
      case 4: 
        // release slider knob
        if(participant_ID!=null){
          if(!cp5.get(Button.class, "Map_OK").isVisible()){
            String l = "select_familiarity, "+cp5.get(Slider.class, "Very_Familiar").getValue()+", "+ (millis()-startCount) +","+ millis() +","+  System.currentTimeMillis();
            log(l);  // Write data to the file
            cp5.get(Button.class, "Map_OK").setVisible(true);
          } else {
            println("slider event");
          }
        }
        break;
      case 5:
        // press MAP_OK button
        println("Map OK");
        cp5.get(Button.class, "Next").show();
        String j = "map_ok" +", NA,"+ (millis()-startCount) +","+ millis() +","+  System.currentTimeMillis();
        log(j);
        break;
      case 6:
        // press Next
//        String l = "final_familiarity, "+cp5.get(Slider.class, "Very_Familiar").getValue()+", "+ (millis()-startCount) +","+ millis() +","+  System.currentTimeMillis();
//        log(l);  // Write data to the file
//        
//        //         "event, value, elapsedTimeEvent, elapsedTimefromStart, epoch"
//        String k = "nextImage" +", NA,"+ (millis()-startCount) +","+ millis() +","+  System.currentTimeMillis();
//        log(k);  // Write data to the file
        
        if (responded) {
            responded = false;
            println("Next");
            jrdCounter++;
            newTrial();
           } 
        break;
      default:
      break;
    }
}

void newTrial(){
  responded = true;
  angle = 0;
  lastMouseX = w/2;
  startCount = millis();

  cp5.get(Button.class, "Don't know").show();
  cp5.get(Button.class, "Next").hide() ;
 
  location_A = "location A";
  location_B = "location B";
  location_C = "location C";
  
  // make log

}



void showTest(){
    dial();
  
  
  

 if(mousePressed){
    stroke(250,0,0);
    responded = true;
  } else {
    stroke(200);   
  }
    
  if(responded){
    line(w/2, h/2, w/2+200*cos(radians(angle)),h/2+200*sin(radians(angle)) );
    noStroke();
    fill(250);
    ellipse(w/2+200*cos(radians(angle)),h/2+200*sin(radians(angle)), 5, 5);
    
    if(degrees(angle)<90){
      textAlign(LEFT, TOP);
    } else {
      textAlign(RIGHT, TOP);
    }
    
    text(location_C, w/2+200*cos(radians(angle)),h/2+200*sin(radians(angle)));
    
     
    
    cp5.get(Button.class, "Next").show();
    cp5.get(Button.class, "Don't know").show();
  } else {
    cp5.get(Button.class, "Next").hide();
    cp5.get(Button.class, "Don't know").show();  
  }
}

void showStart(){
  
  text("Enter your participant ID", 20, 150);
  cp5.get(Textfield.class, "Participant_ID").show();
  cp5.get(Bang.class, "clear").show();
  cp5.get(Bang.class, "OK").show();
  
}





