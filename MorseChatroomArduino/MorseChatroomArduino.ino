/**
   Code for the first assignment of the New Media New Technologies course of
   Leiden University Media Technology MSc., taught by Dr. P.W.H. van der Putten.

   This sketch decodes pulses into dits, dahs and special characters used for morse
   communication on a send and a receive line. A buzzer is made to sound as you hear
   the morse code come in. Your own morse sending is not toned, since you can hear
   and feel that quite easily.

   @author  Mees Gelein
   @version 1.2.13
   @license MIT
*/

//Use pin 2 as the pin for the send channel
#define SND_PIN 2
//And pin 4 for the receive channel
#define RCV_PIN 4
//Pin 11 for the buzzer
#define BZR_PIN 11

//The three characters that we can send
const char dit = 'A';
const char dah = 'B';
const char spc = 'C';//This is the special extra character, added for extra convenience
const char sil = 'D';//This is the silence char, used to space out characters
//Amount of transposing between the send and receive channel, this makes the uppercase into lowercase letters
const byte transpose = 32;

//Minimum time it takes for each of the possible events
const int ditTime = 40;
const int dahTime = ditTime * 3;//Traditinally every dah is 3 dits
const int spcTime = dahTime * 3;//Just setting the special to be three dahs
const int silTime = dahTime * 2;

//The starting timestamp of when we pushed the button for sending
unsigned long startPressSnd = 0;
//The starting timestamp of when we released the button
unsigned long startReleaseSnd = 0;
//the starting timestamp of when we received a low from the receive channel
unsigned long startPressRcv = 0;
//The starting timestamp of when the rcv signal went high again
unsigned long startReleaseRcv = 0;
//Amount of time that has passed on this channel
int passed;
//If we have the button down right now
bool pressedSnd = false;
//If we have a high receive signal right now
bool pressedRcv = false;
//The state of the channel we're reading
bool state = false;
//If the silence on the send has been registered
bool silRegSnd = false;
//If the silence on the rcv has been registered
bool silRegRcv = false;
/**
   Runs only once during the booting of the arduino
*/
void setup() {
  //Open a serial connection at the specified baud rate
  Serial.begin(115200);
  //Set the send and receive pins to to input mode
  pinMode(SND_PIN, INPUT_PULLUP);
  pinMode(RCV_PIN, INPUT_PULLUP);
  pinMode(BZR_PIN, OUTPUT);
}

/**
   Runs as fast as possible while the Arduino has power
*/
void loop() {
  /**
     CHECK THE SEND CHANNEL
  */

  //Set the state to see if it is pulled low now
  state = digitalRead(SND_PIN) == LOW;
  //Depending on the state, make a piezo sound
  if (state) {
    tone(11, 1000, 100);
  } else {
    noTone(11);
  }

  //Depending if we registered that press already, do something
  if (!pressedSnd && state) {
    //Yes, we're pressing right now
    pressedSnd = true;
    //Deregister the silence
    silRegSnd = false;
    //Mark the time
    startPressSnd = millis();
  } else if (pressedSnd && !state) {
    //We're not pressing anymore, we just released
    pressedSnd = false;
    //Calculate the time that passed
    passed = millis() - startPressSnd;
    //Set the start of silence timestamp to now
    startReleaseSnd = startPressSnd + passed;

    //Now send the correct char depending on the settings
    if (passed > spcTime) Serial.print(spc);
    else if (passed > dahTime) Serial.print(dah);
    else if (passed > ditTime) Serial.print(dit);
  } else if (!pressedSnd && !state && !silRegSnd) {
    //How long has passed so far
    passed = millis() - startReleaseSnd;
    if (passed > silTime) {
      //Register the silence on the send channel
      silRegSnd = true;
      Serial.print(sil);
    }
  }

  /**
     SAME THING FOR THE RECEIVE
  */

  //Set the state to see if it is pulled low now
  state = digitalRead(RCV_PIN) == LOW;
  

  //Depending if we registered that press already, do something
  if (!pressedRcv && state) {
    //Yes, we're pressing right now
    pressedRcv = true;
    //Deregister sil on this channel
    silRegRcv = false;
    //Mark the time
    startPressRcv = millis();
    //And see if enough silence has passed
  } else if (pressedRcv && !state) {
    //We're not pressing anymore, we just released
    pressedRcv = false;
    //Calculate the time that passed
    passed = millis() - startPressRcv;
    //Set this as the start of a new silence
    startReleaseRcv = passed + startPressRcv;

    //Now send the correct char depending on the settings
    if (passed > spcTime) Serial.print(char(spc + transpose));
    else if (passed > dahTime) Serial.print(char(dah + transpose));
    else if (passed > ditTime) Serial.print(char(dit + transpose));
  } else if (!pressedRcv && !state && !silRegRcv) {
    //How long has passed so far
    passed = millis() - startReleaseRcv;
    if (passed > silTime) {
      //Register the silence on the send channel
      silRegRcv= true;
      Serial.print(char(sil + transpose));
    }
  }
}
