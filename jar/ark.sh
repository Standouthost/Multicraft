#!/bin/bash
PLAYERS="$1"
WORLD="$2"
PORT="$3"
SERVER_DIR="$4"
IP="$5"
CPORT=$(expr ${PORT} + 1000)
if [ ! -d "$SERVER_DIR"/.steam ]; then
	mkdir -p "$SERVER_DIR"/.steam/sdk32
	rsync -avz "$SERVER_DIR"/Steam/linux32/ "$SERVER_DIR"/.steam/sdk32
fi
if [ $WORLD == 'world' -o $WORLD == 'update' ]; then
	cd "$SERVER_DIR"/Steam/
	"$SERVER_DIR"/Steam/steamcmd.sh +runscript ark.txt
	cd "$SERVER_DIR"/Steam/ark/ShooterGame/Binaries/Linux
	"$SERVER_DIR"/Steam/ark/ShooterGame/Binaries/Linux/ShooterGameServer TheIsland?listen?SessionName="${WORLD}"?ServerAdminPassword=Jmainguy?QueryPort=${PORT}?Port=${CPORT}?MultiHome=${IP}?MaxPlayers=${PLAYERS} -server -log
else
	cd "$SERVER_DIR"/Steam/ark/ShooterGame/Binaries/Linux
	"$SERVER_DIR"/Steam/ark/ShooterGame/Binaries/Linux/ShooterGameServer TheIsland?listen?SessionName="${WORLD}"?ServerAdminPassword=Jmainguy?QueryPort=${PORT}?Port=${CPORT}?MultiHome=${IP}?MaxPlayers=${PLAYERS} -server -log
fi
