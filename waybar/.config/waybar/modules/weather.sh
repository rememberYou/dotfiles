#!/bin/bash

text="$(curl -s "https://wttr.in/?format=1" | sed 's/ +//g')"
tooltip="$(curl -s "https://wttr.in/?0QT" |
    sed 's/\\/\\\\/g' |
    sed ':a;N;$!ba;s/\n/\\n/g' |
    sed 's/"/\\"/g')"
echo "{\"text\": \"${text}\", \"tooltip\": \"<tt>${tooltip}</tt>\", \"class\": \"weather\"}"
