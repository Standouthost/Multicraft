#!/bin/bash
#set -x
SERVER_DIR="$2"
JAVA="$3"
MEMORY="$4"
JAR_FILE="$5"
PORT="$6"
MAX_PLAYERS="$7"
IP="$8"

cd $SERVER_DIR/StarMade
sed -i "s/^MAX_CLIENTS =.*/MAX_CLIENTS = $MAX_PLAYERS/g" $SERVER_DIR/StarMade/server.cfg
sed -i "s/^SERVER_LISTEN_IP =.*/SERVER_LISTEN_IP = $IP/g" $SERVER_DIR/StarMade/server.cfg
$JAVA -Xmx"$MEMORY"M -Xms"$MEMORY"M -jar $JAR_FILE -server -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+CMSIncrementalPacing -XX:ParallelGCThreads=7 -XX:+AggressiveOpts -XX:PermSize=128m -XX:MaxPermSize=256m -XX:NewRatio=3 -XX:+UseThreadPriorities -XX:+UseCMSCompactAtFullCollection -XX:CMSFullGCsBeforeCompaction=1 -XX:SoftRefLRUPolicyMSPerMB=2048  -XX:CMSInitiatingOccupancyFraction=90 -XX:+DisableExplicitGC -XX:+CMSParallelRemarkEnabled -XX:MaxGCPauseMillis=50 -XX:+UseAdaptiveGCBoundary -XX:-UseGCOverheadLimit -XX:+UseBiasedLocking -XX:SurvivorRatio=8 -XX:TargetSurvivorRatio=90 -XX:MaxTenuringThreshold=15 -oss4M -ss4M -XX:UseSSE=4 -XX:+UseLargePages -XX:+UseStringCache -XX:+UseCompressedOops -XX:+OptimizeStringConcat -XX:+UseFastAccessorMethods -port:$PORT
