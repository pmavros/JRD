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
String [] combinations;
Trial [] locations = new Trial[21];


void setup() {
  size(w, h);
  smooth();
  
  
  textAlign(LEFT, TOP);

  cp5 = new ControlP5(this);

  // setup key-press combination to exit program
  // this is to prevent accidental exit
  cp5.mapKeyFor(new ControlKey() {public void keyEvent() {
      dataCollectionFinished();
    }
  }, ALT, SHIFT, 'd', ENTER);

   setupUI();
 
 
  location_A = "CASA";
  location_B = "Warren Street Station";
  location_C = "Kings Cross Station";

  start();
  
  for(int i=0; i<trial.length; i++){
//    print("charat ");
//    print(trial[i].substring(0,1));
//    print(" ");
//    println(int(trial[i].substring(0,1)));    
      locations[i] = new Trial(int(trial[i].substring(0,1)), int(trial[i].substring(1,2)), int(trial[i].substring(2,3))); 
  }
 

}

void draw() {
  background(0);
    
    

  
  if (participant_ID!=null) {
    showTest();
    
  } else {
    showStart();
  }
}



void keyPressed() {
  if (key==27)
    key=0;

}







// let's set a filter (which returns true if file's extension is .jpg)
java.io.FilenameFilter jpgFilter = new java.io.FilenameFilter() {
  boolean accept(File dir, String name) {
    return name.toLowerCase().endsWith(".jpg");
  }
};

public void OK() {

  String inputText = cp5.get(Textfield.class, "Participant_ID").getText();

  if (inputText!=null && inputText!="") {
    participant_ID = inputText;
    output = createWriter("data/"+participant_ID+"_Fitzrovia-Image-data.csv"); 

    // "event, value, elapsedTimeEvent, elapsedTimefromStart, epoch"
    String j = "start, "+participant_ID +", NA,"+ millis() +","+  System.currentTimeMillis();
    log(j);  // Write data to the file
    
    cp5.get(Textfield.class, "Participant_ID").setVisible(false);
    cp5.get(Bang.class, "clear").setVisible(false);
    cp5.get(Bang.class, "OK").setVisible(false);
    cp5.get(Slider.class, "Very_Familiar").setVisible(true);
    
    recording = true;
  }


}

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
        println(theEvent.controller().value());
       
        theta= theEvent.controller().value();
        angle = theta-90;
        //        textAlign(LEFT,TOP);
        //        text(theta, 50,50); 
        
        break;
      case 5:
        // pressed DONT_KNOW button
        // println("Map OK");
        String h = jrdCounter+"," + "dontknow" +", "+theta +", "+ locations +","+ (millis()-startCount) +","+ millis() +","+  System.currentTimeMillis();
        log(h);  // Write data to the file
        break;
      case 6:
        // pressed Next
        //  "counter, event, angle, locations, elapsedTimeEvent, totalElapsedTime, epoch"
        String j = jrdCounter+"," + "next" +", "+theta +", "+ locations +","+ (millis()-startCount) +","+ millis() +","+  System.currentTimeMillis();
        log(j);  // Write data to the file
        
        if (responded) {
            println("Next");
            newTrial();
           } 
        break;
      default:
      break;
    }
}

void newTrial(){
  jrdCounter++;
  responded = false;
  angle = 0;
  
  // reset slider knob
  lastMouseX = w/2;
  
  // reset response time
  startCount = millis();

  cp5.get(Button.class, "Don't know").show();
  cp5.get(Button.class, "Next").hide() ;
  cp5.get(Slider.class, "Direction").setValue(180) ;
 
  location_A = locations[jrdCounter].a;
  location_B = locations[jrdCounter].b;
  location_C = locations[jrdCounter].c;
  
//  locations =  location_A+"  "+ location_B+"  "+location_C;
  
  // make log
  //  "coumter, event, angle, locations, elapsedTimeEvent, totalElapsedTime, epoch"
  String k = jrdCounter+"," + "newTrial" +", NA,"+ locations +","+ 0 +","+ millis() +","+  System.currentTimeMillis();
  log(k);  // Write data to the file
}



void showTest(){
    dial();
//    slider();
    cp5.get(Slider.class, "Direction").show();
  
  
  

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
    
    if(theta<180){
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




