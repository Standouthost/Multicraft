#!/bin/bash
SERVER_DIR="$1"
SERVER_PORT="$2"
MAX_PLAYERS="$3"
SERVER_IP="$4"
PASSWORD="$5"

#Run server as user
KILL=`/usr/sbin/lsof -t -i @"$SERVER_IP":"$SERVER_PORT"`
kill -9 "$KILL"

sed -i "s/port.*/port=$SERVER_PORT/g" $SERVER_DIR/Mumble/murmur.ini
sed -i "s/.*host=.*/host=$SERVER_IP/g" $SERVER_DIR/Mumble/murmur.ini
sed -i "s/users.*/users=$MAX_PLAYERS/g" $SERVER_DIR/Mumble/murmur.ini

$SERVER_DIR/Mumble/murmur.x86 -ini $SERVER_DIR/Mumble/murmur.ini -supw $PASSWORD

$SERVER_DIR/Mumble/murmur.x86
echo "Server is running, there is no console"
echo "But trust me, it is running"
tail -f $SERVER_DIR/Mumble/murmur.log
