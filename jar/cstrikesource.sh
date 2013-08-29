#!/bin/bash
PLAYERS="$1"
WORLD="$2"
PORT="$3"
SERVER_DIR="$4"
cd "$SERVER_DIR"/Steam/
"$SERVER_DIR"/Steam/steam -command update -game "Counter-Strike Source" -dir steamserver
"$SERVER_DIR"/Steam/steam -command update -game "Counter-Strike Source" -dir steamserver
if [ $WORLD == "world" ]
then
cd "$SERVER_DIR"/Steam/steamserver/css
"$SERVER_DIR"/Steam/steamserver/css/srcds_run -game cstrike -maxplayers $PLAYERS +map de_aztec -port $PORT
elif [ $WORLD == "update" ]
then
cd "$SERVER_DIR"/Steam/steamserver/css
"$SERVER_DIR"/Steam/steamserver/css/srcds_run -game cstrike -maxplayers $PLAYERS +map de_aztec -port $PORT -autoupdate
else
cd "$SERVER_DIR"/Steam/steamserver/css
"$SERVER_DIR"/Steam/steamserver/css/srcds_run -game cstrike -maxplayers $PLAYERS +map $WORLD -port $PORT
fi
