//+------------------------------------------------------------------+
//| EuroBotAIPro - CLEAN WORKING EA                                 |
//+------------------------------------------------------------------+
#property strict

#include <Trade/Trade.mqh>
CTrade trade;

// INPUTS
input double RiskPercent = 1.0;
input int EMA_Period = 200;
input int RSI_Period = 14;
input int ATR_Period = 14;
input double SL_Mult = 2.0;
input double TP_Mult = 3.0;

// INDICATOR HANDLES
int emaHandle, rsiHandle, atrHandle;

//+------------------------------------------------------------------+
// INIT
//+------------------------------------------------------------------+
int OnInit()
{
   emaHandle = iMA(_Symbol, PERIOD_H1, EMA_Period, 0, MODE_EMA, PRICE_CLOSE);
   rsiHandle = iRSI(_Symbol, PERIOD_M15, RSI_Period, PRICE_CLOSE);
   atrHandle = iATR(_Symbol, PERIOD_M15, ATR_Period);

   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
// CHECK OPEN POSITIONS
//+------------------------------------------------------------------+
bool HasOpenPosition()
{
   for(int i=0;i<PositionsTotal();i++)
   {
      if(PositionSelect(_Symbol))
         return true;
   }
   return false;
}

//+------------------------------------------------------------------+
// LOT SIZE CALCULATION
//+------------------------------------------------------------------+
double LotSize(double sl_points)
{
   double risk = AccountInfoDouble(ACCOUNT_BALANCE) * RiskPercent / 100.0;
   double tick = SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_VALUE);

   double lot = risk / (sl_points * tick);

   if(lot < 0.01) lot = 0.01;

   return NormalizeDouble(lot,2);
}

//+------------------------------------------------------------------+
// MAIN LOGIC
//+------------------------------------------------------------------+
void OnTick()
{
   double ema[1], rsi[2], atr[1];

   if(CopyBuffer(emaHandle,0,0,1,ema) <= 0) return;
   if(CopyBuffer(rsiHandle,0,0,2,rsi) <= 0) return;
   if(CopyBuffer(atrHandle,0,0,1,atr) <= 0) return;

   double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);

   if(HasOpenPosition())
      return;

   // BUY
   if(bid > ema[0] && rsi[1] < 30 && rsi[0] > 30)
   {
      double sl = ask - (atr[0] * SL_Mult);
      double tp = ask + (atr[0] * TP_Mult);

      double lot = LotSize((ask - sl)/_Point);

      trade.Buy(lot,_Symbol,ask,sl,tp,"BUY");
   }

   // SELL
   if(bid < ema[0] && rsi[1] > 70 && rsi[0] < 70)
   {
      double sl = bid + (atr[0] * SL_Mult);
      double tp = bid - (atr[0] * TP_Mult);

      double lot = LotSize((sl - bid)/_Point);

      trade.Sell(lot,_Symbol,bid,sl,tp,"SELL");
   }
}
