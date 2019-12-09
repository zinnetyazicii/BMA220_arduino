#include <bma220.h>

BMA220 Sensor;
void setup() {
    Serial.begin(115200);
    if (!Sensor.begin()) {
        Serial.println(F("No valid BMA220 sensor found, check wiring"));
        while (true)  // stop here, no reason to go on...
            ;
    }
    // Set sensor sensitivity to 4g
    Sensor.setRegister(SENSITIVITY_REG, SENS_2g);
}

void loop() {
    Sensor.readAcceleration(64);
    Serial.print("x-axis: ");
    Serial.println(Sensor.getAcceleration_X());
    Serial.print("y-axis: ");
    Serial.println(Sensor.getAcceleration_Y());
    Serial.print("z-axis: ");
    Serial.println(Sensor.getAcceleration_Z());

    Serial.print("rho: ");
    Serial.println(Sensor.getPitch());

    Serial.print("phi: ");
    Serial.println(Sensor.getRoll());

    Serial.print("theta: ");
    Serial.println(Sensor.getTheta());

    Serial.print("Mag: ");
    Serial.println(Sensor.getMag());

    Sensor.FallDetection();
    
//    Serial.print(Sensor.getRoll());
//    Serial.print("/");
//    Serial.println(Sensor.getPitch());
    delay(1000);
}