//+------------------------------------------------------------------+
//| EuroBotAIPro.mq5                                                 |
//+------------------------------------------------------------------+
#property strict
#property version "1.00"

#include "../Include/TradeEngine.mqh"
#include "../Include/RiskManager.mqh"
#include "../Include/Indicators.mqh"
#include "../Include/SmartMoney.mqh"
#include "../Include/Dashboard.mqh"
#include "../Include/Telegram.mqh"
#include "../Include/NewsFilter.mqh"

int OnInit()
{
   Print("EuroBotAI Pro Started");
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{
   Comment("");
}

void OnTick()
{
   DrawDashboard();

   if(IsNewsTime())
      return;

   // Trading logic will be added later
}
