#!/bin/bash

detect_city="$(curl -s https://ipapi.co/city)"
text="$(curl -s "https://wttr.in/$detect_city?format=1" | sed 's/ +//g')"
tooltip="$(curl -s "https://wttr.in/$detect_city-?0QT" |
    sed 's/\\/\\\\/g' |
    sed ':a;N;$!ba;s/\n/\\n/g' |
    sed 's/"/\\"/g')"
echo "{\"text\": \"${text}\", \"tooltip\": \"<tt>${tooltip}</tt>\", \"class\": \"weather\"}"
