#!/bin/bash
PLAYERS="$1"
WORLD="$2"
PORT="$3"
SERVER_DIR="$4"
if [ $WORLD == 'world' ]; then
	cd "$SERVER_DIR"/Steam/
	"$SERVER_DIR"/Steam/steamcmd.sh +runscript css.txt
fi
if [ -d "$SERVER_DIR"/.steam ]; then
	echo "cool"
else
	mkdir -p "$SERVER_DIR"/.steam/sdk32
	rsync -avz "$SERVER_DIR"/Steam/linux32/ "$SERVER_DIR"/.steam/sdk32
fi
if [ $WORLD == "world" ]; then
	cd "$SERVER_DIR"/Steam/css
	"$SERVER_DIR"/Steam/css/srcds_run -game cstrike -maxplayers $PLAYERS +map de_aztec -port $PORT
else
	cd "$SERVER_DIR"/Steam/css
	"$SERVER_DIR"/Steam/css/srcds_run -game cstrike -maxplayers $PLAYERS +map $WORLD -port $PORT
fi
