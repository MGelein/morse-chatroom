//We need the Serial line for the communication with the Arduino
import processing.serial.*;
//Used for the character API
import java.lang.*;

//The serial line we're using for communication with the arduino
Serial serial;

//String buffer that holds the characters that have been received, untill silence 
StringBuilder rcvBuffer = new StringBuilder();
//String buffer that holds the characterrs that have been sent untill silence
StringBuilder sndBuffer = new StringBuilder();

//The UI class
UI ui;

/**
Called once during setup of the sketch
**/
void setup(){
  //This application is meant to run fullscreen
  fullScreen(P3D);
  
  //Loads the morse-code definition file
  loadCode();
  
  //instantiate the UI
  ui = new UI();
  
  //Open the first available serial port at the baud rate that was specified in the arduino
  //serial = new Serial(this, Serial.list()[0], 115200);
  frameRate(30);
}

/**
Runs at the specified framerate. This should be 30fps,
if the computer can keep up.
**/
void draw(){
  //Handle the serial management
  //handleSerial();
  
  //Draw the interface
  ui.draw();
}

/**
Handles the serial input and neatens it into channels
and nicely parseable data
**/
void handleSerial(){
  //See if there are characters available, if so, read them
  while(serial.available() > 0){
    //Reads a single character
    char c = serial.readChar();
    
    //Through upper/lower case determine channel of receive / send
    if(Character.isUpperCase(c)){
      //Only append non-sil characters
      if(c != SIL_S) {
        sndBuffer.append(Character.toLowerCase(c));
      } else {
        println(parseLetter(sndBuffer.toString()));
        sndBuffer = new StringBuilder();
      }
    }else{
      rcvBuffer.append(c);
    }
  }
}
