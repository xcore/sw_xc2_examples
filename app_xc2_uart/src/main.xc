/*
 ============================================================================
 Name        : $(sourceFile)
 Description : UART code for the XC-2 board 
 ============================================================================
 */

#include <platform.h>

#define BIT_RATE 115200
#define BIT_TIME XS1_TIMER_HZ / BIT_RATE

void txByte(out port TXD, int byte);

out port TXD = PORT_UART_TX;

int main() {
  return 0;
}

void txByte(out port TXD, int byte) {
  unsigned time;
  timer t;

  /* get initial time */
  t :> time;
   
  /* output start bit */
  TXD <: 0;
  time += BIT_TIME;
  t when timerafter(time) :> void;
		
  /* output data bits */
  for (int i=0; i<8; i++) {
    TXD <: >> byte;
    time += BIT_TIME;
    t when timerafter(time) :> void;
  }

  /* output stop bit */
  TXD <: 1;
  time += BIT_TIME;
  t when timerafter(time) :> void;
}
