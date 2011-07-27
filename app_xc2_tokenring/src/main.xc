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

on stdcore [0]: out port x0ledA = PORT_LED_0_0;
on stdcore [0]: out port x0ledB = PORT_LED_0_1;
on stdcore [1]: out port x1ledA = PORT_LED_1_0;
on stdcore [1]: out port x1ledB = PORT_LED_1_1;

void tokenFlash(chanend left, chanend right, out port led, int delay, int isMaster);

int main(void) {
  chan c0, c1, c2, c3;
  par {
	on stdcore [0]: tokenFlash (c0, c1, x0ledB, PERIOD, 1);
    on stdcore [0]: tokenFlash (c1, c0, x0ledA, PERIOD, 0);
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
    tmr when timerafter (t + delay) :> void;
    led <: 0;
    
    /* output token to right neigbour */
    right <: token; 
  }
}

