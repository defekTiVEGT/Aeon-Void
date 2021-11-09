int startButton = 13;
int bombButton = 12;
int dpadUp = 7;
int dpadRight = 6;
int dpadLeft = 5;
int dpadDown = 4;
int life1 = 11;
int life2 = 10;
int life3 = 9;
int PRESSED = LOW;
int Byte;
int laser = 8;


void setup()
{
  pinMode(startButton, INPUT_PULLUP);
  pinMode(bombButton, INPUT_PULLUP);
  pinMode(life1, OUTPUT);
  pinMode(life2, OUTPUT);
  pinMode(life3, OUTPUT);
  pinMode(laser, OUTPUT);
  
  Serial.begin(9600);
}

void loop()
{
  buttons();
  dpad();
  lives();
  Serial.print("\n");
}

void buttons()
{
  if(digitalRead(startButton) == PRESSED)
  {
    Serial.print("1");
  }
  else
  {
    Serial.print("0");
  }
  Serial.print(",");
  
  if(digitalRead(bombButton) == PRESSED)
  {
    Serial.print("1");
  }
  else
  {
    Serial.print("0");
  }
  Serial.print(",");
}

void dpad()
{
  if(capacitiveRead(dpadUp) > 5)
  {
    Serial.print("1");
  }
  else
  {
    Serial.print("0");
  }
  Serial.print(",");
  
  if(capacitiveRead(dpadDown) > 5)
  {
    Serial.print("1");
  }
  else
  {
    Serial.print("0");
  }
  Serial.print(",");
  
  if(capacitiveRead(dpadLeft) > 5)
  {
    Serial.print("1");
  }
  else
  {
    Serial.print("0");
  }
  Serial.print(",");
  
  if(capacitiveRead(dpadRight) > 5)
  {
    Serial.print("1");
  }
  else
  {
    Serial.print("0");
  }
}

void lives()
{
  if(Serial.available() > 0 )
  {
    Byte = Serial.read();
    if(Byte == 'A')
    {
      digitalWrite(life1, HIGH);
    }
    else if(Byte == 'a')
    {
      digitalWrite(life1, LOW);
    }
  }
  
  if(Serial.available() > 0 )
  {
    Byte = Serial.read();
    if(Byte == 'B')
    {
      digitalWrite(life2, HIGH);
    }
    else if(Byte == 'b')
    {
      digitalWrite(life2, LOW);
    }
  }
  
  if(Serial.available() > 0 )
  {
    Byte = Serial.read();
    if(Byte == 'C')
    {
      digitalWrite(life3, HIGH);
    }
    else if(Byte == 'c')
    {
      digitalWrite(life3, LOW);
    }
  }
  if(Serial.available() > 0 )
  {
    Byte = Serial.read();
    if(Byte == 'L')
    {
      digitalWrite(laser, LOW);
    }
    else if(Byte == 'l')
    {
      digitalWrite(laser, HIGH);
    }
  }
  
}

////////////////////////////////////////////////////////////////////////////////////////////////
/*!
 @author  Brian Tugade
 @brief   The function used to read a capacitive pin
 @details Serves as a capacative button read function
 @return  uint8_t -  A number between 1 and 17 that corresponds to the capacitive pin being touched
 @param   pinToMeasure - The pin that you are going to read from
 */
////////////////////////////////////////////////////////////////////////////////////////////////
uint8_t capacitiveRead(int pinToMeasure)
{
  // Variables used to translate from Arduino to AVR pin naming
  volatile uint8_t* port;
  volatile uint8_t* ddr;
  volatile uint8_t* pin;
  // Here we translate the input pin number from Arduino pin number to the AVR PORT, PIN, DDR, 
  // and which bit of those registers we care about.
  byte bitmask;
  port    = portOutputRegister(digitalPinToPort(pinToMeasure));
  ddr     = portModeRegister(digitalPinToPort(pinToMeasure));
  bitmask = digitalPinToBitMask(pinToMeasure);
  pin     = portInputRegister(digitalPinToPort(pinToMeasure));
  // Discharge the pin first by setting it low and output
  *port &= ~(bitmask);
  *ddr  |= bitmask;
  delay(1);
  // Make the pin an input with the internal pull-up on
  *ddr  &= ~(bitmask);
  *port |= bitmask;
  // Now see how long the pin to get pulled up. This manual unrolling of the loop decreases the number 
  // of hardware cycles between each read of the pin, thus increasing sensitivity.
  uint8_t cycles = 17;
       if (*pin & bitmask) { cycles =  0; }
  else if (*pin & bitmask) { cycles =  1; }
  else if (*pin & bitmask) { cycles =  2; }
  else if (*pin & bitmask) { cycles =  3; }
  else if (*pin & bitmask) { cycles =  4; }
  else if (*pin & bitmask) { cycles =  5; }
  else if (*pin & bitmask) { cycles =  6; }
  else if (*pin & bitmask) { cycles =  7; }
  else if (*pin & bitmask) { cycles =  8; }
  else if (*pin & bitmask) { cycles =  9; }
  else if (*pin & bitmask) { cycles = 10; }
  else if (*pin & bitmask) { cycles = 11; }
  else if (*pin & bitmask) { cycles = 12; }
  else if (*pin & bitmask) { cycles = 13; }
  else if (*pin & bitmask) { cycles = 14; }
  else if (*pin & bitmask) { cycles = 15; }
  else if (*pin & bitmask) { cycles = 16; }
  // Discharge the pin again by setting it low and output. It's important to leave the pins low if you want to 
  // be able to touch more than 1 sensor at a time - if the sensor is left pulled high, when you touch two 
  // sensors, your body will transfer the charge between sensors.
  *port &= ~(bitmask);
  *ddr  |= bitmask;
  return cycles;
}
