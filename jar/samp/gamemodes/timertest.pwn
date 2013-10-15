#include <a_samp>

forward OneSecTimer();

main()
{
	print("\n----------------------------------");
	print("  This is a blank GameModeScript");
	print("----------------------------------\n");
	
	//printf("GetVehicleComponentType %u",GetVehicleComponentType(1100));
	
}

public OnGameModeInit()
{
	// Set timer of 1 second.
	SetTimer("OneSecTimer", 1000, 1);
	print("GameModeInit()");
	SetGameModeText("Timer Test");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	return 1;
}

public OneSecTimer() {
	new sText[256];
	format(sText,sizeof(sText),"GetTickCount = %d",GetTickCount());
	print(sText);
	SendClientMessageToAll(0xFF0000, sText);
}

