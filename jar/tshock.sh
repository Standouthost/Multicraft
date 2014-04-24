#!/bin/bash
SERVER_DIR="$1"
SERVER_PORT="$2"
MAX_PLAYERS="$3"
SERVER_IP="" #left blank, fill in with server's IP address.

#Run server as user
KILL=`/usr/sbin/lsof -t -i @"$SERVER_IP":"$SERVER_PORT"`
kill -9 "$KILL"


export PATH=$PATH:/opt/mono-2.11.4/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/mono-2.11.4/lib
mozroots --import --ask-remove 
cd $SERVER_DIR/TShock
/opt/mono-2.11.4/bin/mono --gc=sgen TerrariaServer.exe -port $SERVER_PORT -maxplayers $MAX_PLAYERS -world Terraria/Worlds/main.wld -autocreate 3
