//+------------------------------------------------------------------+
//| Indicators.mqh                                                   |
//+------------------------------------------------------------------+
#ifndef __INDICATORS_MQH__
#define __INDICATORS_MQH__

input int EMA_Period = 200;
input int RSI_Period = 14;
input int ATR_Period = 14;

double GetEMA()
{
   return iMA(_Symbol, PERIOD_H1, EMA_Period, 0, MODE_EMA, PRICE_CLOSE);
}

double GetRSI()
{
   return iRSI(_Symbol, PERIOD_M15, RSI_Period, PRICE_CLOSE);
}

double GetATR()
{
   return iATR(_Symbol, PERIOD_M15, ATR_Period);
}

#endif
