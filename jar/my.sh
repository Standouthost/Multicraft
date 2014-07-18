#!/bin/bash
SERVER_ID="$1"
SERVER_DIR="$2"
SERVER_IP="$3"
SERVER_PORT="$4"
MAX_MEMORY="$5"
START_MEMORY="$6"
JAVA="$7"

cd "$SERVER_DIR"/jars/
"$JAVA" -Xmx"$MAX_MEMORY"M -Xms"$START_MEMORY"M -Djline.terminal=jline.UnsupportedTerminal -XX:+UseConcMarkSweepGC -XX:+UseCMSCompactAtFullCollection -XX:+DisableExplicitGC -XX:+UseParNewGC -XX:+CMSIncrementalPacing -XX:ParallelGCThreads=32 -XX:+AggressiveOpts -XX:UseSSE=4 -XX:PermSize=128m -XX:MaxPermSize=256m -Xincgc -jar "$SERVER_DIR"/jars/my.jar nogui
