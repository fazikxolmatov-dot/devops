#!/bin/bash

# Telegram bot token
TOKEN="YOUR_BOT_TOKEN"

# Parametrlar
CHAT_ID=$1
MESSAGE=$2

# Tekshirish
if [ -z "$CHAT_ID" ] || [ -z "$MESSAGE" ]; then
 echo "Usage: $0 <chat_id> <message>"
 exit 1
fi

# Telegram API
URL="https://api.telegram.org/bot$TOKEN/sendMessage"

# Xabar yuborish
curl -s -X POST $URL \
 -d chat_id="$CHAT_ID" \
 -d text="$MESSAGE"

echo "Message sent!"
