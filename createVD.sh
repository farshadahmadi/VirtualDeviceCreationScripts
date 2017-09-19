#!/bin/bash

GIT_URL=https://github.com/farshadahmadi/liquidiot-server.git

I=$1

ROOM_NUMBER=$2

ROOM_COORDS=$3

arr=(${ROOM_COORDS//./ })
X=${arr[0]}
Y=${arr[1]}

echo ${arr[*]}

git clone $GIT_URL vd"$I"

cd vd"$I"

git checkout siotad-development-configchange

#let "remainder = $I % 2"

sed '1,39d;' <config/config-examples.json> config/config.json

#if [ "$remainder" -eq 0 ]; then
#cp config/config-template.json config/config.json
#else
#sed '1,3d;' <config-template.txt> config.txt
#fi

let SERVER_PORT="10000 + $I"

DEVICE_URL='http://10.1.1.89:'"${SERVER_PORT}"''

DEVICE_NAME="Alarm"

DEVICE_LOCATION_X=$X

DEVICE_LOCATION_Y=$Y

SERVER_URL="$DEVICE_URL"

let SERVER_APPS_STARTPORT="8001 + (($I - 1) * 10)"

DM_URL="http://130.230.142.101:3001/"

RR_URL="$DM_URL"

configContent=$(cat config/config.json | ../jq-linux64 '.device.name = "'"$DEVICE_NAME"'" | .device.url = "'"$SERVER_URL"'" | .device.port = '"${SERVER_PORT}"' | .device.startportrange = '"${SERVER_APPS_STARTPORT}"' | .device.idFromBackend = "1" | .device.location.x = '"$X"' | .device.location.y = '"$Y"' | .device.location.tag = "'"$ROOM_NUMBER"'" | .deviceManager.url = "'"$DM_URL"'"')

#echo $configContent > config.txt
echo $configContent | ../jq-linux64 . > config/config.json

#cp dm-config-template.txt dm-config.txt


#dmConfigContent=$(cat dm-config.txt | ../jq-linux64 '.url = "'"$DM_URL"'"')

#echo $dmConfigContent > dm-config.txt

#cp backend-config-template.txt backend-config.txt

sed 's/vd/vd'"${I}"'/g' ../start.sh > start.sh

chmod +x start.sh

sed 's/vd/vd'"${I}"'/g' ../stop.sh > stop.sh

chmod +x stop.sh
