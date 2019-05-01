/**
The UI class, this is used as a singleton
**/
class UI{
  
  //This image contains the background of the screen
  PImage bg;
  
  /**
  Constructor loads any necessary elements for the screen display
  **/
  UI(){
    //Load the wallpaper image
    bg = loadImage("wall.jpg");
  }
  
  /**
  Draws the UI, this is used for
  the rendering of all visible 
  components
  **/
  void draw(){
    //Draw the background image over any other parts
    image(bg, 0, 0);
  }
}
