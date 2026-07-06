//+------------------------------------------------------------------+
//| TradeEngine.mqh                                                  |
//+------------------------------------------------------------------+
#ifndef __TRADEENGINE_MQH__
#define __TRADEENGINE_MQH__

#include <Trade/Trade.mqh>

CTrade trade;

bool BuyTrade(double lot,double sl,double tp)
{
   return trade.Buy(lot,_Symbol,0,sl,tp,"EuroBotAI Buy");
}

bool SellTrade(double lot,double sl,double tp)
{
   return trade.Sell(lot,_Symbol,0,sl,tp,"EuroBotAI Sell");
}

#endif
