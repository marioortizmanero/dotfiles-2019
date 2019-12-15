#!/bin/bash

# Weather module using wttr.in with a fix for fontawesome icons: temperature,
# wind, arrows, sun+cloud+rain, sun, could+rain, snow, fog, cloud, lightning,
# storm, unknown
# All the constants can be seen here:
# https://github.com/chubin/wttr.in/blob/master/lib/constants.py

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

errorWait=( 5 15 60 150 300 )
maxErrors=${#errorWait[@]}


function getWeather() {
    weather=$(curl -s http://wttr.in/\?format\=2\&\?m 2>&1 | sed "s/🌡/$temp/g; s/🌬/$wind/g; s/↓|↙|←|↖|↑|↗|→|↘//g; s/🌦/$suncloudrain/g; s/☀/$sun/g; s/🌧|🌧|🌨|🌨|🌧|🌧/$rain/g; s/❄️/$snow/g; s/⛅️/$suncloud/g; s/🌫/$fog/g; s/☁️/$cloud/g; s/🌩/$lightning/g; s/⛈|⛈/$storm/; s/✨/$unknown/g")
}

# Making sure no internal error happens and showing a nice error instead
function parseWeather() {
    for ((i = 0; i < maxErrors; i++)); do
        getWeather
        # First checking that the server isn't down
        if [[ $weather != *"Unknown location"* ]]; then
            # Then checking that a temporary error didn't happen
            if [[ $weather != *"500 Internal Server Error"* ]]; then
                echo "$weather"
                break
            else
                sleep ${errorWait[$i]}
                errorCount=$((errorCount + 1))
            fi
        else
            echo ""
            break
        fi
    done
}

parseWeather
