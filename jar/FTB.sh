#!/bin/bash
SERVER_ID="$1"
SERVER_DIR="$2"
SERVER_IP="$3"
SERVER_PORT="$4"
MAX_MEMORY="$5"
START_MEMORY="$6"
JAVA="$7"

cp "$SERVER_DIR"/server.properties "$SERVER_DIR"/FeedTheBeast/
cd "$SERVER_DIR"/FeedTheBeast/
"$JAVA" -Xmx"$MAX_MEMORY"M -Xms"$START_MEMORY"M -Djline.terminal=jline.UnsupportedTerminal -server -XX:+UseConcMarkSweepGC -XX:+CMSIncrementalPacing -XX:+AggressiveOpts -XX:PermSize=128m -XX:MaxPermSize=256m -XX:NewRatio=3 -XX:+UseThreadPriorities -XX:+UseCMSCompactAtFullCollection -XX:CMSFullGCsBeforeCompaction=1 -XX:CMSInitiatingOccupancyFraction=90 -XX:+CMSParallelRemarkEnabled -XX:MaxGCPauseMillis=50 -XX:+UseAdaptiveGCBoundary -XX:-UseGCOverheadLimit -XX:+UseBiasedLocking -XX:SurvivorRatio=8 -XX:TargetSurvivorRatio=90 -XX:MaxTenuringThreshold=15 -oss4M -ss4M -XX:UseSSE=4 -XX:+UseNUMA -XX:+UseStringCache -XX:+UseCompressedOops -XX:+OptimizeStringConcat -XX:+UseFastAccessorMethods -jar "$SERVER_DIR"/FeedTheBeast/ftbserver.jar nogui
