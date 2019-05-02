/**
 The UI class, this is used as a singleton
 **/
class UI {

  //List with names of contacts
  String[] contacts = new String[]{"Napoleon\nBonaparte", "James\nBond", "Aretha\nFranklin", "Marie\nCurie", "Samuel\nMorse"};

  //This image contains the background of the screen
  PImage bg;
  //A single nameplate contact
  PImage contact;
  //The vertical divider
  PImage v_div;
  //The typewriter font
  PFont typewriter;
  
  //List with all the messages that have been sent back and forth
  ArrayList<Message> messages = new ArrayList<Message>();

  /**
   Constructor loads any necessary elements for the screen display
   **/
  UI() {
    //Load the wallpaper   image
    bg = loadImage("wall.jpg");
    //Load the vertical divider
    v_div = loadImage("divider.png");
    //Load the nameplate for the contacts
    contact = loadImage("contact.png");
    //Load the main typewriter font, and set it as active, and set center alignment
    typewriter = createFont("TravelingTypewriter.otf", 64);
    textFont(typewriter);
    textAlign(CENTER);
  }

  /**
   Draws the UI, this is used for
   the rendering of all visible 
   components
   **/
  void draw() {
    //Draw the background image over any other parts
    image(bg, 0, 0);
    //Draw the contact list
    drawContacts();
    //Draw the messages
    drawMessages();
    //Draw the current typing buffer
    drawTypeBuffer();
    //Now draw the vertical divider
    image(v_div, 0, 0);
  }
  
  /**
  Draws all the letters we've type so far
  **/
  void drawTypeBuffer(){
    //Turn it into a builder then into a single String
    StringBuilder bldr = new StringBuilder();
    for(String l : lettersSent) bldr.append(l);
    String msg = bldr.toString();
    //Draw that string into the typing area
    textSize(48);
    textAlign(LEFT);
    fill(0);
    text(msg, 700, 1000);
    fill(255);
    text(msg, 702, 1002);
  }
  
  /**
  Renders all messages
  **/
  void drawMessages(){
    pushMatrix();
    //Translate to the message area
    translate(640, 800);
    float yPos = 800;
    //And render all messages
    for(Message m: messages){
      pushMatrix();
      m.draw();
      popMatrix();
      float h = - (m.getHeight() + 20);
      yPos -= h;
      translate(0, h);
      //If we go more than a hundred pixels out of screen, don't draw it
      if(yPos < -100) break;
    }
    popMatrix();
  }

  /**
   Draws all the contacts
   **/
  void drawContacts() {
    //start a y-pos
    float y = 140;
    textSize(64);
    textAlign(CENTER);
    for (String name : contacts) {
      //Background for this contact
      image(contact, 50, y);
      //First draw the darkness
      fill(0, 120);
      text(name, 250, y + 80);
      //then the lighthness
      fill(255, 70);
      text(name, 253, y + 83);
      y += 187;
    }
    fill(0, 200);
    text("Contacts", 250, 65);
    fill(255, 20);
    text("Contacts", 253, 68);
  }
  
  /**
  Adds a message to the ui
  **/
  void addMessage(String msg, boolean fromMe){
    //Ignore empty messages
    if(msg.trim().length() < 1) return;
    //If not empty, add this message to the thingy
    messages.add(0, new Message(msg, fromMe));
  }
}
