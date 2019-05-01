/**
 A single message in this conversation
 **/
class Message {

  //The color of this message
  color bgColor;
  //Who has sent this message
  boolean fromMe = false;
  //The content of the message
  String[] content;
  //The amount of lines necessary to fit this line
  int length = 1;

  Message(String msg, boolean fromMe) {
    content = parseContent(msg);
    length = content.length;
    //Depending on who sent the message, please set the bg color
    if (fromMe) {
      bgColor = color(186, 155, 35);//Light yellowish
    } else {
      bgColor = color(219, 108, 35);//More copperish
    }
    //Set who setn this message
    this.fromMe = fromMe;
  }

  /**
   Parse the provided mesage into a array of lines
   that is rendered
   **/
  String[] parseContent(String message) {
    String result = "";
    String l = "";
    String[] words = message.split(" ");
    int i = 0;
    textSize(32);
    //Keep going untill all words are done
    while (i < words.length) {
      //Make a full line
      while (textWidth(l) < 580) {
        l += words[i] + " ";
        i++;
        if(i >= words.length) break;
      }
      result += l.trim() + "\n";
      l = "";
    }
    return result.split("\n");
  }

  /**
   How much space is needed vertically for this bubble
   **/
  float getHeight() {
    return (38 * length) + 22;
  }

  /**
   Draw this message to the screen
   **/
  void draw() {
    translate(fromMe ? 640 : 0, 0);
    noStroke();
    //Set the fillColor to the bg color
    fill(0, 120);
    rect(0, 0, 610, getHeight() + 10, 20);
    fill(180);
    rect(-4, -4, 610, getHeight() + 10, 20);
    fill(0, 120);
    rect(3, 3, 600, getHeight(), 20);
    fill(bgColor);
    rect(0, 0, 600, getHeight(), 20);
    //Now write the text
    fill(0);
    textSize(32);
    textAlign(fromMe ? RIGHT : LEFT);
    float yPos = 38;
    for (String l : content) {
      text(l, fromMe ? 580 : 20, yPos);
      yPos += 38;
    }
  }
}
