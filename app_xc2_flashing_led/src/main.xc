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
