#!/bin/bash
PLAYERS="$1"
WORLD="$2"
PORT="$3"
SERVER_DIR="$4"
if [ ! -d ${SERVER_DIR}/.steam ]; then
	mkdir -p ${SERVER_DIR}/.steam/sdk32;
fi
if [ $WORLD == 'update' -o $WORLD == 'world' ]; then
	cd ${SERVER_DIR}/Steam/
	${SERVER_DIR}/Steam/steamcmd.sh +runscript gmod.txt
	cp ${SERVER_DIR}/Steam/linux32/libsteam.so ${SERVER_DIR}/.steam/sdk32/
	cp ${SERVER_DIR}/Steam/linux32/libstdc++.so.6 ${SERVER_DIR}/Steam/gmod/bin/
	rsync -avz ${SERVER_DIR}/Steam/lib/ ${SERVER_DIR}/Steam/gmod/bin
	cd ${SERVER_DIR}/Steam/gmod
	rsync 
	${SERVER_DIR}/Steam/gmod/srcds_run -game garrysmod -autoupdate -tickrate 66 -maxplayers $PLAYERS +map gm_construct -port $PORT
else
	cd ${SERVER_DIR}/Steam/gmod
	rsync -avz ${SERVER_DIR}/Steam/lib/ ${SERVER_DIR}/Steam/gmod/bin
	${SERVER_DIR}/Steam/gmod/srcds_run -game garrysmod -autoupdate -tickrate 66 -maxplayers $PLAYERS +map $WORLD -port $PORT
fi
