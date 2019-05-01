//The send characters
final char DIT_S = 'A'; 
final char DAH_S = 'B';
final char SPC_S = 'C';
final char SIL_S = 'D';
//The receive characters
final char DIT_R = Character.toLowerCase(DIT_S);
final char DAH_R = Character.toLowerCase(DAH_S);
final char SPC_R = Character.toLowerCase(SPC_S);
final char SIL_R = Character.toLowerCase(SIL_S);

//Define the lookup table that will contain the code lookup for the morse
HashMap<String, String> lookup = new HashMap<String, String>();

/**
Parses the provided 'morse-code' string into
its matching real string
**/
String parseLetter(String code){
  //Empty string for empty code
  if(code.trim().length() < 1) return "";
  //Else, lets see if it is found in the lookup
  if(lookup.containsKey(code)){
    //Return the stored value
    return lookup.get(code);
  }else{
    //Log the error in parsing
    println("Could not parse code: " + code);
    //If we don't understand, return a question mark
    return "?";
  }
}

/**
Loads the definition of the code from the disk
**/
void loadCode(){
  //Load the lines from the file
  String[] lines = loadStrings("code.txt");
  //Go through every line
  for(String line : lines){
    //Split on the tab between the two columns
    String[] parts = line.split("\t");
    //Put it into the lookup table
    String k = parts[0];
    String v = parseNotation(parts[1]);
    //Put the values swapped in the hashtable
    lookup.put(v, k);
  }
}

/**
Parses the notation of the code
**/
String parseNotation(String notation){
  //The resulting end string will be in here
  StringBuilder b = new StringBuilder();
  for(char c : notation.toCharArray()){
    if(c == '.') b.append(DIT_R);
    else if(c == '-') b.append(DAH_R);
    else if(c == '*') b.append(SPC_R);
  }
  //Return that end string
  return b.toString();
}
