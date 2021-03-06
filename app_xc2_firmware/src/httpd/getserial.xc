// Copyright (c) 2011, XMOS Ltd, All rights reserved
// This software is freely distributable under a derivative of the
// University of Illinois/NCSA Open Source License posted in
// LICENSE.txt and at <http://github.xcore.com/>

#include <xs1.h>
#include <print.h>
#include <platform.h>
#define OTP_DATA_PORT XS1_PORT_32B
#define OTP_ADDR_PORT XS1_PORT_16C
#define OTP_CTRL_PORT XS1_PORT_16D

#define OTPADDRESS 0x7FF
#define OTPREAD 1
#define OTP_tACC_TICKS 4 // 40nS

on stdcore[1]: port otp_data3 = OTP_DATA_PORT;
on stdcore[1]: out port otp_addr3 = OTP_ADDR_PORT;
on stdcore[1]: port otp_ctrl3 = OTP_CTRL_PORT;

int otpRead(unsigned address)
{
  unsigned value;
  timer t;
  int now;
  
  otp_ctrl3 <: 0;
  otp_addr3 <: 0;
  otp_addr3 <: address;
  sync(otp_addr3);
  otp_ctrl3 <: OTPREAD;
  sync(otp_addr3);
   t :> now;
   t when timerafter(now + OTP_tACC_TICKS) :> now;
  otp_data3 :> value;
  otp_ctrl3 <: 0;

  return value;
}

int getSerialNum(unsigned int &serialNum)
{
  unsigned address = OTPADDRESS;
  unsigned bitmap;
  int validbitmapfound = 0;
  int numMac;
  while (!validbitmapfound)
    {      
      bitmap = otpRead(address);
      if (bitmap >> 31)
        {
          // Bitmap has not been written
          return 1;
        }
      else if (bitmap >> 30)
        {
          validbitmapfound = 1;
        }
      else
        {
          // Invalid bitmap
          address -= (bitmap >> 25) & 0x1F;
        }
    }
  
  numMac = ((bitmap >> 22) & 0x7);
  
  address -= ((numMac) << 1) + 1;
  
  serialNum = otpRead(address);
  return 0;
}
