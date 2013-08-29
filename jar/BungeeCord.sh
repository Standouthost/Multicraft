#!/bin/bash
SERVER_DIR="$1"
SERVER_PORT="$2"
MAX_PLAYERS="$3"
SERVER_IP="$4"
PASSWORD="$5"

sed "s/host:.*/host: $SERVER_IP\:$SERVER_PORT/g" $SERVER_DIR/config.yml > $SERVER_DIR/config.yml.tmp

mv $SERVER_DIR/config.yml.tmp $SERVER_DIR/config.yml

sed "s/max_players.*/max_players: $MAX_PLAYERS/g" $SERVER_DIR/config.yml > $SERVER_DIR/config.yml.tmp

mv $SERVER_DIR/config.yml.tmp $SERVER_DIR/config.yml

cd $SERVER_DIR
java -jar $SERVER_DIR/BungeeCord.jar
