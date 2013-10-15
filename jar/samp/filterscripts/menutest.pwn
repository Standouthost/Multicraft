// Test menu functionality filterscipt

#include <a_samp>

#define TEST_MENU_ITEMS 6

new Menu:TestMenu;
new TestMenuStrings[6][16] = {"Test1", "Test2", "Test3", "Test4", "Test5", "Test6"};

HandleTestMenuSelection(playerid, row)
{
	new s[256];
	
	if(row < TEST_MENU_ITEMS) {
		format(s,256,"You selected item %s",TestMenuStrings[row]);
		SendClientMessage(playerid,0xFFFFFFFF,s);
	}
}

InitTestMenu()
{
	TestMenu = CreateMenu("Test Menu", 1, 200.0, 150.0, 200.0, 200.0);

	for(new x=0; x < TEST_MENU_ITEMS; x++) {
    	AddMenuItem(TestMenu, 0, TestMenuStrings[x]);
	}
}

public OnFilterScriptInit()
{
   	InitTestMenu();
}

public OnPlayerSelectedMenuRow(playerid, row)
{
    new Menu:PlayerMenu = GetPlayerMenu(playerid);
    
	if(PlayerMenu == TestMenu) {
	    HandleTestMenuSelection(playerid, row);
	}
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(!strcmp(cmdtext, "/menutest", true))	{
    	ShowMenuForPlayer(TestMenu, playerid);
    	return 1;
	}
	return 0;
}



