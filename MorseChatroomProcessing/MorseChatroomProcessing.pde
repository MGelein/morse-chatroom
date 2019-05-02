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

//List of the letters received so far
ArrayList<String> lettersReceived = new ArrayList<String>();
//List of the letters sent so far
ArrayList<String> lettersSent = new ArrayList<String>();

//The UI class
UI ui;

/**
Called once during setup of the sketch
**/
void setup(){
  //This application is meant to run fullscreen
  fullScreen(P3D);
  //size(640, 480);
  //Loads the morse-code definition file
  loadCode();
  
  //instantiate the UI
  ui = new UI();
  
  //Open the first available serial port at the baud rate that was specified in the arduino
  serial = new Serial(this, Serial.list()[0], 115200);
  //Set frameRate to 30
  frameRate(30);
}

void keyPressed(){
  ui.addMessage("Nog een bericht", random(1) < .5);
}

/**
Runs at the specified framerate. This should be 30fps,
if the computer can keep up.
**/
void draw(){
  //Handle the serial management
  handleSerial();
  
  //Draw the interface
  ui.draw();
  
  //Draw a framerate time to check performance
  //fill(255);
  //textSize(20);
  //textAlign(LEFT);
  //text((int) frameRate + "fps", 20, 30);
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
    print(c);
    
    //Through upper/lower case determine channel of receive / send
    if(Character.isUpperCase(c)){
      //Only append non-sil characters
      if(c != SIL_S) {
        sndBuffer.append(Character.toLowerCase(c));
      } else {
        //Parse the letter into notation
        String letter = parseLetter(sndBuffer.toString());
        if(letter.equals("@")) {
          //Convert all letters to a string
           StringBuilder msg = new StringBuilder();
           for(String l : lettersSent){
             msg.append(l);
           }
           //Add a message from me
           ui.addMessage(msg.toString(), true);
           //And empty the sent letters buffer
           lettersSent.clear();
        }else lettersSent.add(letter);
        sndBuffer = new StringBuilder();
      }
    }else{
      //Only append non-sil characters
      if(c != SIL_R) {
        rcvBuffer.append(Character.toLowerCase(c));
      } else {
        //Parse the letter into notation
        String letter = parseLetter(rcvBuffer.toString());
        if(letter.equals("@")) {
          //Convert all letters to a string
           StringBuilder msg = new StringBuilder();
           for(String l : lettersReceived){
             msg.append(l);
           }
           //Add a message from the other partner
           ui.addMessage(msg.toString(), false);
           //And empty the received letters buffer
           lettersReceived.clear();
        }else lettersReceived.add(letter);
        rcvBuffer = new StringBuilder();
      }
    }
  }
}
