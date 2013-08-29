#!/bin/bash
PLAYERS="$1"
WORLD="$2"
PORT="$3"
SERVER_DIR="$4"
cd "$SERVER_DIR"/Steam/
"$SERVER_DIR"/Steam/steam -command update -game hl2mp -dir steamserver
"$SERVER_DIR"/Steam/steam -command update -game hl2mp -dir steamserver
if [ $WORLD == "world" ]
then
cd "$SERVER_DIR"/Steam/steamserver/orangebox
"$SERVER_DIR"/Steam/steamserver/orangebox/srcds_run -game hl2mp -autoupdate -tickrate 66 -maxplayers $PLAYERS +map dm_lockdown -port $PORT
else
cd "$SERVER_DIR"/Steam/steamserver/orangebox
"$SERVER_DIR"/Steam/steamserver/orangebox/srcds_run -game hl2mp -autoupdate -tickrate 66 -maxplayers $PLAYERS +map $WORLD -port $PORT
fi
