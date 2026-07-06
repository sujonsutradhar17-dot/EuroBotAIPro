//+------------------------------------------------------------------+
//| SmartMoney.mqh                                                   |
//+------------------------------------------------------------------+
#ifndef __SMARTMONEY_MQH__
#define __SMARTMONEY_MQH__

// Break of Structure (Basic Version)
bool BullishBOS()
{
   return (iClose(_Symbol, PERIOD_M15, 0) >
           iHigh(_Symbol, PERIOD_M15, 1));
}

bool BearishBOS()
{
   return (iClose(_Symbol, PERIOD_M15, 0) <
           iLow(_Symbol, PERIOD_M15, 1));
}

// Fair Value Gap (Basic Version)
bool BullishFVG()
{
   return (iLow(_Symbol, PERIOD_M15, 0) >
           iHigh(_Symbol, PERIOD_M15, 2));
}

bool BearishFVG()
{
   return (iHigh(_Symbol, PERIOD_M15, 0) <
           iLow(_Symbol, PERIOD_M15, 2));
}

#endif
