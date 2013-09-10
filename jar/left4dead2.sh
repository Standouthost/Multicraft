#!/bin/bash
PLAYERS="$1"
WORLD="$2"
PORT="$3"
SERVER_DIR="$4"
if [ -d "$SERVER_DIR"/.steam ]; then
	echo "cool"
else
	mkdir -p "$SERVER_DIR"/.steam/sdk32
	rsync -avz "$SERVER_DIR"/Steam/linux32/ "$SERVER_DIR"/.steam/sdk32
fi
if [ $WORLD == 'world' -o $WORLD == 'update' ]; then
	cd "$SERVER_DIR"/Steam/
	"$SERVER_DIR"/Steam/steamcmd.sh +runscript l4d2.txt
	cd "$SERVER_DIR"/Steam/l4d2
	"$SERVER_DIR"/Steam/l4d2/srcds_run -game left4dead2 -maxplayers $PLAYERS +c5m1_waterfront -port $PORT
else
	cd "$SERVER_DIR"/Steam/l4d2
	"$SERVER_DIR"/Steam/l4d2/srcds_run -game left4dead2 -maxplayers $PLAYERS +map $WORLD -port $PORT
fi
