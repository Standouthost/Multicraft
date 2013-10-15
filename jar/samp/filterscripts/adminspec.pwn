//
//  ADMIN SPECTATE FILTER SCRIPT
//  kye 2007
//

#pragma tabsize 0
#include <a_samp>
#include <core>
#include <float>

#include "../include/gl_common.inc"

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFFF

//------------------------------------------------------------------------------------------------------

#define ADMIN_SPEC_TYPE_NONE 0
#define ADMIN_SPEC_TYPE_PLAYER 1
#define ADMIN_SPEC_TYPE_VEHICLE 2

new gSpectateID[MAX_PLAYERS];
new gSpectateType[MAX_PLAYERS];

//------------------------------------------------------------------------------------------------------

public OnFilterScriptInit()
{
}

//------------------------------------------------------------------------------------------------------

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	// IF ANYONE IS SPECTATING THIS PLAYER, WE'LL ALSO HAVE
	// TO CHANGE THEIR INTERIOR ID TO MATCH
	new x = 0;
	while(x!=MAX_PLAYERS) {
	    if( IsPlayerConnected(x) &&	GetPlayerState(x) == PLAYER_STATE_SPECTATING &&
			gSpectateID[x] == playerid && gSpectateType[x] == ADMIN_SPEC_TYPE_PLAYER )
   		{
   		    SetPlayerInterior(x,newinteriorid);
		}
		x++;
	}
}

//------------------------------------------------------------------------------------------------------

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256];
	new specplayerid, specvehicleid, idx;

	// WE ONLY DEAL WITH COMMANDS FROM ADMINS IN THIS FILTERSCRIPT
	if(!IsPlayerAdmin(playerid)) return 0;

	cmd = strtok(cmdtext, idx);

	// SPECTATE A PLAYER
 	if(strcmp(cmd, "/specplayer", true) == 0) {
	    new tmp[256];
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /specplayer [playerid]");
			return 1;
		}
		specplayerid = strval(tmp);
		
		if(!IsPlayerConnected(specplayerid)) {
		    SendClientMessage(playerid, COLOR_RED, "specplayer: that player isn't active.");
			return 1;
		}
		
		TogglePlayerSpectating(playerid, 1);
		PlayerSpectatePlayer(playerid, specplayerid);
		SetPlayerInterior(playerid,GetPlayerInterior(specplayerid));
		gSpectateID[playerid] = specplayerid;
		gSpectateType[playerid] = ADMIN_SPEC_TYPE_PLAYER;
		
 		return 1;
	}

	// SPECTATE A VEHICLE
 	if(strcmp(cmd, "/specvehicle", true) == 0) {
	    new tmp[256];
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /specvehicle [vehicleid]");
			return 1;
		}
		specvehicleid = strval(tmp);
		
		if(specvehicleid < MAX_VEHICLES) {
			TogglePlayerSpectating(playerid, 1);
			PlayerSpectateVehicle(playerid, specvehicleid);
			gSpectateID[playerid] = specvehicleid;
			gSpectateType[playerid] = ADMIN_SPEC_TYPE_VEHICLE;
		}
 		return 1;
	}

	// STOP SPECTATING
 	if(strcmp(cmd, "/specoff", true) == 0) {
		TogglePlayerSpectating(playerid, 0);
		gSpectateID[playerid] = INVALID_PLAYER_ID;
		gSpectateType[playerid] = ADMIN_SPEC_TYPE_NONE;
		return 1;
	}

	return 0;
}

//------------------------------------------------------------------------------------------------------


