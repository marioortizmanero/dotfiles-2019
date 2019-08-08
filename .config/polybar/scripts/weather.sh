#!/bin/bash

# Weather module using wttr.in with a fix for fontawesome icons: temperature, wind, arrows, sun+cloud+rain, sun, could+rain, snow, fog, cloud, lightning, storm, unknown
# All the constants can be seen here: https://github.com/chubin/wttr.in/blob/master/lib/constants.py
# temp="   "
# wind="    "
temp=""
wind=" "
suncloudrain=" "
sun=" "
rain=" "
snow=" "
suncloud=" "
fog=" "
cloud=" "
storm=" "
lightning=" "
unknown=" "

errorCount=0
errorWait=( 5 10 20 30 60 )
maxErrors=${#errorWait[@]}


function getWeather {
    weather=$(curl -s http://wttr.in/\?format\=2\&\?m | sed "s/🌡/$temp/g; s/🌬/$wind/g; s/↓|↙|←|↖|↑|↗|→|↘//g; s/🌦/$suncloudrain/g; s/☀/$sun/g; s/🌧|🌧|🌨|🌨|🌧|🌧/$rain/g; s/❄️/$snow/g; s/⛅️/$suncloud/g; s/🌫/$fog/g; s/☁️/$cloud/g; s/🌩/$lightning/g; s/⛈|⛈/$storm/; s/✨/$unknown/g")
}

# Making sure no internal error happens and showing a nice error instead
function parseWeather {
    if [ "$errorCount" -lt "$maxErrors" ]; then
        getWeather
        if echo $weather | grep -q "500 Internal Server Error"; then
            sleep ${errorWait[$errorCount]}
            errorCount=$((errorCount + 1))
            parseWeather
        else
            echo "$weather"
        fi
    else
        echo "No weather data"
    fi
}

parseWeather

