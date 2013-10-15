//-------------------------------------------------
//
//  NPC initialisation for Grand Larceny
//
//-------------------------------------------------

#pragma tabsize 0
#include <a_samp>

//-------------------------------------------------

public OnFilterScriptInit()
{
	ConnectNPC("TrainDriverLV","train_lv");
	ConnectNPC("TrainDriverLS","train_ls");
	ConnectNPC("TrainDriverSF","train_sf");
	
	ConnectNPC("PilotLV","at400_lv");
	ConnectNPC("PilotSF","at400_sf");
	ConnectNPC("PilotLS","at400_ls");

	// Testing
	//ConnectNPC("TestIdle","onfoot_test");
	//ConnectNPC("TaxiTest","mat_test");
	
	return 1;
}

//-------------------------------------------------
// IMPORTANT: This restricts NPCs connecting from
// an IP address outside this server. If you need
// to connect NPCs externally you will need to modify
// the code in this callback.

public OnPlayerConnect(playerid)
{
	if(IsPlayerNPC(playerid)) {
	    new ip_addr_npc[64+1];
	    new ip_addr_server[64+1];
	    GetServerVarAsString("bind",ip_addr_server,64);
	    GetPlayerIp(playerid,ip_addr_npc,64);
	    
		if(!strlen(ip_addr_server)) {
		    ip_addr_server = "127.0.0.1";
		}
		
		if(strcmp(ip_addr_npc,ip_addr_server,true) != 0) {
		    // this bot is remote connecting
		    printf("NPC: Got a remote NPC connecting from %s and I'm kicking it.",ip_addr_npc);
		    Kick(playerid);
		    return 0;
		}
        printf("NPC: Connection from %s is allowed.",ip_addr_npc);
	}
	
	return 1;
}

//-------------------------------------------------

public OnPlayerRequestClass(playerid, classid)
{
	if(!IsPlayerNPC(playerid)) return 0; // We only deal with NPC players in this script
	
	new playername[64];
	GetPlayerName(playerid,playername,64);

 	if(!strcmp(playername,"TrainDriverLV",true)) {
        SetSpawnInfo(playerid,69,255,1462.0745,2630.8787,10.8203,0.0,-1,-1,-1,-1,-1,-1);
	}
	else if(!strcmp(playername,"TrainDriverSF",true)) {
	    SetSpawnInfo(playerid,69,255,-1942.7950,168.4164,27.0006,0.0,-1,-1,-1,-1,-1,-1);
	}
	else if(!strcmp(playername,"TrainDriverLS",true)) {
	    SetSpawnInfo(playerid,69,255,1700.7551,-1953.6531,14.8756,0.0,-1,-1,-1,-1,-1,-1);
	}
	else if(!strcmp(playername,"PilotLV",true)) {
	    SetSpawnInfo(playerid,69,61,0.0,0.0,0.0,0.0,-1,-1,-1,-1,-1,-1);
	}
	else if(!strcmp(playername,"PilotSF",true)) {
	    SetSpawnInfo(playerid,69,61,0.0,0.0,0.0,0.0,-1,-1,-1,-1,-1,-1);
	}
	else if(!strcmp(playername,"PilotLS",true)) {
	    SetSpawnInfo(playerid,69,61,0.0,0.0,0.0,0.0,-1,-1,-1,-1,-1,-1);
	}
	else if(!strcmp(playername,"TestIdleDriver",true)) {
	    SetSpawnInfo(playerid,69,61,0.0,0.0,0.0,0.0,-1,-1,-1,-1,-1,-1);
	}
	else if(!strcmp(playername,"TaxiTest",true)) {
	    SetSpawnInfo(playerid,69,61,0.0,0.0,0.0,0.0,-1,-1,-1,-1,-1,-1);
	}

	return 0;
}

//-------------------------------------------------

public OnPlayerSpawn(playerid)
{
	if(!IsPlayerNPC(playerid)) return 1; // We only deal with NPC players in this script

	new playername[64];
	GetPlayerName(playerid,playername,64);

	if(!strcmp(playername,"TrainDriverLV",true)) {
        PutPlayerInVehicle(playerid,1,0);
        SetPlayerColor(playerid,0xFFFFFFFF);
 	}
	else if(!strcmp(playername,"TrainDriverSF",true)) {
	    PutPlayerInVehicle(playerid,5,0);
	    SetPlayerColor(playerid,0xFFFFFFFF);
	}
	else if(!strcmp(playername,"TrainDriverLS",true)) {
	    PutPlayerInVehicle(playerid,9,0);
	    SetPlayerColor(playerid,0xFFFFFFFF);
	}
	else if(!strcmp(playername,"PilotLV",true)) {
	    PutPlayerInVehicle(playerid,13,0);
	    SetPlayerColor(playerid,0xFFFFFFFF);
	}
	else if(!strcmp(playername,"PilotSF",true)) {
	    PutPlayerInVehicle(playerid,14,0);
	    SetPlayerColor(playerid,0xFFFFFFFF);
	}
	else if(!strcmp(playername,"PilotLS",true)) {
	    PutPlayerInVehicle(playerid,15,0);
	    SetPlayerColor(playerid,0xFFFFFFFF);
	}
	else if(!strcmp(playername,"TestIdleDriver",true)) {
	    PutPlayerInVehicle(playerid,43,0);
	    SetPlayerColor(playerid,0xFFFFFFFF);
	}
	else if(!strcmp(playername,"TaxiTest",true)) {
	    PutPlayerInVehicle(playerid,968,0);
	    SetPlayerColor(playerid,0xFFFFFFFF);
	}

	return 1;
}

//-------------------------------------------------
// EOF


