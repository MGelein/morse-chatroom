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
    tint(255);
    //Draw the background image over any other parts
    image(bg, 0, 0);
    //Draw the contact list
    drawContacts();
    //Now draw the vertical divider
    tint(200);
    image(v_div, 0, 0);
  }



  /**
   Draws all the contacts
   **/
  void drawContacts() {
    //start a y-pos
    float y = 140;
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
}
