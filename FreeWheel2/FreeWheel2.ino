#include <Time.h>


int wheel = 2;
double values[12] = {0,0,0,0,0,0,0,0,0,0,0,0};
int count=0;
unsigned long oldtime;
unsigned long time;
float delta;
float vel;
float averageVel;
const double conversion = 0.017674*3.6*2;
boolean initialized = false;
String integer;
String fraction;
String decimalPoint = String('.');

// the setup routine runs once when you press reset:
void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
  Serial.flush();
  // make the pushbutton's pin an input:
  pinMode(wheel, INPUT);
  attachInterrupt(0,getSpeed,RISING);
  
  oldtime = millis();
  
}

// the loop routine runs over and over again forever:
void loop() {
  averageVel=average(values);
  String integer = String(int(averageVel));
  String fraction = String(int((averageVel -int(averageVel))*1000));

  Serial.println(integer + decimalPoint + fraction);
  delay(500);   
  
       
}

void getSpeed(){
  
  if (!initialized){
    oldtime = millis();
    initialized =true;
  }
 
  else{
  time = millis();
  delta = time - oldtime;
  
  oldtime = time;
  vel = conversion/delta;
  values[count] = vel;
  count = count + 1;
  count = count%12;
  }
  
}

double average(double array[]){
  double total= 0;
  for (int i = 0; i< 12; i++){
    total = array[i] + total;
  }
  return total/12.0;
}


void printDouble( double val, unsigned int precision){
// prints val with number of decimal places determine by precision
// NOTE: precision is 1 followed by the number of zeros for the desired number of decimial places
// example: printDouble( 3.1415, 100); // prints 3.14 (two decimal places)

    Serial.print (int(val));  //prints the int part
    Serial.print("."); // print the decimal point
    unsigned int frac;
    if(val >= 0)
        frac = (val - int(val)) * precision;
    else
        frac = (int(val)- val ) * precision;
    Serial.println(frac,DEC) ;
} 
