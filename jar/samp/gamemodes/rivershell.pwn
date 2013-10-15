//---------------------------------------------------------
//
// Rivershell by Kye - 2006
//
// Updated 2009 for SA-MP 0.3
//
//---------------------------------------------------------

#include <a_samp>
#include <core>
#include <float>

// Global stuff and defines for our gamemode.

static gTeam[MAX_PLAYERS]; // Tracks the team assignment for each player

#define OBJECTIVE_VEHICLE_GREEN 2
#define OBJECTIVE_VEHICLE_BLUE 1
#define TEAM_GREEN 1
#define TEAM_BLUE 2
#define OBJECTIVE_COLOR 0xE2C063FF
#define TEAM_GREEN_COLOR 0x77CC77FF
#define TEAM_BLUE_COLOR 0x7777DDFF
#define CAPS_TO_WIN 3

new gObjectiveReached = 0; // Stops the winner logic reentering itself.
new gObjectiveGreenPlayer=(-1); // Tracks which green player has the vehicle.
new gObjectiveBluePlayer=(-1); // Tracks which blue player has the vehicle.

// number of times the vehicle has been captured by each team
new gGreenTimesCapped=0;
new gBlueTimesCapped=0;

// forward declarations for the PAWN compiler (not really needed, but there for the sake of clarity)
forward SetPlayerToTeamColor(playerid);
forward SetupPlayerForClassSelection(playerid);
forward SetPlayerTeamFromClass(playerid,classid);
forward ExitTheGameMode();

//---------------------------------------------------------

main()
{
	print("\n----------------------------------");
	print("  Rivershell by Kye 2006\n");
	print("----------------------------------\n");
}
//---------------------------------------------------------

public SetPlayerToTeamColor(playerid)
{
	if(gTeam[playerid] == TEAM_GREEN) {
		SetPlayerColor(playerid,TEAM_GREEN_COLOR); // green
	} else if(gTeam[playerid] == TEAM_BLUE) {
	    SetPlayerColor(playerid,TEAM_BLUE_COLOR); // blue
	}
}
//---------------------------------------------------------

public SetupPlayerForClassSelection(playerid)
{
	// Set the player's orientation when they're selecting a class.
	SetPlayerPos(playerid,1984.4445,157.9501,55.9384);
    SetPlayerCameraPos(playerid,1984.4445,160.9501,55.9384);
	SetPlayerCameraLookAt(playerid,1984.4445,157.9501,55.9384);
	SetPlayerFacingAngle(playerid,0.0);
}

//---------------------------------------------------------

public SetPlayerTeamFromClass(playerid,classid)
{
	// Set their team number based on the class they selected.
	if(classid == 0 || classid == 1) {
		gTeam[playerid] = TEAM_GREEN;
	} else if(classid == 2 || classid == 3) {
	    gTeam[playerid] = TEAM_BLUE;
	}
}

//---------------------------------------------------------

public ExitTheGameMode()
{
    PlaySoundForAll(1186, 0.0, 0.0, 0.0); // Stops the music
	//printf("Exiting Game Mode");
    GameModeExit();
}

//---------------------------------------------------------

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	new vehicleid;

	if(newstate == PLAYER_STATE_DRIVER)
	{
		vehicleid = GetPlayerVehicleID(playerid);
		
		if(gTeam[playerid] == TEAM_GREEN && vehicleid == OBJECTIVE_VEHICLE_GREEN)
		{ // It's the objective vehicle
		    SetPlayerColor(playerid,OBJECTIVE_COLOR);
		    GameTextForPlayer(playerid,"~w~Take the ~y~boat ~w~back to the ~r~spawn!",3000,5);
		    SetPlayerCheckpoint(playerid,1982.6150,-220.6680,-0.2432,7.0);
		    gObjectiveGreenPlayer = playerid;
		}
		
		if(gTeam[playerid] == TEAM_BLUE && vehicleid == OBJECTIVE_VEHICLE_BLUE)
		{ // It's the objective vehicle
		    SetPlayerColor(playerid,OBJECTIVE_COLOR);
		    GameTextForPlayer(playerid,"~w~Take the ~y~boat ~w~back to the ~r~spawn!",3000,5);
		    SetPlayerCheckpoint(playerid,2328.2935,531.8324,0.0094,7.0);
		    gObjectiveBluePlayer = playerid;
		}
	}
	else if(newstate == PLAYER_STATE_ONFOOT)
	{
		if(playerid == gObjectiveGreenPlayer) {
		    gObjectiveGreenPlayer = (-1);
		    SetPlayerToTeamColor(playerid);
	  		DisablePlayerCheckpoint(playerid);
		}
		
		if(playerid == gObjectiveBluePlayer) {
		    gObjectiveBluePlayer = (-1);
		    SetPlayerToTeamColor(playerid);
		    DisablePlayerCheckpoint(playerid);
		}
	}

    return 1;
}

//---------------------------------------------------------

public OnGameModeInit()
{
	SetGameModeText("Rivershell");
	
	ShowPlayerMarkers(1);
	ShowNameTags(1);
	SetWorldTime(17);

	// GREEN CLASSES
	AddPlayerClass(162,1980.0054,-266.6487,2.9653,348.9788,0,0,31,400,29,400);
	AddPlayerClass(157,1980.0054,-266.6487,2.9653,348.9788,0,0,31,400,29,400);

 	// BLUE CLASSES
	AddPlayerClass(154,2359.2703,540.5911,1.7969,180.6476,0,0,31,400,29,400);
	AddPlayerClass(138,2294.0413,541.8565,1.7944,188.6283,0,0,31,400,29,400);

	// OBJECTIVE VEHICLES
    AddStaticVehicle(453,2057.0154,-236.5598,-0.2621,359.4377,114,1); // gr reefer
	AddStaticVehicle(453,2381.9685,532.4496,0.2574,183.2029,79,7); // b reefer

    // GREEN VEHICLES
    AddStaticVehicle(473,2023.5109,-246.4161,-0.1514,351.0038,114,1); // gr dhin
    AddStaticVehicle(473,1949.2490,-259.5398,-0.2794,13.3247,114,1); // gr ding2fix
	AddStaticVehicle(473,2003.7256,-248.4939,-0.2243,5.1752,114,1); // gr ding
	AddStaticVehicle(473,1982.4832,-252.4811,-0.3006,358.3696,114,1); // gr ding
	AddStaticVehicle(473,1927.7894,-249.3088,-0.2893,320.7715,114,1); // gr ding
	AddStaticVehicle(473,1907.6969,-230.4202,-0.2585,306.0136,114,1); // gr ding
	AddStaticVehicle(487,1913.0819,-376.2350,21.4819,350.9412,114,1); // gr mav

	// BLUE VEHICLES
	AddStaticVehicle(473,2289.7571,518.4412,-0.2167,178.8301,79,7); // b ding
	AddStaticVehicle(473,2294.3599,519.1021,-0.1391,177.1416,79,7); // b ding
	AddStaticVehicle(473,2298.8411,518.4229,-0.2333,181.1228,79,7); // b ding
	AddStaticVehicle(473,2369.9839,519.0364,-0.3190,187.9187,79,7); // b ding
	AddStaticVehicle(473,2359.9417,519.1055,-0.2271,183.8014,79,7); // b ding
	AddStaticVehicle(473,2351.4617,519.1046,-0.1172,182.8623,79,7); // b ding
	AddStaticVehicle(487,2324.4399,573.1667,7.9578,177.6699,79,7); // b mav

   return 1;
}

//---------------------------------------------------------

public OnPlayerConnect(playerid)
{
	SetPlayerColor(playerid,0x888888FF);
	GameTextForPlayer(playerid,"~r~SA-MP:~w~Rivershell",2000,5);
	return 1;
}

//---------------------------------------------------------

public OnPlayerRequestClass(playerid, classid)
{
	SetupPlayerForClassSelection(playerid);
	SetPlayerTeamFromClass(playerid,classid);
	
	if(classid == 0 || classid == 1) {
		GameTextForPlayer(playerid,"~g~GREEN ~w~TEAM",1000,5);
	} else if(classid == 2 || classid == 3) {
	    GameTextForPlayer(playerid,"~b~BLUE ~w~TEAM",1000,5);
	}
	
	return 1;
}

//---------------------------------------------------------

public OnPlayerSpawn(playerid)
{
	SetPlayerToTeamColor(playerid);

	if(gTeam[playerid] == TEAM_GREEN) {
	    SetPlayerWorldBounds(playerid,2444.4185,1687.5696,631.2963,-454.9898);
	    GameTextForPlayer(playerid,
		   "Defend the ~g~GREEN ~w~team's ~y~Reefer~n~~w~Capture the ~b~BLUE ~w~team's ~y~Reefer",
		   6000,5);
	}
	else if(gTeam[playerid] == TEAM_BLUE) {
		SetPlayerWorldBounds(playerid,2444.4185,1687.5696,631.2963,-454.9898);
	    GameTextForPlayer(playerid,
		   "Defend the ~b~BLUE ~w~team's ~y~Reefer~n~~w~Capture the ~g~GREEN ~w~team's ~y~Reefer",
		   6000,5);
	}

	return 1;
}

//---------------------------------------------------------

public OnPlayerEnterCheckpoint(playerid)
{
 	new playervehicleid = GetPlayerVehicleID(playerid);
 	
 	if(gObjectiveReached) return;
 	
	if(playervehicleid == OBJECTIVE_VEHICLE_GREEN && gTeam[playerid] == TEAM_GREEN)
	{   // Green OBJECTIVE REACHED.
	    gGreenTimesCapped++;
	    SetPlayerScore(playerid,GetPlayerScore(playerid)+5);
	    
	    if(gGreenTimesCapped==CAPS_TO_WIN) {
	        GameTextForAll("~g~GREEN ~w~team wins!",3000,5);
			gObjectiveReached = 1;	PlaySoundForAll(1185, 0.0, 0.0, 0.0);
 			SetTimer("ExitTheGameMode", 6000, 0); // Set up a timer to exit this mode.
		} else {
		    GameTextForAll("~g~GREEN ~w~team captured the ~y~boat!",3000,5);
		    SetVehicleToRespawn(OBJECTIVE_VEHICLE_GREEN);
		}
	    return;
	}
	else if(playervehicleid == OBJECTIVE_VEHICLE_BLUE && gTeam[playerid] == TEAM_BLUE)
	{   // Blue OBJECTIVE REACHED.
	    gBlueTimesCapped++;
	    SetPlayerScore(playerid,GetPlayerScore(playerid)+5);
	    
	    if(gBlueTimesCapped==CAPS_TO_WIN) {
	        GameTextForAll("~b~BLUE ~w~team wins!",3000,5);
	        gObjectiveReached = 1;	PlaySoundForAll(1185, 0.0, 0.0, 0.0);
			SetTimer("ExitTheGameMode", 6000, 0); // Set up a timer to exit this mode.
		} else {
		    GameTextForAll("~b~BLUE ~w~team captured the ~y~boat!",3000,5);
		    SetVehicleToRespawn(OBJECTIVE_VEHICLE_BLUE);
		}
	    return;
	}
}

//---------------------------------------------------------

public OnPlayerDeath(playerid, killerid, reason)
{
	if(killerid == INVALID_PLAYER_ID) {
        SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
	} else {
        if(gTeam[killerid] != gTeam[playerid]) {
	    	// Valid kill
	    	SendDeathMessage(killerid,playerid,reason);
			SetPlayerScore(killerid,GetPlayerScore(killerid)+1);
     	}
		else {
		    // Team kill
		    SendDeathMessage(killerid,playerid,reason);
		}
	}
 	return 1;
}


//---------------------------------

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	// Note for SA-MP 0.3:
	// As the vehicle streams in, player team dependant params are applied. They can't be
	// applied to vehicles that don't exist in the player's world.
	
    if(vehicleid == OBJECTIVE_VEHICLE_BLUE) {
        if(gTeam[forplayerid] == TEAM_GREEN) {
			SetVehicleParamsForPlayer(OBJECTIVE_VEHICLE_BLUE,forplayerid,1,1); // objective; locked
		}
		else if(gTeam[forplayerid] == TEAM_BLUE) {
		    SetVehicleParamsForPlayer(OBJECTIVE_VEHICLE_BLUE,forplayerid,1,0); // objective; unlocked
		}
	}
	else if(vehicleid == OBJECTIVE_VEHICLE_GREEN) {
        if(gTeam[forplayerid] == TEAM_BLUE) {
			SetVehicleParamsForPlayer(OBJECTIVE_VEHICLE_GREEN,forplayerid,1,1); // objective; locked
		}
		else if(gTeam[forplayerid] == TEAM_GREEN) {
		    SetVehicleParamsForPlayer(OBJECTIVE_VEHICLE_GREEN,forplayerid,1,0); // objective; unlocked
		}
	}
	
	return 1;
	//printf("GameMode: VehicleStreamIn(%d,%d)",vehicleid,forplayerid);
}

//---------------------------------

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
	//printf("GameMode: VehicleStreamOut(%d,%d)",vehicleid,forplayerid);
}

//---------------------------------

PlaySoundForAll(soundid, Float:x, Float:y, Float:z)
{
	for (new i=0; i<MAX_PLAYERS; i++)
	{
	    if (IsPlayerConnected(i))
	    {
		    PlayerPlaySound(i, soundid, x, y, z);
	    }
	}
}

//---------------------------------
