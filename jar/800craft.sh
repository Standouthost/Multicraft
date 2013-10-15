#!/bin/bash
SERVER_DIR="$1"
SERVER_PORT="$2"
MAX_PLAYERS="$3"
SERVER_IP="$4"

#Run server as user
KILL=`/usr/sbin/lsof -t -i @"$SERVER_IP":"$SERVER_PORT"`
kill -9 "$KILL"

sed -i 's/.*"MaxPlayers".*/    <ConfigKey key="MaxPlayers" value="'$MAX_PLAYERS'" default="20" \/>/g' $SERVER_DIR/800craft/config.xml
sed -i 's/.*"Port".*/    <ConfigKey key="Port" value="'$SERVER_PORT'" default="25565" \/>/g' $SERVER_DIR/800craft/config.xml

export PATH=$PATH:/opt/mono/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/mono/bin
mozroots --import --ask-remove 

cd $SERVER_DIR/800craft
/opt/mono/bin/mono --gc=sgen $SERVER_DIR/800craft/ServerCLI.exe
