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

  cp5.addButton("Don't know")
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
