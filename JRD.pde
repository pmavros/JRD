/**
 * Load and Display 
 * 
 * Images can be loaded and displayed to the screen at their actual size
 * or any other size. 
 */

// The next line is needed if running in JavaScript Mode with Processing.js
/* @pjs preload="moonwalk.jpg"; */

PImage img;  // Declare variable "a" of type PImage

import controlP5.*;
Table data;
ControlP5 cp5;
int myColor = color(0, 0, 0);

int sliderValue = 100;
int sliderTicks1 = 100;
int sliderTicks2 = 30;

String participant_ID = null;
PFont font32 = createFont("arial", 32);
PFont font20 = createFont("arial", 20);

int w = 700;
int h = 800;
int imageCounter = 0;

String[] imageList;
File dir = new File("/Users/Panos/Documents/Projects/201409_Fitzrovia/001_goals/new/");

Slider abc;

PrintWriter output;
boolean madeMarkOnMap = false;
long startCount = 0;
boolean recording = false;
void setup() {
  size(w, h);
  textAlign(LEFT, TOP);

  img = loadImage("/Users/Panos/Documents/Projects/201409_Fitzrovia/001_goals/new/fixationcross.jpg");  // Load the image into the program  
  img.resize(w, 0);

  cp5 = new ControlP5(this);

  cp5.mapKeyFor(new ControlKey() {public void keyEvent() {
      dataCollectionFinished();
    }
  }, ALT, SHIFT, 'd', ENTER);

 setupUI();

  imageList = dir.list(jpgFilter);

  if (imageList == null) {
    println("Folder does not exist or cannot be accessed.");
  } else {
    println(imageList.length);
    println(imageList);
  }
}

void draw() {
  background(0);
    showTest();

  
//  if (participant_ID!=null) {
//    showTest();
//  } else {
//    showStart();
//  }
}

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

void keyPressed() {
  if (key==27)
    key=0;

}

void loadNewImage() {
  
  madeMarkOnMap = false;
  
  cp5.get(Slider.class, "Very_Familiar").setValue(3.5);
  
  String imgUrl = dir+"/"+imageList[imageCounter];
  println("Load new image "+imgUrl);

  img = loadImage(imgUrl);  // Load the image into the program  
  img.resize(w, 0);

  startCount = millis();

  //         "event, value, elapsedTimeEvent, elapsedTimefromStart, epoch"
  String j = "newImage,"+ imageList[imageCounter] +", NA,"+ millis() +","+  System.currentTimeMillis();
  log(j);  // Write data to the file

  cp5.get(Button.class, "Map_OK").hide() ;
  cp5.get(Button.class, "Next").hide() ;

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

public void setupUI(){
    cp5.addTextfield("Participant_ID")
    .setVisible(false)
    .setId(1)  
      .setPosition(20, 170)
        .setSize(200, 40)
          .setFont(createFont("arial", 20))
            .setAutoClear(false)
              ;

  cp5.addBang("OK")
    .setId(2)
    .setVisible(false)
      .setPosition(240, 170)
        .setSize(80, 40)
          .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
            ;

  cp5.addBang("clear")
    .setId(3)
    .setVisible(false)
      .setPosition(240, 220)
        .setSize(80, 40)
          .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
            ;    


  // add a horizontal sliders, the value of this slider will be linked
  // to variable 'sliderValue' 
  cp5.addSlider("Very_Familiar")
    .setId(4)
    .setPosition(50, h-150)
    .setSize(200, 20)
    .setRange(0, 7)
    .setValue(3.5)
    .setNumberOfTickMarks(7)
    .setTriggerEvent(Slider.RELEASE)
    .snapToTickMarks(false)
    .setVisible(false)
    ;

  cp5.addButton("Map_OK")
    .setId(5)
      .setPosition(w-100, h-100)
        .setSize(80, 40)
          .setVisible(false)
            .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
              ;

  cp5.addButton("Next")
    .setId(6)
     .setPosition(w-100, h-50)
     .setSize(80, 40)
     .setVisible(false)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
              ;
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
        madeMarkOnMap = true;
        String j = "map_ok" +", NA,"+ (millis()-startCount) +","+ millis() +","+  System.currentTimeMillis();
        log(j);
        break;
      case 6:
        // press Next
        String l = "final_familiarity, "+cp5.get(Slider.class, "Very_Familiar").getValue()+", "+ (millis()-startCount) +","+ millis() +","+  System.currentTimeMillis();
        log(l);  // Write data to the file
        
        //         "event, value, elapsedTimeEvent, elapsedTimefromStart, epoch"
        String k = "nextImage" +", NA,"+ (millis()-startCount) +","+ millis() +","+  System.currentTimeMillis();
        log(k);  // Write data to the file
        
        if (madeMarkOnMap) {
            madeMarkOnMap = false;
            println("Next");
            imageCounter++;
            loadNewImage();
           } 
        break;
      default:
      break;
    }
}

boolean responded = false;

void showTest(){
  float angle = 0;
  
  
  
  noFill();
  
  ellipse(w/2, h/2, 400, 400);
  
  fixationCross(10);
  
  textAlign(CENTER, TOP);
  text("You are standing at:", w/2, h/2+10);
  text("location A", w/2, h/2+30);

  
  textAlign(CENTER, BOTTOM);
  text("You are facing towards:", w/2, h/2-220);
  text("location B", w/2, h/2-200);
 
  if(mousePressed){
    stroke(250,0,0);
    responded = true;
    
    angle= radians(mouseX-90);
//    mouseY

    
    line(w/2, h/2, w/2+200*cos(angle),h/2+200*sin(angle) );
    noStroke();
    fill(250);
    ellipse(w/2+200*cos(angle),h/2+200*sin(angle), 5, 5);
    
    if(degrees(angle)<90){
      textAlign(LEFT, TOP);
    } else {
      textAlign(RIGHT, TOP);
    }
    text("location C", w/2+200*cos(angle),h/2+200*sin(angle));

    println(degrees(angle)+90);
  } else {
    stroke(250);
  }
  
  if (responded){
     cp5.get(Button.class, "Next").show();
  } else {
         cp5.get(Button.class, "Next").hide();

  }

  

}

void showStart(){
  text("Enter your participant ID", 20, 150);
  cp5.get(Textfield.class, "Participant_ID").show();
  cp5.get(Bang.class, "clear").show();
  cp5.get(Bang.class, "OK").show();
}

void fixationCross(int a){
  pushMatrix();
  translate(w/2, h/2);
   line(-a, 0, a, 0);
   line(0, -a, 0, a);
popMatrix();

}



