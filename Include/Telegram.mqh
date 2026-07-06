//+------------------------------------------------------------------+
//| Telegram.mqh                                                     |
//+------------------------------------------------------------------+
#ifndef __TELEGRAM_MQH__
#define __TELEGRAM_MQH__

input bool EnableTelegram = false;
input string BotToken = "";
input string ChatID = "";

void SendTelegram(string message)
{
   if(!EnableTelegram)
      return;

   Print("Telegram Alert: ", message);

   // Telegram API integration will be added later
}

#endif
