//
// A Driver NPC that goes around a path continuously
// Kye 2009
//

#include <a_npc>

#define NUM_PLAYBACK_FILES 3
new gPlaybackFileCycle=0;

//------------------------------------------

main(){}

//------------------------------------------

NextPlayback()
{
	// Reset the cycle count if we reach the max
	if(gPlaybackFileCycle==NUM_PLAYBACK_FILES) gPlaybackFileCycle = 0;

	if(gPlaybackFileCycle==0) {
		StartRecordingPlayback(PLAYER_RECORDING_TYPE_DRIVER,"train_lv_to_ls1");
		//SendChat("I'm leaving LV for LS station.");
	}
	else if(gPlaybackFileCycle==1) {
	    StartRecordingPlayback(PLAYER_RECORDING_TYPE_DRIVER,"train_ls_to_sf1");
	    //SendChat("I'm leaving LS for SF station.");
	}
	else if(gPlaybackFileCycle==2) {
	    StartRecordingPlayback(PLAYER_RECORDING_TYPE_DRIVER,"train_sf_to_lv1");
	    //SendChat("I'm leaving SF for LV station.");
	}

	gPlaybackFileCycle++;
}
	

//------------------------------------------

public OnRecordingPlaybackEnd()
{
    NextPlayback();
}

//------------------------------------------

public OnNPCEnterVehicle(vehicleid, seatid)
{
    NextPlayback();
}

//------------------------------------------

public OnNPCExitVehicle()
{
    StopRecordingPlayback();
    gPlaybackFileCycle = 0;
}

//------------------------------------------
