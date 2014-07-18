#!/bin/bash
SERVER_DIR="$1"
SERVER_PORT="$2"
MAX_PLAYERS="$3"
SERVER_IP="$4"
PASSWORD="$5"

sed -i "s/^port.*/port $SERVER_PORT/g" $SERVER_DIR/Samp/server.cfg
sed -i "s/^rcon_password.*/rcon_password $PASSWORD/g" $SERVER_DIR/Samp/server.cfg
sed -i "s/^maxplayers.*/maxplayers $MAX_PLAYERS/g" $SERVER_DIR/Samp/server.cfg
sed -i "s/^bind.*/bind $SERVER_IP/g" $SERVER_DIR/Samp/server.cfg

cd $SERVER_DIR/Samp
./samp03svr
