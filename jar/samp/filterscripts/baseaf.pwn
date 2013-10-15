//
// Base FS for Sanandreas Multiplayer 0.3
// Contains /pm /kick /ban commands - it also features
// a basic anti flood system, and admin chatting for rcon admins
// using # <message>

#include <a_samp>
#include "../include/gl_common.inc"

#define ADMINFS_MESSAGE_COLOR 0xFF444499
#define PM_INCOMING_COLOR     0xFFFF22AA
#define PM_OUTGOING_COLOR     0xFFCC2299

static iPlayerChatTime[MAX_PLAYERS];
static szPlayerChatMsg[MAX_PLAYERS][128];

//------------------------------------------------

stock IsPlayerFlooding(playerid)
{
	if(GetTickCount() - iPlayerChatTime[playerid] < 2000)
	    return 1;

	return 0;
}

//------------------------------------------------

public OnFilterScriptInit()
{
	print("\n--Base FS loaded.\n");
	return 1;
}

//------------------------------------------------

public OnPlayerText(playerid, text[])
{
	// Is the player flooding?
	if(IsPlayerFlooding(playerid) && !IsPlayerAdmin(playerid))
	{
	    SendClientMessage(playerid, 0xFF0000FF, "* You can only send a message once every two seconds.");
	    return 0;
	}

	// Now we handle the admin chat, will be #<message>.
	if( (text[0] == '#' || text[0] == '@') && strlen(text) > 1)
	{
		new str[128];
		new szPlayerName[MAX_PLAYER_NAME];
		GetPlayerName(playerid, szPlayerName, MAX_PLAYER_NAME);

		if(IsPlayerAdmin(playerid))
		{
		    format(str, 128, "Admin %s: %s", szPlayerName, text[1]);

			for(new iPlayerID; iPlayerID < MAX_PLAYERS; iPlayerID++)
			{
				if(!IsPlayerConnected(iPlayerID)) continue;
		    	if(!IsPlayerAdmin(iPlayerID)) continue;
			    SendClientMessage(iPlayerID, PM_INCOMING_COLOR, str);
			}
		}

		return 0;
	}

	// Okay, now it's time for anti repeating.
	if(!IsPlayerAdmin(playerid))
	{
		if(strlen(text) == strlen(szPlayerChatMsg[playerid]) && !strcmp(szPlayerChatMsg[playerid], text,  false))
		{
			SendClientMessage(playerid, 0xFF0000FF, "* Please do not repeat yourself.");
			format(szPlayerChatMsg[playerid], 128, "%s", text);
		    return 0;
		}
	}

	format(szPlayerChatMsg[playerid], 128, "%s", text);
    iPlayerChatTime[playerid] = GetTickCount();
    return 1;
}

//------------------------------------------------

public OnPlayerDisconnect(playerid, reason)
{
	#pragma unused reason

	iPlayerChatTime[playerid] = 0;
	szPlayerChatMsg[playerid] = "";
	return 1;
}

//------------------------------------------------

public OnPlayerCommandText(playerid, cmdtext[])
{

	if(IsPlayerFlooding(playerid) && !IsPlayerAdmin(playerid))
	{
		SendClientMessage(playerid, 0xFF0000FF, "* You can only use commands once every two seconds.");
	    return 1;
	}

	iPlayerChatTime[playerid] = GetTickCount();

	new cmd[256];
	new	tmp[256];
	new Message[256];
	new gMessage[256];
	new pName[MAX_PLAYER_NAME+1];
	new iName[MAX_PLAYER_NAME+1];
	new	idx;

	cmd = strtok(cmdtext, idx);

	// PM Command
	if(strcmp("/pm", cmd, true) == 0)
	{
		tmp = strtok(cmdtext,idx);

		if(!strlen(tmp) || strlen(tmp) > 5) {
			SendClientMessage(playerid,ADMINFS_MESSAGE_COLOR,"Usage: /pm (id) (message)");
			return 1;
		}

		new id = strval(tmp);
        gMessage = strrest(cmdtext,idx);

		if(!strlen(gMessage)) {
			SendClientMessage(playerid,ADMINFS_MESSAGE_COLOR,"Usage: /pm (id) (message)");
			return 1;
		}

		if(!IsPlayerConnected(id)) {
			SendClientMessage(playerid,ADMINFS_MESSAGE_COLOR,"/pm : Bad player ID");
		}

		if(playerid != id) {
			GetPlayerName(id,iName,sizeof(iName));
			GetPlayerName(playerid,pName,sizeof(pName));
			format(Message,sizeof(Message),">> %s(%d): %s",iName,id,gMessage);
			SendClientMessage(playerid,PM_OUTGOING_COLOR,Message);
			format(Message,sizeof(Message),"** %s(%d): %s",pName,playerid,gMessage);
			SendClientMessage(id,PM_INCOMING_COLOR,Message);
			PlayerPlaySound(id,1085,0.0,0.0,0.0);

			printf("PM: %s",Message);

		}
		else {
			SendClientMessage(playerid,ADMINFS_MESSAGE_COLOR,"You cannot PM yourself");
		}
		return 1;
	}

	//Kick Command
	if(strcmp("/kick", cmd, true) == 0)
	{
	    if(IsPlayerAdmin(playerid)) {
			tmp = strtok(cmdtext,idx);
			if(!strlen(tmp) || strlen(tmp) > 5) {
				return SendClientMessage(playerid,ADMINFS_MESSAGE_COLOR,"Usage: /kick (id) [reason]");
			}

			new id = strval(tmp);

			if(!IsPlayerConnected(id)) {
				SendClientMessage(playerid,ADMINFS_MESSAGE_COLOR,"/kick : Bad player ID");
				return 1;
			}

			gMessage = strrest(cmdtext,idx);

			GetPlayerName(id,iName,sizeof(iName));
			SendClientMessage(id,ADMINFS_MESSAGE_COLOR,"-- You have been kicked from the server.");

			if(strlen(gMessage) > 0) {
				format(Message,sizeof(Message),"Reason: %s",gMessage);
				SendClientMessage(id,ADMINFS_MESSAGE_COLOR,Message);
			}

			format(Message,sizeof(Message),">> %s(%d) has been kicked.",iName,id);
			SendClientMessage(playerid,ADMINFS_MESSAGE_COLOR,Message);

			Kick(id);
			return 1;
		} else {
            SendClientMessage(playerid,ADMINFS_MESSAGE_COLOR,"/kick : You are not an admin");
			return 1;
		}
	}

	//Ban Command
	if(strcmp("/ban", cmd, true) == 0)
	{
	    if(IsPlayerAdmin(playerid)) {
			tmp = strtok(cmdtext,idx);
			if(!strlen(tmp) || strlen(tmp) > 5) {
				return SendClientMessage(playerid,ADMINFS_MESSAGE_COLOR,"Usage: /ban (id) [reason]");
			}

			new id = strval(tmp);

			if(!IsPlayerConnected(id)) {
				SendClientMessage(playerid,ADMINFS_MESSAGE_COLOR,"/ban : Bad player ID");
				return 1;
			}

			gMessage = strrest(cmdtext,idx);

			GetPlayerName(id,iName,sizeof(iName));
			SendClientMessage(id,ADMINFS_MESSAGE_COLOR,"-- You have been banned from the server.");

			if(strlen(gMessage) > 0) {
				format(Message,sizeof(Message),"Reason: %s",gMessage);
				SendClientMessage(id,ADMINFS_MESSAGE_COLOR,Message);
			}

			format(Message,sizeof(Message),">> %s(%d) has been banned.",iName,id);
			SendClientMessage(playerid,ADMINFS_MESSAGE_COLOR,Message);

			Ban(id);
			return 1;
		} else {
            SendClientMessage(playerid,ADMINFS_MESSAGE_COLOR,"/ban : You are not an admin");
			return 1;
		}
	}

	return 0;
}

//-----------------------------------------------
