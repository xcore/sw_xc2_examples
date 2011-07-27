// Copyright (c) 2011, XMOS Ltd., All rights reserved
// This software is freely distributable under a derivative of the
// University of Illinois/NCSA Open Source License posted in
// LICENSE.txt and at <http://github.xcore.com/>

// THIS EXAMPLE IS NOT COMPLETE AND IS INTENDED AS PART OF THE XC-2
// DEVELOPMENT TUTORIAL TO BE FILLED IN BY THE USER

#include <platform.h>
#define FLASH_PERIOD 20000000

on stdcore [0]: out port x0ledA = PORT_LED_0_0;
on stdcore [0]: out port x0ledB = PORT_LED_0_1;
on stdcore [1]: out port x1ledA = PORT_LED_1_0;
on stdcore [1]: out port x1ledB = PORT_LED_1_1;

void flashLED (out port led, int delay);

int main (void) {
  par {
    on stdcore [0]: flashLED (x0ledA, FLASH_PERIOD);
    on stdcore [0]: flashLED (x0ledB, FLASH_PERIOD);
    on stdcore [1]: flashLED (x1ledA, FLASH_PERIOD);
    on stdcore [1]: flashLED (x1ledB, FLASH_PERIOD);
  }
  return 0;
}

void flashLED (out port led, int delay){
// Function stub
}
