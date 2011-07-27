// Copyright (c) 2011, XMOS Ltd., All rights reserved
// This software is freely distributable under a derivative of the
// University of Illinois/NCSA Open Source License posted in
// LICENSE.txt and at <http://github.xcore.com/>

/*
 ============================================================================
 Name        : $(sourceFile)
 Description : Multicore sequential flashing LED program for the XC-2 board using tokens 
 ============================================================================
 */

#include <platform.h>

#define PERIOD 20000000

on stdcore [0]: port x0btn1 = PORT_BUTTON_B;
on stdcore [0]: out port x0ledA = PORT_LED_0_0;
on stdcore [0]: out port x0ledB = PORT_LED_0_1;
on stdcore [1]: out port x1ledA = PORT_LED_1_0;
on stdcore [1]: out port x1ledB = PORT_LED_1_1;
on stdcore [2]: out port x2ledA = PORT_LED_2_0;
on stdcore [2]: out port x2ledB = PORT_LED_2_1;
on stdcore [3]: out port x3ledA = PORT_LED_3_0;
on stdcore [3]: out port x3ledB = PORT_LED_3_1;

void tokenFlash(chanend left, chanend right, out port led, int delay, int isMaster);
void buttonListener(chanend left, chanend right, port button);

int main(void) {
  chan c0, c1, c2, c3, c4, c5, c6, c7, c8;
  par {  
	on stdcore [0]: buttonListener(c8, c0, x0btn1);
    on stdcore [0]: tokenFlash (c0, c1, x0ledB, PERIOD, 1);
    on stdcore [0]: tokenFlash (c1, c2, x0ledA, PERIOD, 0);
    on stdcore [1]: tokenFlash (c2, c3, x1ledB, PERIOD, 0);
    on stdcore [1]: tokenFlash (c3, c4, x1ledA, PERIOD, 0);
    on stdcore [2]: tokenFlash (c4, c5, x2ledB, PERIOD, 0);
    on stdcore [2]: tokenFlash (c5, c6, x2ledA, PERIOD, 0);
    on stdcore [3]: tokenFlash (c6, c7, x3ledA, PERIOD, 0);
    on stdcore [3]: tokenFlash (c7, c8, x3ledB, PERIOD, 0);
  }
  return 0;
}

void tokenFlash(chanend left, chanend right, out port led, int delay, int isMaster){
  timer tmr;
  unsigned t;
  
  /* master inserts token into ring */
  if (isMaster)     
    right <: 1;
    
  while (1) {
    int token;
    
    /* input token from left neighbour */
    left :> token;	
    led <: 1;
    tmr :> t;
    tmr when timerafter(t + delay) :> void;
    
    /* output token to right neigbour */
    led <: 0;
    right <: token; 
  }
}

void buttonListener(chanend left, chanend right, port button) {
  int token;
  while (1){
    select {
      case left :> token:
        /* pass token on */
        right <: token;
        break;
      case button when pinsneq(0xf) :> void:
        /* wait for token, then hold until button is pressed */
        left :> token;
        
        /* push down */
        button when pinsneq(0xf) :> void;
        
        /* release */ 
        button when pinseq(0xf) :> void;  
        right <: token;
        break;
    }
  }
}

