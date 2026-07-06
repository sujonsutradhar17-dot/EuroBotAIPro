////+------------------------------------------------------------------+
//| EuroBotAIPro - FAST VERSION (WORKING CORE EA)                   |
//+------------------------------------------------------------------+
#property strict
bool hasTrade = false;

#include <Trade/Trade.mqh>
CTrade trade;

// Inputs
input double RiskPercent = 1.0;
input int EMA_Period = 200;
input int RSI_Period = 14;
input int ATR_Period = 14;
input double SL_Mult = 2.0;
input double TP_Mult = 3.0;
input int Magic = 2026;

// Indicator handles
int emaHandle, rsiHandle, atrHandle;

// Init
int OnInit()
{
   emaHandle = iMA(_Symbol, PERIOD_H1, EMA_Period, 0, MODE_EMA, PRICE_CLOSE);
   rsiHandle = iRSI(_Symbol, PERIOD_M15, RSI_Period, PRICE_CLOSE);
   atrHandle = iATR(_Symbol, PERIOD_M15, ATR_Period);

   return(INIT_SUCCEEDED);
}

// Lot calculation
double LotSize(double sl_points)
{
   double risk = AccountInfoDouble(ACCOUNT_BALANCE) * RiskPercent / 100;
   double tick = SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_VALUE);
   double lot = risk / (sl_points * tick);

   if(lot < 0.01) lot = 0.01;
   return NormalizeDouble(lot,2);
}
// FUNCTIONS
bool HasOpenPosition()
{
   for(int i=0;i<PositionsTotal();i++)
   {
      if(PositionGetSymbol(i)==_Symbol)
         return true;
   }
   return false;
}
void OnTick()
{
...
}
   double ema[1], rsi[2], atr[1];

   CopyBuffer(emaHandle,0,0,1,ema);
   CopyBuffer(rsiHandle,0,0,2,rsi);
   CopyBuffer(atrHandle,0,0,1,atr);

   double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);

   // BUY CONDITION
   if(bid > ema[0] && rsi[1] < 30 && rsi[0] > 30)
   {
      double sl = ask - (atr[0] * SL_Mult);
      double tp = ask + (atr[0] * TP_Mult);

      double lot = LotSize((ask - sl)/_Point);

      trade.Buy(lot,_Symbol,ask,sl,tp,"BUY");
   }

   // SELL CONDITION
   if(bid < ema[0] && rsi[1] > 70 && rsi[0] < 70)
   {
      double sl = bid + (atr[0] * SL_Mult);
      double tp = bid - (atr[0] * TP_Mult);

      double lot = LotSize((sl - bid)/_Point);

      trade.Sell(lot,_Symbol,bid,sl,tp,"SELL");
   }
}
