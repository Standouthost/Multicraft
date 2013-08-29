#!/bin/bash
PLAYERS="$1"
WORLD="$2"
PORT="$3"
SERVER_DIR="$4"
if [ $WORLD == 'world' ]; then
	cd "$SERVER_DIR"/Steam/
	"$SERVER_DIR"/Steam/steamcmd.sh +runscript hl2mp.txt
fi
if [ -d "$SERVER_DIR"/.steam ]; then
	echo "cool"
else
	mkdir -p "$SERVER_DIR"/.steam/sdk32
	rsync -avz "$SERVER_DIR"/Steam/linux32/ "$SERVER_DIR"/.steam/sdk32
fi
if [ $WORLD == "world" ]; then
	cd "$SERVER_DIR"/Steam/hl2mp
	"$SERVER_DIR"/Steam/hl2mp/srcds_run -game hl2mp -tickrate 66 -maxplayers $PLAYERS +map dm_lockdown -port $PORT
else
	cd "$SERVER_DIR"/Steam/tf2
	"$SERVER_DIR"/Steam/hl2mp/srcds_run -game hl2mp -tickrate 66 -maxplayers $PLAYERS +map $WORLD -port $PORT
fi
