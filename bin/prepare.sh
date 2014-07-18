#!/bin/bash

## Comment the following line out to let the script check if the server port
## is occupied and kill the occupying proccess if required
##
## You may have to enable the prepare.sh script in your multicraft.conf by
## having the following setting in the [useragent] section:
## userAgentSuperuserPrepare = prepare.sh
##exit 0
if [ ! -f $SERVER_DIR/server.properties ]; then
       	exit 1
fi
if [ $JAR_FILE == 'pocketmine.jar' ]; then
	if [ ! -d $SERVER_DIR/PocketMine ]; then
		mkdir $SERVER_DIR/PocketMine
	fi
	ln $SERVER_DIR/server.properties $SERVER_DIR/PocketMine/server.properties
fi
if [ $JAR_FILE == 'my.jar' ]; then
	if [ -d $SERVER_DIR/jars ]; then
		echo "jars dir exists"
	else
		mkdir $SERVER_DIR/jars
	fi
        if [ -e $SERVER_DIR/jars/server.properties ]; then
                rm -f $SERVER_DIR/jars/server.properties
        fi
        ln $SERVER_DIR/server.properties $SERVER_DIR/jars/server.properties
else
	echo "You did not choose Custom Jar"
fi
if [ $JAR_FILE == 'minecraft_server.jar' ]; then
       	cp $JAR_DIR/minecraft_server.jar $SERVER_DIR/minecraft_server.jar
else
       	echo "You did not choose Vanilla Minecraft"
fi
if [ $JAR_FILE == 'BungeeCord.jar' ]; then
        if [ ! -d $SERVER_DIR/BungeeCord ]; then
                mkdir $SERVER_DIR/BungeeCord
        fi
        if [ ! -f $SERVER_DIR/BungeeCord/config.yml ]; then
                cp $JAR_DIR/BungeeCord/config.yml $SERVER_DIR/BungeeCord/config.yml
        fi
        cp $JAR_DIR/BungeeCord.jar $SERVER_DIR/BungeeCord/BungeeCord.jar
        QPORT=$(expr $PORT + 30000)
        sed -i "s/host: 0.0.0.0:25577/host: $IP:$QPORT/g" $SERVER_DIR/BungeeCord/config.yml
        sed -i "s/query_port: 25577/query_port: $QPORT/g" $SERVER_DIR/BungeeCord/config.yml
        sed -i "s/address: localhost:25565/address: $IP:$PORT/g" $SERVER_DIR/BungeeCord/config.yml
fi
if [ $JAR_FILE == 'craftbukkit.jar' ]; then
	cp $JAR_DIR/craftbukkit.jar $SERVER_DIR/craftbukkit.jar
else
        echo "You did not choose Craftbukkit Recommended Build"
fi
if [ $JAR_FILE == 'craftbukkit_beta.jar' ]; then
        cp $JAR_DIR/craftbukkit_beta.jar $SERVER_DIR/craftbukkit_beta.jar
else
        echo "You did not choose Craftbukkit Beta Build"
fi
if [ $JAR_FILE == 'craftbukkit_dev.jar' ]; then
        cp $JAR_DIR/craftbukkit_dev.jar $SERVER_DIR/craftbukkit_dev.jar
else
        echo "You did not choose Craftbukkit Dev Build"
fi
if [ $JAR_FILE == '800craft.jar' ]; then
	if [ -d $SERVER_DIR/800craft ]; then
		echo "huzzah files"
        else 
		mkdir $SERVER_DIR/800craft
		cp $JAR_DIR/800craft/* $SERVER_DIR/800craft/
	fi
else
        echo "You did not choose 800craft"
fi
if [ $JAR_FILE == 'fCraft.jar' ]; then
	if [ -d $SERVER_DIR/classic ]; then
		echo "huzzah files"
        else 
		mkdir $SERVER_DIR/classic
		cp $JAR_DIR/classic/* $SERVER_DIR/classic/
	fi
else
        echo "You did not choose Classic"
fi
if [ $JAR_FILE == 'FTB.jar' ]; then
	if [ -d $SERVER_DIR/FeedTheBeast ]; then
		echo "huzzah files"
	else
		mkdir $SERVER_DIR/FeedTheBeast
		unzip -o $JAR_DIR/FTBUltimate.zip -d $SERVER_DIR/FeedTheBeast/
	fi
else
	echo "You did not choose FTB"
fi
if [ $JAR_FILE == 'Dire.jar' ]; then
	if [ -d $SERVER_DIR/Dire ]; then
		echo "huzzah files"
	else
		mkdir $SERVER_DIR/Dire
		unzip -o $JAR_DIR/Direwolf20_Server.zip -d  $SERVER_DIR/Dire/
	fi
else
	echo "You did not choose Dire"
fi
if [ $JAR_FILE == 'YogCraft.jar' ]; then
	if [ -d $SERVER_DIR/YogCraft ]; then
		echo "huzzah files"
        else
                mkdir $SERVER_DIR/YogCraft
       	        unzip -o $JAR_DIR/YogCraft.zip -d  $SERVER_DIR/YogCraft/
	fi
else
	echo "You did not choose YogCraft"
fi
if [ $JAR_FILE == 'Unhinged.jar' ]; then
	if [ -d $SERVER_DIR/Unhinged ]; then
		echo "huzzah files"
        else
                mkdir $SERVER_DIR/Unhinged
       	        unzip -o $JAR_DIR/Unhinged.zip -d  $SERVER_DIR/Unhinged/
	fi
else
	echo "You did not choose Unhinged"
fi
if [ $JAR_FILE == 'Unleashed.jar' ]; then
	if [ -d $SERVER_DIR/Unleashed ]; then
		echo "huzzah files"
        else
                mkdir $SERVER_DIR/Unleashed
       	        unzip -o $JAR_DIR/Unleashed.zip -d  $SERVER_DIR/Unleashed/
	fi
else
	echo "You did not choose Unleashed"
fi
if [ $JAR_FILE == 'BTeam.jar' ]; then
	if [ -d $SERVER_DIR/BTeam ]; then
		echo "huzzah files"
        else
                mkdir $SERVER_DIR/BTeam
       	        unzip -o $JAR_DIR/BTeam.zip -d  $SERVER_DIR/BTeam/
	fi
else
	echo "You did not choose BTeam"
fi
if [ $JAR_FILE == 'MindCrack.jar' ]; then
	if [ -d $SERVER_DIR/MindCrack ]; then
		echo "huzzah files"
        else
                mkdir $SERVER_DIR/MindCrack
       	        unzip -o $JAR_DIR/MindCrack.zip -d  $SERVER_DIR/MindCrack/
	fi
else
	echo "You did not choose MindCrack"
fi
if [ $JAR_FILE == 'voltz.jar' ]; then
	if [ -d $SERVER_DIR/Voltz ]; then
		echo "huzzah files"
	else
		mkdir $SERVER_DIR/Voltz
		unzip -o $JAR_DIR/Voltz_Server.zip -d $SERVER_DIR/Voltz/
	fi
else
        echo "You did not choose Voltz"
fi
if [ $JAR_FILE == 'hexxit.jar' ]; then
	if [ -d $SERVER_DIR/Hexxit ]; then
		echo "huzzah files"
	else
		mkdir $SERVER_DIR/Hexxit
		unzip -o $JAR_DIR/Hexxit.zip -d $SERVER_DIR/Hexxit/
	fi
else
        echo "You did not choose Hexxit"
fi
if [ $JAR_FILE == 'tekkit.jar' ]; then
	if [ -d $SERVER_DIR/Tekkit ]; then
		echo "huzzah files"
	else
		mkdir $SERVER_DIR/Tekkit
		unzip -o $JAR_DIR/Tekkit_Server.zip -d $SERVER_DIR/Tekkit/
	fi
else
        echo "You did not choose Tekkit"
fi
if [ $JAR_FILE == 'tekkitbigdig.jar' ]; then
	if [ -d $SERVER_DIR/Tekkit_BigDig ]; then
		echo "huzzah files"
	else
		mkdir $SERVER_DIR/Tekkit_BigDig
		unzip -o $JAR_DIR/Tekkit_BigDig.zip -d $SERVER_DIR/Tekkit_BigDig/
	fi
else
        echo "You did not choose Tekkit BigDIg"
fi
if [ $JAR_FILE == 'tekkitclassic.jar' ]; then
	if [ -d $SERVER_DIR/Tekkit_Classic ]; then
		echo "huzzah files"
        else
               	mkdir $SERVER_DIR/Tekkit_Classic
                unzip -o $JAR_DIR/Tekkit_Classic.zip -d $SERVER_DIR/Tekkit_Classic/
	fi
else
	echo "You did not choose Tekkit Classic"
fi
if [ $JAR_FILE == 'tekkit_lite.jar' ]; then
	if [ -d $SERVER_DIR/Tekkit_Lite ]; then
		echo "huzzah files"
	else
               	mkdir $SERVER_DIR/Tekkit_Lite
                unzip -o $JAR_DIR/Tekkit_Lite.zip -d $SERVER_DIR/Tekkit_Lite/
	fi
else
	echo "You did not choose Tekkit Lite"
fi
if [ $JAR_FILE == 'tshock.jar' ]; then
	if [ -d $SERVER_DIR/TShock ]; then
		echo "huzzah files"
	else
		mkdir $SERVER_DIR/TShock
		cp -R $JAR_DIR/tshock/* $SERVER_DIR/TShock/
	fi
else
	echo "You did not choose TShock"
fi
if [ $JAR_FILE == 'teamspeak.jar' ]; then
	if [ -d $SERVER_DIR/TeamSpeak3 ]; then
		echo "huzzah files"
        else
                rsync -avz $JAR_DIR/TeamSpeak3  $SERVER_DIR/
	fi
else
	echo "You did not choose Teamspeak"
fi
if [[ $JAR_FILE == 'left4dead2.jar' || $JAR_FILE == 'garrysmod.jar' || $JAR_FILE == 'tf2.jar' || $JAR_FILE == 'hl2mp.jar' || $JAR_FILE == 'cstrikesource.jar' ]]; then
	if [ -d $SERVER_DIR/Steam ]; then
		echo "huzzah files"
	else
               	rsync -avz $JAR_DIR/steamcmd/  $SERVER_DIR/Steam
        fi
else
        echo "You did not choose Steam"
fi
if [ $JAR_FILE == 'samp.jar' ]; then 
	if [ -d $SERVER_DIR/Samp ]; then
		echo "huzzah files"
	else
		rsync -avz $JAR_DIR/samp/*  $SERVER_DIR/Samp
	fi
for PID in $(ps -ef | grep "$SERVER_DIR" | grep -v grep | awk '{print $2}'); do
        kill -9 $PID
done
else
        echo "You did not choose San Andreas"
fi
if [ $JAR_FILE == 'StarMade.jar' ]; then
	if [ -f $SERVER_DIR/StarMade-Starter.jar ]; then
		echo "huzzah files"
	else
		cp $JAR_DIR/StarMade-Starter.jar $SERVER_DIR/
	fi
	cd $SERVER_DIR
	java -jar $SERVER_DIR/StarMade-Starter.jar -nogui
	sleep 5
	if [ ! -f $SERVER_DIR/StarMade/server.cfg ]; then
		cp $JAR_DIR/StarMade.cfg $SERVER_DIR/StarMade/server.cfg
	fi
fi
if [ $JAR_FILE == 'mcpc-plus164.jar' ]; then
	cp $JAR_DIR/mcpc-plus164.jar $SERVER_DIR/
fi
if [ $JAR_FILE == 'mcpc-plus.jar' ]; then
	if [ ! -f $SERVER_DIR/mcpc-plus-installer.jar ]; then
		cp $JAR_DIR/mcpc-plus-installer.jar $SERVER_DIR/
		cd $SERVER_DIR/
		java -jar $SERVER_DIR/mcpc-plus-installer.jar --installServer nogui
	fi
	cp $JAR_DIR/mcpc-plus.jar $SERVER_DIR/
fi
if [ $JAR_FILE == 'minecraftforge.jar' ]; then
	if [ ! -f $SERVER_DIR/minecraftforge.jar ]; then
		cp $JAR_DIR/minecraftforgeinstaller.jar $SERVER_DIR/
		cd $SERVER_DIR
		java -jar $SERVER_DIR/minecraftforgeinstaller.jar --installServer nogui
		mv $SERVER_DIR/forge-*.jar $SERVER_DIR/minecraftforge.jar
	fi
fi
if [ $JAR_FILE == 'mumble.jar' ]; then
	if [ -d $SERVER_DIR/Mumble ]; then
		echo "huzzah files"
	else
		cp -R $JAR_DIR/Mumble  $SERVER_DIR/
	fi
else
	echo "You did not choose Mumble"
fi

# BungeeCord
if [ $JAR_FILE == 'BungeeCord.1.5.2.jar' ]; then
        if [ ! -d $SERVER_DIR/BungeeCord ]; then
                mkdir $SERVER_DIR/BungeeCord
        fi
        if [ ! -f $SERVER_DIR/BungeeCord/config.yml ]; then
                cp $JAR_DIR/BungeeCord.1.5.2/config.yml $SERVER_DIR/BungeeCord/config.yml
        fi
        cp $JAR_DIR/BungeeCord.1.5.2.jar $SERVER_DIR/BungeeCord/BungeeCord.1.5.2.jar
        QPORT=$(expr $PORT + 30000)
        sed -i "s/^.*\shost:.*/  host: $IP:$PORT/g" $SERVER_DIR/BungeeCord/config.yml
fi

if [ $JAR_FILE == 'BungeeCord.1.6.4.jar' ]; then
        if [ ! -d $SERVER_DIR/BungeeCord ]; then
                mkdir $SERVER_DIR/BungeeCord
        fi
        if [ ! -f $SERVER_DIR/BungeeCord/config.yml ]; then
                cp $JAR_DIR/BungeeCord.1.6.4/config.yml $SERVER_DIR/BungeeCord/config.yml
        fi
        cp $JAR_DIR/BungeeCord.1.6.4.jar $SERVER_DIR/BungeeCord/BungeeCord.1.6.4.jar
        QPORT=$(expr $PORT + 30000)
        sed -i "s/^.*\shost: 0.0.0.0:25577/  host: $IP:$PORT/g" $SERVER_DIR/BungeeCord/config.yml
        sed -i "s/^.*\squery_port: 25577/  query_port: $QPORT/g" $SERVER_DIR/BungeeCord/config.yml
fi

if [ $JAR_FILE == 'BungeeCord.1.7.9.jar' ]; then
        if [ ! -d $SERVER_DIR/BungeeCord ]; then
                mkdir $SERVER_DIR/BungeeCord
        fi
        if [ ! -f $SERVER_DIR/BungeeCord/config.yml ]; then
                cp $JAR_DIR/BungeeCord.1.7.9/config.yml $SERVER_DIR/BungeeCord/config.yml
        fi
        cp $JAR_DIR/BungeeCord.1.7.9.jar $SERVER_DIR/BungeeCord/BungeeCord.1.7.9.jar
        QPORT=$(expr $PORT + 30000)
        sed -i "s/^.*\shost: 0.0.0.0:25577/  host: $IP:$PORT/g" $SERVER_DIR/BungeeCord/config.yml
        sed -i "s/^.*\squery_port: 25577/  query_port: $QPORT/g" $SERVER_DIR/BungeeCord/config.yml
        sed -i "s/^.*\sip_forward: false/  ip_forward: true/g" $SERVER_DIR/BungeeCord/config.yml
fi

chown -R mc$SERVER_ID:mc$SERVER_ID "$SERVER_DIR"
LSOF=`which lsof`
    #Convert IP to a format accepted by lsof
    if [ "$IP" = "0.0.0.0" ]; then
        IP=""
    elif [ ! "$IP" = "" ]; then
        IP="@$IP"
    fi

    #Check for running processes on the same IP/port
    PID="`$LSOF -t -i\$IP:$PORT`"
    if [ ! "$PID" = "" ]; then
        echo "Warning: Found running process using the same IP/port ($PID)"
            kill -9 "$PID"
    fi
