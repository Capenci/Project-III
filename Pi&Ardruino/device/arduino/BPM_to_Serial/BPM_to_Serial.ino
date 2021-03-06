#include "DHT.h"            
const int DHTPIN = 4;      
const int DHTTYPE = DHT11;  
 
DHT dht(DHTPIN, DHTTYPE);

#define USE_ARDUINO_INTERRUPTS true
#include <PulseSensorPlayground.h>

#include <OneWire.h> 

/*
   The format of our output.

   Set this to PROCESSING_VISUALIZER if you're going to run
    the Processing Visualizer Sketch.
    See https://github.com/WorldFamousElectronics/PulseSensor_Amped_Processing_Visualizer

   Set this to SERIAL_PLOTTER if you're going to run
    the Arduino IDE's Serial Plotter.
*/
 const int OUTPUT_TYPE = SERIAL_PLOTTER;
const int PULSE_INPUT = A0;
const int PULSE_BLINK = 13;    // Pin 13 is the on-board LED
const int PULSE_FADE = 5;
const int THRESHOLD = 550;   // Adjust this number to avoid noise when idle

//one wire setup
int DS18S20_Pin = 10; //DS18S20 Signal pin on digital 2
char tmpstring[10];
OneWire ds(DS18S20_Pin);

/*
   All the PulseSensor Playground functions.
*/
PulseSensorPlayground pulseSensor;

void setup() {
  /*
     Use 115200 baud because that's what the Processing Sketch expects to read,
     and because that speed provides about 11 bytes per millisecond.

     If we used a slower baud rate, we'd likely write bytes faster than
     they can be transmitted, which would mess up the timing
     of readSensor() calls, which would make the pulse measurement
     not work properly.
  */
  Serial.begin(115200);
    dht.begin();       


  //turn on pin to power sensor
  pinMode(12, OUTPUT);

  // Configure the PulseSensor manager.

  pulseSensor.analogInput(PULSE_INPUT);
  pulseSensor.blinkOnPulse(PULSE_BLINK);
  pulseSensor.fadeOnPulse(PULSE_FADE);

  pulseSensor.setSerial(Serial);
  pulseSensor.setOutputType(OUTPUT_TYPE);
  pulseSensor.setThreshold(THRESHOLD);

  // Now that everything is ready, start reading the PulseSensor signal.
  if (!pulseSensor.begin()) {
    /*
       PulseSensor initialization failed,
       likely because our particular Arduino platform interrupts
       aren't supported yet.

       If your Sketch hangs here, try ProcessEverySample.ino,
       which doesn't use interrupts.
    */
    for(;;) {
      // Flash the led to show things didn't work.
      digitalWrite(PULSE_BLINK, LOW);
      delay(50);
      digitalWrite(PULSE_BLINK, HIGH);
      delay(50);
    }
  }


}

void loop() {
  /*
     Wait a bit.
     We don't output every sample, because our baud rate
     won't support that much I/O.
  */
  delay(100);

  // write the latest sample to Serial.
// pulseSensor.outputSample();

  /*
     If a beat has happened since we last checked,
     write the per-beat information to Serial.
   */
//  Serial.print("saw start? ");
// Serial.println(pulseSensor.sawStartOfBeat());
 // if (pulseSensor.sawStartOfBeat()) {
  // pulseSensor.outputBeat();
 // }
// Serial.print("is inside? "); 
// Serial.println(pulseSensor.isInsideBeat());

  //temp
  float temperature = dht.readTemperature();
  //int tmp = (int) temperature;
  Serial.print(temperature);
  Serial.print(",");
  
 //temp
 int bpm = pulseSensor.getBeatsPerMinute();
 Serial.println(bpm);
 
 if(bpm > 120){
    digitalWrite(12, HIGH);
 } else{
    digitalWrite(12, LOW);
 }
}
