#!/bin/bash
#set -x
SERVER_DIR="$2"
JAVA="$3"
MEMORY="$4"
JAR_FILE="$5"
PORT="$6"
MAX_PLAYERS="$7"
IP="$8"

#Install/Update StarMade
cd $SERVER_DIR
$JAVA -jar $SERVER_DIR/StarMade-Starter.jar -force -nogui
#Run the server
cd $SERVER_DIR/StarMade
sed -i "s/^MAX_CLIENTS =.*/MAX_CLIENTS = $MAX_PLAYERS/g" $SERVER_DIR/StarMade/server.cfg
sed -i "s/^SERVER_LISTEN_IP =.*/SERVER_LISTEN_IP = $IP/g" $SERVER_DIR/StarMade/server.cfg
$JAVA -Xmx"$MEMORY"M -Xms"$MEMORY"M -jar $JAR_FILE -server -port:$PORT
