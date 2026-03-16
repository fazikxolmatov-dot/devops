#!/bin/bash

LAT=$1
LON=$2

if [ -z "$LAT" ] || [ -z "$LON" ]; then
 echo "Usage: $0 <latitude> <longitude>"
 exit 1
fi

API="https://api.open-meteo.com/v1/forecast?latitude=$LAT&longitude=$LON&current_weather=true"

DATA=$(curl -s $API)

TEMP=$(echo $DATA | jq '.current_weather.temperature')
WIND=$(echo $DATA | jq '.current_weather.windspeed')
TIME=$(echo $DATA | jq -r '.current_weather.time')

echo "Location: $LAT , $LON"
echo "Temperature: $TEMP °C"
echo "Wind speed: $WIND km/h"
echo "Time: $TIME"
