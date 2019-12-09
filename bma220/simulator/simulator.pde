import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;

Serial myPort;
String data="";
float roll, pitch;
int interval=0;

void setup() {
  size (960, 640, P3D);
  String portName = Serial.list()[0];
  // open the serial port
  myPort = new Serial(this, portName, 115200);
  myPort.bufferUntil('\n');
}

void draw() {
  if (millis() - interval > 1000) {
        // resend single character to trigger DMP init/start
        // in case the MPU is halted/reset while applet is running
        myPort.write('r');
        interval = millis();
    }
    
  translate(width/2, height/2, 0);
  background(33);
  textSize(22);
  
  text("Roll: " + int(roll) + "     Pitch: " + int(pitch), -100, 265);
  // Rotate the object
  rotateX(radians(roll));
  rotateZ(radians(-pitch));
  
  // 3D 0bject
  textSize(30);  
  fill(0, 255, 220);
  box (386, 40, 200); // Draw box
  textSize(25);
  fill(255, 255, 255);
  text("", -183, 10, 101);
  //delay(10);
  //println("ypr:\t" + angleX + "\t" + angleY); // Print the values to check whether we are getting proper values
}


// Read data from the Serial Port
void serialEvent (Serial myPort) { 
  // reads the data from the Serial Port up to the character '.' and puts it into the String variable "data".
  data = myPort.readStringUntil('\n');
  // if you got any bytes other than the linefeed:
  if (data != null) {
    data = trim(data);
    // split the string at "/"
    String items[] = split(data, '/');
    if (items.length > 1) {
      //--- Roll,Pitch in degrees
      roll = float(items[0]);
      pitch = float(items[1]);
    }
  }
}
