//
//  RC BARNSTORM - A demonstration vehicle vs vehicle script for SA-MP 0.2
//  -- by kyeman (SA-MP team) 2007
//
//  This script demonstrates the following :-
//  - An automatic vehicle observer mode switchable via a key press.
//  - Text drawing and the use of GTA ~k~ key constants.
//  - Use of RC vehicles
//  - Dynamic creation and destruction of vehicles
//  - The OnPlayerKeyStateChange event/callback and determining
//    if a key has just been pressed.
//  - Bypassing SA-MP's class selection with SetSpawnInfo

#include <a_samp>
#include <core>
#include <float>

new gPlayerVehicles[MAX_PLAYERS]; // the vehicleid for the active playerid
new gPlayerObserving[MAX_PLAYERS]; // player observing which active player
new Text:txtObsHelper;

new Float:gSpawnPositions[26][4] = { // positions where players in vehicles spawn
{-205.7703,-119.6655,2.4094,342.0546},
{-202.1386,-54.1213,2.4111,95.6799},
{-197.2334,7.5293,2.4034,16.0852},
{-135.7348,61.7265,2.4112,354.3534},
{-73.7883,73.4238,2.4082,260.5399},
{-6.9850,27.9988,2.4112,201.7691},
{0.6782,-16.0898,2.4076,161.7720},
{-46.3365,-88.3937,2.4092,180.7382},
{-72.4389,-127.2939,2.4107,113.5616},
{-128.1940,-144.1725,2.4094,78.9676},
{-266.0189,-50.6718,2.4125,223.8079},
{-244.2617,-1.0468,2.1038,257.3333},
{-93.3146,-32.4889,2.4085,186.0631},
{-130.7054,-93.4983,2.4124,73.8375},
{-117.4049,4.2989,2.4112,337.1284},
{-26.1622,135.8739,2.4094,248.1580},
{45.5705,86.7586,2.0753,147.3342},
{54.9881,2.2997,1.1132,95.7173},
{-248.9905,-119.3982,2.4083,303.7859},
{-60.1321,55.5239,2.4038,325.2209},
{-60.9184,47.9302,5.7706,342.8299},
{-70.0303,-22.0071,2.4113,165.2789},
{-138.3093,-83.2640,2.4152,4.0455},
{-25.5989,94.6100,2.4041,150.8322},
{-161.0327,-70.5945,2.4042,142.9221},
{-54.8308,-139.6148,2.4119,258.7639}
};

//------------------------------------------------------------------------------------------------------

main()
{
	print("Running: RC BARNSTORM by kyeman 2007");
}

//------------------------------------------------
// ObserverSwitchToNextVehicle
// Will increment the current observed player
// until it finds a new player with an active vehicle.

ObserverSwitchToNextVehicle(playerid)
{
	new x=0;
	while(x!=MAX_PLAYERS) { // MAX_PLAYERS iterations
	    gPlayerObserving[playerid]++;
	    if(gPlayerObserving[playerid] == MAX_PLAYERS) {
			// we need to cycle back to the start
			gPlayerObserving[playerid] = 0;
		}
		// see if the target player has a vehicle,
		// if so assign this player to observe it
		if(gPlayerVehicles[gPlayerObserving[playerid]] != 0) {
			PlayerSpectateVehicle(playerid,gPlayerVehicles[gPlayerObserving[playerid]]);
			return;
		}
		x++;
	}
	// didn't find any vehicles to observe. we'll have to default to last
	PlayerSpectateVehicle(playerid,gPlayerVehicles[gPlayerObserving[playerid]]);
}

//------------------------------------------------
// IsKeyJustDown. Returns 1 if the key
// has just been pressed, 0 otherwise.

IsKeyJustDown(key, newkeys, oldkeys)
{
	if((newkeys & key) && !(oldkeys & key)) return 1;
	return 0;
}

//------------------------------------------------

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(gPlayerObserving[playerid] >= 0 && IsKeyJustDown(KEY_SPRINT,newkeys,oldkeys)) {
		// They're requesting to spawn, so take them out of observer mode
		// this will cause them to spawn automatically, using the SpawnInfo
		// we previously forced upon them during OnPlayerRequestClass
		TogglePlayerSpectating(playerid,0);
		gPlayerObserving[playerid] = (-1);
		SendClientMessage(playerid,0xFFFFFFFF,"Leaving spectate");
		return;
	}
	
	if(gPlayerObserving[playerid] >= 0 && IsKeyJustDown(KEY_FIRE,newkeys,oldkeys)) {
	   // They're requesting to change observer to another vehicle.
	   ObserverSwitchToNextVehicle(playerid);
	}
}

//------------------------------------------------

public OnPlayerConnect(playerid)
{
	GameTextForPlayer(playerid,"~w~SA-MP: ~r~RC Barnstorm",5000,5);
	
	return 1;
}

//------------------------------------------------

public OnPlayerDisconnect(playerid)
{
	if(gPlayerVehicles[playerid]) {
	    // Make sure their vehicle is destroyed when they leave.
    	DestroyVehicle(gPlayerVehicles[playerid]);
    	gPlayerVehicles[playerid] = 0;
	}
	return 0;
}

//------------------------------------------------
//rcbarron = 464

public OnPlayerSpawn(playerid)
{
	// Create their own vehicle and put them in
    gPlayerVehicles[playerid] = CreateVehicle(464,
						gSpawnPositions[playerid][0],
						gSpawnPositions[playerid][1],
						gSpawnPositions[playerid][2],
						gSpawnPositions[playerid][3],
						-1,-1,10);

    PutPlayerInVehicle(playerid,gPlayerVehicles[playerid],0);
    //ForceClassSelection(playerid); // for next time they respawn
    TextDrawHideForPlayer(playerid, txtObsHelper);
    SetPlayerWorldBounds(playerid,200.0,-300.0,200.0,-200.0);
   	return 1;
}

//------------------------------------------------

public OnPlayerDeath(playerid, killerid, reason)
{
	// We need to cleanup their vehicle
	RemovePlayerFromVehicle(gPlayerVehicles[playerid]);
	DestroyVehicle(gPlayerVehicles[playerid]);
	gPlayerVehicles[playerid] = 0;
	
	// Send the death information to all clients
	SendDeathMessage(killerid,playerid,reason);

    // If anyone was observing them, they'll have to switch to the next
    new x=0;
    while(x!=MAX_PLAYERS) {
        if(x != playerid && gPlayerObserving[x] == playerid) {
            ObserverSwitchToNextVehicle(x);
		}
		x++;
	}

 	return 1;
}

//------------------------------------------------

public OnPlayerRequestClass(playerid, classid)
{
	// put them straight into observer mode, effectively
	// bypassing class selection.
 	TogglePlayerSpectating(playerid,1);
    ObserverSwitchToNextVehicle(playerid);
    TextDrawShowForPlayer(playerid, txtObsHelper);

    // also force this dud spawn info upon them so that they
    // have spawn information set.
    SetSpawnInfo(playerid,0,0,
			gSpawnPositions[playerid][0],
			gSpawnPositions[playerid][1],
			gSpawnPositions[playerid][2],
			gSpawnPositions[playerid][3],
			-1,-1,-1,-1,-1,-1);
    
	return 0;
}

//------------------------------------------------

public OnGameModeInit()
{
	SetGameModeText("RC Barnstorm");

	// General settings for the gamemode
	ShowPlayerMarkers(0);
	ShowNameTags(1);
	SetWorldTime(7);
	SetWeather(5);

	// Add a dud player class
	AddPlayerClass(0,0.0,0.0,4.0,0.0,-1,-1,-1,-1,-1,-1);
	
	// Init our globals
	new x=0;
	while(x!=MAX_PLAYERS) {
	    gPlayerVehicles[x] = 0;
	    gPlayerObserving[x] = (-1);
	    x++;
	}
	
	// Init our observer helper text display
	txtObsHelper = TextDrawCreate(20.0, 400.0,
	"Press ~b~~k~~PED_SPRINT~ ~w~to spawn~n~Press ~b~~k~~PED_FIREWEAPON~ ~w~to switch players");
	TextDrawUseBox(txtObsHelper, 0);
	TextDrawFont(txtObsHelper, 2);
	TextDrawSetShadow(txtObsHelper,0);
    TextDrawSetOutline(txtObsHelper,1);
    TextDrawBackgroundColor(txtObsHelper,0x000000FF);
    TextDrawColor(txtObsHelper,0xFFFFFFFF);
    
	return 1;
}

//------------------------------------------------

public OnPlayerUpdate(playerid)
{
	/*
	new Keys,ud,lr;
	
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING) {
	    GetPlayerKeys(playerid,Keys,ud,lr);
	    if(ud > 0) {
	        SendClientMessage(playerid, 0xFFFFFFFF, "DOWN");
		}
		else if(ud < 0) {
		    SendClientMessage(playerid, 0xFFFFFFFF, "UP");
		}
		
		if(lr > 0) {
	        SendClientMessage(playerid, 0xFFFFFFFF, "RIGHT");
		}
		else if(lr < 0) {
		    SendClientMessage(playerid, 0xFFFFFFFF, "LEFT");
		}
	}*/
	
	return 1;
}

//------------------------------------------------
