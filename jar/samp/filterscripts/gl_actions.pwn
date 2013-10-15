//-------------------------------------------------
//
// Generic Special Actions And Anims
// kyeman 2007
//
//-------------------------------------------------

#include <a_samp>
#include <core>
#include <float>
#pragma tabsize 0

#include "../include/gl_common.inc"

new gPlayerUsingLoopingAnim[MAX_PLAYERS];
new gPlayerAnimLibsPreloaded[MAX_PLAYERS];

new Text:txtAnimHelper;

//-------------------------------------------------

OnePlayAnim(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, lockz, lp)
{
	ApplyAnimation(playerid, animlib, animname, Speed, looping, lockx, locky, lockz, lp);
}

//-------------------------------------------------

LoopingAnim(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, lockz, lp)
{
    gPlayerUsingLoopingAnim[playerid] = 1;
    ApplyAnimation(playerid, animlib, animname, Speed, looping, lockx, locky, lockz, lp);
    TextDrawShowForPlayer(playerid,txtAnimHelper);
}

//-------------------------------------------------

StopLoopingAnim(playerid)
{
	gPlayerUsingLoopingAnim[playerid] = 0;
    ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
}

//-------------------------------------------------

PreloadAnimLib(playerid, animlib[])
{
	ApplyAnimation(playerid,animlib,"null",0.0,0,0,0,0,0);
}

//-------------------------------------------------

// ********** CALLBACKS **********

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(!gPlayerUsingLoopingAnim[playerid]) return;

	if(IsKeyJustDown(KEY_SPRINT,newkeys,oldkeys)) {
	    StopLoopingAnim(playerid);
        TextDrawHideForPlayer(playerid,txtAnimHelper);
    }
}

//------------------------------------------------

public OnPlayerDeath(playerid, killerid, reason)
{
	// if they die whilst performing a looping anim, we should reset the state
	if(gPlayerUsingLoopingAnim[playerid]) {
        gPlayerUsingLoopingAnim[playerid] = 0;
        TextDrawHideForPlayer(playerid,txtAnimHelper);
	}

 	return 1;
}

//-------------------------------------------------

public OnPlayerSpawn(playerid)
{
	if(!gPlayerAnimLibsPreloaded[playerid]) {
   		PreloadAnimLib(playerid,"BOMBER");
   		PreloadAnimLib(playerid,"RAPPING");
    	PreloadAnimLib(playerid,"SHOP");
   		PreloadAnimLib(playerid,"BEACH");
   		PreloadAnimLib(playerid,"SMOKING");
    	PreloadAnimLib(playerid,"FOOD");
    	PreloadAnimLib(playerid,"ON_LOOKERS");
    	PreloadAnimLib(playerid,"DEALER");
		PreloadAnimLib(playerid,"CRACK");
		PreloadAnimLib(playerid,"CARRY");
		PreloadAnimLib(playerid,"COP_AMBIENT");
		PreloadAnimLib(playerid,"PARK");
		PreloadAnimLib(playerid,"INT_HOUSE");
		PreloadAnimLib(playerid,"FOOD");
		gPlayerAnimLibsPreloaded[playerid] = 1;
	}
	return 1;
}

//-------------------------------------------------

public OnPlayerConnect(playerid)
{
    gPlayerUsingLoopingAnim[playerid] = 0;
	gPlayerAnimLibsPreloaded[playerid] = 0;
	
	return 1;
}

//-------------------------------------------------

public OnFilterScriptInit()
{
	// Init our text display
	txtAnimHelper = TextDrawCreate(610.0, 400.0,
	"~r~~k~~PED_SPRINT~ ~w~to stop the animation");
	TextDrawUseBox(txtAnimHelper, 0);
	TextDrawFont(txtAnimHelper, 2);
	TextDrawSetShadow(txtAnimHelper,0); // no shadow
    TextDrawSetOutline(txtAnimHelper,1); // thickness 1
    TextDrawBackgroundColor(txtAnimHelper,0x000000FF);
    TextDrawColor(txtAnimHelper,0xFFFFFFFF);
    TextDrawAlignment(txtAnimHelper,3); // align right
}

//-------------------------------------------------

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256];
	new idx;
	new dancestyle;
	cmd = strtok(cmdtext, idx);

	if(strcmp(cmd,"/animlist",true)==0)
	{
		SendClientMessage(playerid,0xAFAFAFAA,"Available Animations:");
	    SendClientMessage(playerid,0xAFAFAFAA,"/handsup /drunk /bomb /getarrested /laugh /lookout /robman");
        SendClientMessage(playerid,0xAFAFAFAA,"/crossarms /lay /hide /vomit /eat /wave /taichi");
        SendClientMessage(playerid,0xAFAFAFAA,"/deal /crack /smokem /smokef /groundsit /chat /dance /f**ku");
	}
	
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) {
        // We don't handle anything here that can be used InVehicle
        return 0;
	}

	// HANDSUP
 	if(strcmp(cmd, "/handsup", true) == 0) {
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
        return 1;
    }
    
    // CELLPHONE IN
 	if(strcmp(cmd, "/cellin", true) == 0) {
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
        return 1;
    }
    
    // CELLPHONE OUT
 	if(strcmp(cmd, "/cellout", true) == 0) {
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
        return 1;
    }

    // Drunk
    if(strcmp(cmd, "/drunk", true) == 0) {
		LoopingAnim(playerid,"PED","WALK_DRUNK",4.0,1,1,1,1,0);
		return 1;
    }
    
	// Place a Bomb
    if (strcmp("/bomb", cmdtext, true) == 0) {
		ClearAnimations(playerid);
		OnePlayAnim(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0); // Place Bomb
		return 1;
	}
	// Police Arrest
    if (strcmp("/getarrested", cmdtext, true, 7) == 0) {
	      LoopingAnim(playerid,"ped", "ARRESTgun", 4.0, 0, 1, 1, 1, -1); // Gun Arrest
		  return 1;
    }
	// Laugh
    if (strcmp("/laugh", cmdtext, true) == 0) {
          OnePlayAnim(playerid, "RAPPING", "Laugh_01", 4.0, 0, 0, 0, 0, 0); // Laugh
		  return 1;
	}
	// Rob Lookout
    if (strcmp("/lookout", cmdtext, true) == 0) {
          OnePlayAnim(playerid, "SHOP", "ROB_Shifty", 4.0, 0, 0, 0, 0, 0); // Rob Lookout
		  return 1;
	}
	// Rob Threat
    if (strcmp("/robman", cmdtext, true) == 0) {
          LoopingAnim(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 1, 0, 0, 0, 0); // Rob
		  return 1;
	}
	// Arms crossed
    if (strcmp("/crossarms", cmdtext, true) == 0) {
          LoopingAnim(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, -1); // Arms crossed
		  return 1;
	}
	// Lay Down
    if (strcmp("/lay", cmdtext, true, 6) == 0) {
          LoopingAnim(playerid,"BEACH", "bather", 4.0, 1, 0, 0, 0, 0); // Lay down
		  return 1;
    }
	// Take Cover
    if (strcmp("/hide", cmdtext, true, 3) == 0) {
          LoopingAnim(playerid, "ped", "cower", 3.0, 1, 0, 0, 0, 0); // Taking Cover
		  return 1;
	}
	// Vomit
    if (strcmp("/vomit", cmdtext, true) == 0) {
	      OnePlayAnim(playerid, "FOOD", "EAT_Vomit_P", 3.0, 0, 0, 0, 0, 0); // Vomit BAH!
		  return 1;
	}
	// Eat Burger
    if (strcmp("/eat", cmdtext, true) == 0) {
	      OnePlayAnim(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0); // Eat Burger
		  return 1;
	}
	// Wave
    if (strcmp("/wave", cmdtext, true) == 0) {
	      LoopingAnim(playerid, "ON_LOOKERS", "wave_loop", 4.0, 1, 0, 0, 0, 0); // Wave
		  return 1;
	}
	// Slap Ass
    if (strcmp("/slapass", cmdtext, true) == 0) {
         OnePlayAnim(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0); // Ass Slapping
		  return 1;
	}
	// Dealer
    if (strcmp("/deal", cmdtext, true) == 0) {
          OnePlayAnim(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0); // Deal Drugs
		  return 1;
	}
	// Crack Dieing
    if (strcmp("/crack", cmdtext, true, 6) == 0) {
          LoopingAnim(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0); // Dieing of Crack
		  return 1;
	}
	// Male Smoking
    if (strcmp("/smokem", cmdtext, true, 4) == 0) {
          LoopingAnim(playerid,"SMOKING", "M_smklean_loop", 4.0, 1, 0, 0, 0, 0); // Smoke
		  return 1;
	}
	// Female Smoking
    if (strcmp("/smokef", cmdtext, true) == 0) {
          LoopingAnim(playerid, "SMOKING", "F_smklean_loop", 4.0, 1, 0, 0, 0, 0); // Female Smoking
		  return 1;
	}
	// Sit
    if (strcmp("/groundsit", cmdtext, true, 4) == 0) {
          LoopingAnim(playerid,"BEACH", "ParkSit_M_loop", 4.0, 1, 0, 0, 0, 0); // Sit
		  return 1;
    }
    // Idle Chat
    if(strcmp(cmd, "/chat", true) == 0) {
		 OnePlayAnim(playerid,"PED","IDLE_CHAT",4.0,0,0,0,0,0);
         return 1;
    }
    // Fucku
    if(strcmp(cmd, "/fucku", true) == 0) {
		 OnePlayAnim(playerid,"PED","fucku",4.0,0,0,0,0,0);
         return 1;
    }
    // TaiChi
    if(strcmp(cmd, "/taichi", true) == 0) {
		 LoopingAnim(playerid,"PARK","Tai_Chi_Loop",4.0,1,0,0,0,0);
         return 1;
    }
    
    // ChairSit
    if(strcmp(cmd, "/chairsit", true) == 0) {
		 LoopingAnim(playerid,"BAR","dnk_stndF_loop",4.0,1,0,0,0,0);
         return 1;
    }
    
    /* Would allow people to troll... but would be cool as a script
	   controlled function
    // Bed Sleep R
    if(strcmp(cmd, "/inbedright", true) == 0) {
		 LoopingAnim(playerid,"INT_HOUSE","BED_Loop_R",4.0,1,0,0,0,0);
         return 1;
    }
    // Bed Sleep L
    if(strcmp(cmd, "/inbedleft", true) == 0) {
		 LoopingAnim(playerid,"INT_HOUSE","BED_Loop_L",4.0,1,0,0,0,0);
         return 1;
    }*/
    

	// START DANCING
 	if(strcmp(cmd, "/dance", true) == 0) {
		    new tmp[256];

			// Get the dance style param
      		tmp = strtok(cmdtext, idx);
			if(!strlen(tmp) || strlen(tmp) > 2) {
				SendClientMessage(playerid,0xFF0000FF,"USAGE: /dance [style 1-4]");
				return 1;
			}
			
			dancestyle = strval(tmp);
			if(dancestyle < 1 || dancestyle > 4) {
			    SendClientMessage(playerid,0xFF0000FF,"USAGE: /dance [style 1-4]");
			    return 1;
			}
			
			if(dancestyle == 1) {
			    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
			} else if(dancestyle == 2) {
			    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
			} else if(dancestyle == 3) {
			    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
			} else if(dancestyle == 4) {
			    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);
			}
 	  		return 1;
	}

	return 0;
}
//-------------------------------------------------
// EOF
