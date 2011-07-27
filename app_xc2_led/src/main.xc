// Copyright (c) 2011, XMOS Ltd., All rights reserved
// This software is freely distributable under a derivative of the
// University of Illinois/NCSA Open Source License posted in
// LICENSE.txt and at <http://github.xcore.com/>

/*
 ============================================================================
 Name        : $(sourceFile)
 Description : Illuminate a LED on the XC-2 card 
 ============================================================================
 */

#include <platform.h>

out port x0ledB = PORT_LED_0_1;

int main() {
  x0ledB <: 1;
  while(1)
    ;
  return 0;
}
