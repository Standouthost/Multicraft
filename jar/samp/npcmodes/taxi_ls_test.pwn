//
// A test driver NPC with very basic AI
// Kye 2009
//

#include <a_npc>

new gStoppedForTraffic = 0;
new gPlaybackActive = 0;

public ScanTimer();

#define AHEAD_OF_CAR_DISTANCE    11.0
#define SCAN_RADIUS     		 11.0

//------------------------------------------

main(){}

//------------------------------------------

stock GetXYInfrontOfMe(Float:distance, &Float:x, &Float:y)
{
    new Float:z, Float:angle;
    GetMyPos(x,y,z);
    GetMyFacingAngle(angle);
    x += (distance * floatsin(-angle, degrees));
    y += (distance * floatcos(-angle, degrees));
}

//------------------------------------------

public OnNPCModeInit()
{
	SetTimer("ScanTimer",200,1);
}

//------------------------------------------

LookForAReasonToPause()
{
  	new Float:X,Float:Y,Float:Z;
	new x=0;
	
	GetMyPos(X,Y,Z);
	GetXYInfrontOfMe(AHEAD_OF_CAR_DISTANCE,X,Y);
	
	while(x!=MAX_PLAYERS) {
	    if(IsPlayerConnected(x) && IsPlayerStreamedIn(x)) {
			if( GetPlayerState(x) == PLAYER_STATE_DRIVER ||
			    GetPlayerState(x) == PLAYER_STATE_ONFOOT )
			{
				if(IsPlayerInRangeOfPoint(x,SCAN_RADIUS,X,Y,Z)) {
					return 1;
				}
			}
		}
		x++;
	}
	
	//new msg[256];
	//new Float:angle;
	//GetMyFacingAngle(angle);
	//format(msg,256,"My yaw/heading = %f",angle);
	//SendChat(msg);
	
	return 0;
}


//------------------------------------------

public ScanTimer()
{
	//new ticker = GetTickCount() - g_LastTick;
    //printf("npctest: timer (%d)ms", ticker);
    //g_LastTick = GetTickCount();
    
    new ReasonToPause = LookForAReasonToPause();
    
	if(ReasonToPause && !gStoppedForTraffic)
	{
	    //SendChat("I'm pausing");
		PauseRecordingPlayback();
		gStoppedForTraffic = 1;
	}
	else if(!ReasonToPause && gStoppedForTraffic)
	{
	    //SendChat("I'm resuming");
	    ResumeRecordingPlayback();
	    gStoppedForTraffic = 0;
	}
}


//------------------------------------------

StartPlayback()
{
	StartRecordingPlayback(PLAYER_RECORDING_TYPE_DRIVER,"taxi_test_1282");
	gStoppedForTraffic = 0;
	gPlaybackActive = 1;
}
	

//------------------------------------------

public OnRecordingPlaybackEnd()
{
    StartPlayback();
}

//------------------------------------------

public OnNPCEnterVehicle(vehicleid, seatid)
{
    StartPlayback();
}

//------------------------------------------

public OnNPCExitVehicle()
{
    StopRecordingPlayback();
}

//------------------------------------------
