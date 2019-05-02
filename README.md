# Morse Chatroom
First assignment for New Media New Technology for Media Technology MSc. Leiden University. For this assignment we had to create a tribute to an old media. I chose morse-code.

## Hardware
For more details on the hardware part I would refer you to the Google Docs linked below, where you will find a complete photo guide to the build process, as well as a listing of all hardware used:
[https://docs.google.com/document/d/1eFtztgqGNMNuNDx0uWHcViv8JXedwDEUmw8lF266IVQ/edit?usp=sharing](https://docs.google.com/document/d/1eFtztgqGNMNuNDx0uWHcViv8JXedwDEUmw8lF266IVQ/edit?usp=sharing)

## Software
All the software used for this project can be found in this Github repository. The software consists of two major parts, the Arduino code and the Processing sketch.

### Arduino
The Arduino part of the project runs on two Arduino Nano's. Each handles the input received from its own telegraph key as well as the echoed input of the other telegraph key. This input is then transcoded into dits and dahs depending on the time the key was pressed. After this translation step the input is sent over the Serial monitor to the receiving party.

### Processing
The Processing sketch handles the serial input that is received from the Arduino and displays it in a mockup of a modern messenger/chatroom. The decoding step from dits and dahs to letters is also done in Processing, as String manipulation is 100x easier in Java when compared to C.

### Disclaimer
Most of the artwork in this repository has been made/heavily modified by me, however if you find something that violates your copyright, please don't hesitate to file an issue.
