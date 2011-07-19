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
