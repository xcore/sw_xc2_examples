// Copyright (c) 2011, XMOS Ltd., All rights reserved
// This software is freely distributable under a derivative of the
// University of Illinois/NCSA Open Source License posted in
// LICENSE.txt and at <http://github.xcore.com/>

/*
 ============================================================================
 Name        : $(sourceFile)
 Description : Flashing LED program for the XC-2 board 
 ============================================================================
 */

#include <platform.h>
#define FLASH_PERIOD 20000000

out port x0ledB = PORT_LED_0_1;

int main(void) {
  timer tmr;
  unsigned ledOn = 1;
  unsigned t;
  tmr :> t;
  while (1) {
    x0ledB <: ledOn;
    t += FLASH_PERIOD;
    tmr when timerafter(t) :> void;
    ledOn = !ledOn;
  }
  
  return 0;
}
