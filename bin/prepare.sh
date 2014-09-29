#!/bin/bash

## Comment the following line out to let the script check if the server port
## is occupied and kill the occupying proccess if required
##
## You may have to enable the prepare.sh script in your multicraft.conf by
## having the following setting in the [useragent] section:
## userAgentSuperuserPrepare = prepare.sh
##exit 0
if [ ! -f ${SERVER_DIR}/server.properties ]; then
       	exit 1
fi


function EULA {
	echo "eula=true" > ${SERVER_DIR}/${ROOT_DIR}/eula.txt
}

function MAKE_ROOT {
	if [ ! -d ${SERVER_DIR}/${ROOT_DIR} ]; then
		mkdir ${SERVER_DIR}/${ROOT_DIR}
	fi
	rm -f ${SERVER_DIR}/${ROOT_DIR}/server.properties
	if [ -e ${SERVER_DIR}/${ROOT_DIR}/server.properties ]; then
		rm -f ${SERVER_DIR}/${ROOT_DIR}/server.properties
	fi
	cp ${SERVER_DIR}/server.properties ${SERVER_DIR}/${ROOT_DIR}/server.properties
}

function UNZIP {
	if [ ! -f ${SERVER_DIR}/${ROOT_DIR}/.unzip ]; then
		unzip -o $JAR_DIR/$ZIP_FILE -d  ${SERVER_DIR}/${ROOT_DIR}/
		touch ${SERVER_DIR}/${ROOT_DIR}/.unzip
	fi
}

function COPY_JAR {
	cp ${JAR_DIR}/${JAR_FILE} ${SERVER_DIR}/${ROOT_DIR}/
}

if [ $JAR_FILE == 'pocketmine.jar' ]; then
	ROOT_DIR=jars
	MAKE_ROOT
elif [ $JAR_FILE == 'my.jar' ]; then
	ROOT_DIR=jars
	MAKE_ROOT
	EULA
elif [ $JAR_FILE == 'minecraft_server.jar' ]; then
	ROOT_DIR=Vanilla
	MAKE_ROOT
	COPY_JAR
	EULA
elif [ $JAR_FILE == 'craftbukkit.jar' ]; then
	ROOT_DIR=CraftBukkit
	MAKE_ROOT
	COPY_JAR
elif [ $JAR_FILE == 'craftbukkit_beta.jar' ]; then
	ROOT_DIR=CraftBukkitBeta
	MAKE_ROOT
	COPY_JAR
elif [ $JAR_FILE == 'craftbukkit_dev.jar' ]; then
	ROOT_DIR=CraftBukkitDev
	MAKE_ROOT
	COPY_JAR
elif [ $JAR_FILE == '800craft.jar' ]; then
	ROOT_DIR=800craft
	MAKE_ROOT
	ZIP_FILE=800craft.zip
	UNZIP
elif [ $JAR_FILE == 'fCraft.jar' ]; then
	ROOT_DIR=fCraft
	MAKE_ROOT
	ZIP_FILE=fCraft.zip
	UNZIP
elif [ $JAR_FILE == 'FTB.jar' ]; then
	ROOT_DIR=FeedTheBeast
	MAKE_ROOT
	ZIP_FILE=FTBUltimate.zip
	UNZIP
elif [ $JAR_FILE == 'Dire.jar' ]; then
	ROOT_DIR=Dire
	MAKE_ROOT
	ZIP_FILE=Direwolf20_Server.zip
	UNZIP
elif [ $JAR_FILE == 'YogCraft.jar' ]; then
	ROOT_DIR=YogCraft
	MAKE_ROOT
	ZIP_FILE=YogCraft.zip
	UNZIP
elif [ $JAR_FILE == 'Unhinged.jar' ]; then
	ROOT_DIR=Unhinged
	MAKE_ROOT
	ZIP_FILE=Unhinged.zip
	UNZIP
elif [ $JAR_FILE == 'Unleashed.jar' ]; then
	ROOT_DIR=Unleashed
	MAKE_ROOT
	ZIP_FILE=Unleashed.zip
	UNZIP
elif [ $JAR_FILE == 'BTeam.jar' ]; then
	ROOT_DIR=BTeam
	MAKE_ROOT
	ZIP_FILE=BTeam.zip
	UNZIP
elif [ $JAR_FILE == 'MindCrack.jar' ]; then
	ROOT_DIR=MindCrack
	MAKE_ROOT
	ZIP_FILE=MindCrack.zip
	UNZIP
elif [ $JAR_FILE == 'Voltz.jar' ]; then
	ROOT_DIR=Voltz
	MAKE_ROOT
	ZIP_FILE=Voltz_Server.zip
	UNZIP
elif [ $JAR_FILE == 'hexxit.jar' ]; then
	ROOT_DIR=Hexxit
	MAKE_ROOT
	ZIP_FILE=Hexxit.zip
	UNZIP
elif [ $JAR_FILE == 'tekkit.jar' ]; then
	ROOT_DIR=Tekkit
	MAKE_ROOT
	ZIP_FILE=Tekkit_Server.zip
	UNZIP
elif [ $JAR_FILE == 'TekkitBigDig.jar' ]; then
	ROOT_DIR=Tekkit_BigDig
	MAKE_ROOT
	ZIP_FILE=Tekkit_BigDig.zip
	UNZIP
elif [ $JAR_FILE == 'TekkitClassic.jar' ]; then
	ROOT_DIR=Tekkit_Classic
	MAKE_ROOT
	ZIP_FILE=Tekkit_Classic.zip
	UNZIP
elif [ $JAR_FILE == 'tekkit_lite.jar' ]; then
	ROOT_DIR=Tekkit_Lite
	MAKE_ROOT
	ZIP_FILE=Tekkit_Lite.zip
	UNZIP
elif [ $JAR_FILE == 'tshock.jar' ]; then
	ROOT_DIR=TShock
	MAKE_ROOT
	ZIP_FILE=tshock.zip
	UNZIP
elif [ $JAR_FILE == 'teamspeak.jar' ]; then
	ROOT_DIR=TeamSpeak3
	MAKE_ROOT
	ZIP_FILE=TeamSpeak3.zip
	UNZIP
elif [[ $JAR_FILE == 'left4dead2.jar' || $JAR_FILE == 'garrysmod.jar' || $JAR_FILE == 'tf2.jar' || $JAR_FILE == 'hl2mp.jar' || $JAR_FILE == 'cstrikesource.jar' ]]; then
	ROOT_DIR=Steam
	MAKE_ROOT
	ZIP_FILE=steamcmd.zip
	UNZIP
elif [ $JAR_FILE == 'samp.jar' ]; then 
	ROOT_DIR=Samp
	MAKE_ROOT
	ZIP_FILE=samp.zip
	UNZIP
	for PID in $(ps -ef | grep "$SERVER_DIR" | grep -v grep | awk '{print $2}'); do
        	kill -9 $PID
	done
elif [ $JAR_FILE == 'mcpc-plus164.jar' ]; then
	ROOT_DIR=MCPC_PLUS164
	MAKE_ROOT
	COPY_JAR
elif [ $JAR_FILE == 'cauldron.jar' ]; then
	ROOT_DIR=Cauldron
	MAKE_ROOT
	ZIP_FILE=Cauldron.zip
	UNZIP
	EULA
elif [ $JAR_FILE == 'Forge.jar' ]; then
	ROOT_DIR=Forge
	MAKE_ROOT
	ZIP_FILE=Forge.zip
	UNZIP
	EULA
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
