//+------------------------------------------------------------------+
//| Dashboard.mqh                                                    |
//+------------------------------------------------------------------+
#ifndef __DASHBOARD_MQH__
#define __DASHBOARD_MQH__

void DrawDashboard()
{
   string text;

   text = "========================\n";
   text += "   EURO BOT AI PRO\n";
   text += "========================\n";
   text += "Symbol : " + _Symbol + "\n";
   text += "Balance: " + DoubleToString(AccountInfoDouble(ACCOUNT_BALANCE),2) + "\n";
   text += "Equity : " + DoubleToString(AccountInfoDouble(ACCOUNT_EQUITY),2) + "\n";
   text += "Spread : " + IntegerToString((int)SymbolInfoInteger(_Symbol,SYMBOL_SPREAD));

   Comment(text);
}

#endif
