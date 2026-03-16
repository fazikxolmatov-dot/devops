#!/bin/bash

TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="123456789"

send_message() {
 TEXT=$1

 curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \
   -d chat_id="$CHAT_ID" \
   -d text="$TEXT"
}

send_message "Server ishga tushdi"

