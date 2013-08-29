#!/bin/bash
SERVER_ID="$1"
SERVER_DIR="$2"
SERVER_IP="$3"
SERVER_PORT="$4"
MAX_MEMORY="$5"
START_MEMORY="$6"
JAVA="$7"

cp "$SERVER_DIR"/server.properties "$SERVER_DIR"/Tekkit_Lite/
cd "$SERVER_DIR"/Tekkit_Lite/
"$JAVA" -Xmx"$MAX_MEMORY"M -Xms"$START_MEMORY"M -Djline.terminal=jline.UnsupportedTerminal -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+CMSIncrementalPacing -XX:ParallelGCThreads=4 -XX:+AggressiveOpts -Xincgc -jar "$SERVER_DIR"/Tekkit_Lite/TekkitLite.jar nogui
