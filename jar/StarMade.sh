#!/bin/bash
#set -x
SERVER_DIR="$2"
JAVA="$3"
MEMORY="$4"
JAR_FILE="$5"
PORT="$6"

cd $SERVER_DIR/StarMade
$JAVA -Xmx"$MEMORY"M -Xms"$MEMORY"M -jar $JAR_FILE -server -port:$PORT
