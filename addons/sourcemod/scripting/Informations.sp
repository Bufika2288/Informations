#pragma semicolon 1

#define DEBUG

#define PLUGIN_AUTHOR "Levi2288"
#define PLUGIN_VERSION "1.00"

#include <sourcemod>
#include <sdktools>
#include <multicolors>

Handle donatorsfile;
Handle vipinfofile;
Handle sm_steamgroup_enable = INVALID_HANDLE;
Handle sm_discord_enable = INVALID_HANDLE;
Handle sm_owner_enable = INVALID_HANDLE;
Handle sm_ts3_enable = INVALID_HANDLE;
Handle sm_donate_enable = INVALID_HANDLE;
Handle sm_vipinfo_enable = INVALID_HANDLE;
Handle sm_web_enable = INVALID_HANDLE;
Handle sm_bans_enable = INVALID_HANDLE;


#pragma newdecls required

public Plugin myinfo = 
{
	name = "Informations",
	author = PLUGIN_AUTHOR,
	description = "Customizable informations.",
	version = PLUGIN_VERSION,
	url = "https://github.com/Bufika2288"
};

public void OnPluginStart()
{
	RegConsoleCmd("sm_steamgroup", Steam);
	RegConsoleCmd("sm_group", Steam);
	RegConsoleCmd("sm_steam", Steam);
	
	RegConsoleCmd("sm_discord", Discord);
	RegConsoleCmd("sm_dc", Discord);
	
	RegConsoleCmd("sm_steamprofile", Owner);
	RegConsoleCmd("sm_profile", Owner);
	RegConsoleCmd("sm_owner", Owner);
	
	RegConsoleCmd("sm_ts3", TS);
	RegConsoleCmd("sm_teamspeak", TS);
	RegConsoleCmd("sm_ts", TS);
	
	RegConsoleCmd("sm_donate", Donate);
	RegConsoleCmd("sm_support", Donate);
	RegConsoleCmd("sm_don", Donate);
	
	RegConsoleCmd("sm_vipinfo", BVip);
	RegConsoleCmd("sm_buy", BVip);
	RegConsoleCmd("sm_vipi", BVip);
	RegConsoleCmd("sm_buyvip", BVip);
	RegConsoleCmd("sm_bvip", BVip);
	
	RegConsoleCmd("sm_website", Web);
	RegConsoleCmd("sm_site", Web);
	RegConsoleCmd("sm_web", Web);
	
	RegConsoleCmd("sm_bans", Bans);
	RegConsoleCmd("sm_sourcebans", Bans);
	RegConsoleCmd("sm_banlist", Bans);
	
	LoadTranslations("Informations.phrases");
	LoadTranslations("common.phrases");
	
	AutoExecConfig(true, "Informations");
	sm_steamgroup_enable = CreateConVar("sm_steamgroup_enable","1", "Enable steam info ");
	sm_discord_enable = CreateConVar("sm_discord_enable", "1","Enable discord info");
	sm_owner_enable = CreateConVar("sm_owner_enable", "1","Enable Owner info ");
	sm_ts3_enable = CreateConVar("sm_ts3_enable", "1","Enable discord info");
	sm_web_enable = CreateConVar("sm_web_enable", "1","Enable website info ");
	sm_bans_enable = CreateConVar("sm_bans_enable", "1","Enable sourcebans info ");
	sm_donate_enable = CreateConVar("sm_donate_enable", "1","Enable Donate info ");
	sm_vipinfo_enable = CreateConVar("sm_vipinfo_enable", "1","Enable vip info ");
	
	
	CreateConVar("sm_informations_version", PLUGIN_VERSION, "Plugin Version", FCVAR_SPONLY|FCVAR_REPLICATED|FCVAR_NOTIFY);
}

//Steam
public Action Steam(int client, int args)
{
	if (GetConVarBool(sm_steamgroup_enable))
	{
		if(IsClientInGame(client) && !IsFakeClient(client))
		{
			CPrintToChat(client, "%t", "Steam");
	
		}
	}

	return Plugin_Handled;
}

//Discord
public Action Discord(int client, int args)
{
	if (GetConVarBool(sm_discord_enable))
	{
		if(IsClientInGame(client) && !IsFakeClient(client))
		{
			CPrintToChat(client, "%t", "Discord");
	
		}
	}
	
	return Plugin_Handled;
}

//Owner
public Action Owner(int client, int args)
{
	if (GetConVarBool(sm_owner_enable))
	{
		if(IsClientInGame(client) && !IsFakeClient(client))
		{
			CPrintToChat(client, "%t", "Owner");
	
		}
	}
	
	return Plugin_Handled;
}
//Web
public Action Web(int client, int args)
{
	if (GetConVarBool(sm_web_enable))
	{
		if(IsClientInGame(client) && !IsFakeClient(client))
		{
			CPrintToChat(client, "%t", "Website");
	
		}
	}
	
	return Plugin_Handled;
}
//Bans
public Action Bans(int client, int args)
{
	if (GetConVarBool(sm_bans_enable))
	{
		if(IsClientInGame(client) && !IsFakeClient(client))
		{
			CPrintToChat(client, "%t", "Bans");
	
		}
	}

	return Plugin_Handled;
}

//TS3
public Action TS(int client, int args)
{
	if (GetConVarBool(sm_ts3_enable))
	{
		if(IsClientInGame(client) && !IsFakeClient(client))
		{
			CPrintToChat(client, "%t", "Ts3");
	
		}
	}
	
	return Plugin_Handled;
}
//Donate
public Action Donate(int client, int args)
{
	if (GetConVarBool(sm_donate_enable))
	{
		
		if(IsClientInGame(client) && !IsFakeClient(client))
		{
			DonatorsMenu(client);
		}
	}
	
	return Plugin_Handled;
}

public Action BVip(int client, int args)
{	
	if (GetConVarBool(sm_vipinfo_enable))
	{
		if(IsClientInGame(client) && !IsFakeClient(client))
		{
			VipInfo(client);
		}
		
	}
}



public bool DonatorsMenu(int client)
{
	char buffer[128];
	Format(buffer, sizeof(buffer), "%T", "DonatorMenu", client);
	Menu DMenu = new Menu(MenuHandlerDonators, MenuAction_Display);
	DMenu.SetTitle(buffer);
	DMenu.AddItem("Donators", "Donators");
	DMenu.Pagination = 7;
	DMenu.ExitButton = true;
	
	DMenu.Display(client, MENU_TIME_FOREVER);

	return true;



}

public bool DonatorList(int client)
{
	donatorsfile = OpenFile("addons/sourcemod/configs/Information_donator_list.ini", "rt");
	if (donatorsfile == INVALID_HANDLE)
	{
		LogError("Information_donator_list.ini Not found. Donate information disabled");
		return true;
	}
	
	Menu ListMenu = new Menu(MenuHandlerDonatorList, MenuAction_Display);
	char DonatorL[256];
	while (!IsEndOfFile(donatorsfile) && ReadFileLine(donatorsfile, DonatorL, sizeof(DonatorL)))
	{
		ListMenu.AddItem("DonatorList", DonatorL, ITEMDRAW_DISABLED);
	}
	
	CloseHandle(donatorsfile);
	
	ListMenu.SetTitle("Donator List:");
	ListMenu.Pagination = 7;
	ListMenu.ExitButton = true;
	ListMenu.Display(client, MENU_TIME_FOREVER);
	return true;

}

//Donator MenuHandler
public int MenuHandlerDonators(Menu DMenu, MenuAction action, int client, int param2)
{
	switch(action){
		
		case MenuAction_Select:
		{	
			char item[32];
			DMenu.GetItem(param2, item, sizeof(item));
			
			if (StrEqual(item, "Donators")) 
			{
			
				DonatorList(client);
			
			}
		}
	
		case MenuAction_End:
		{
			delete DMenu;
		}
	}
	return true;
}

//DonatorList MenuHandler
public int MenuHandlerDonatorList(Menu ListMenu, MenuAction action, int client, int param2)
{
	switch(action){
		
		case MenuAction_Select:
		{	
			char item[32];
			ListMenu.GetItem(param2, item, sizeof(item));
			
			if (StrEqual(item, "DonatorList")) 
			{
				DonatorList(client);
			}
		}
		case MenuAction_End:
		{
			delete ListMenu;
		}
	}
}

//Vip Information


public bool VipInfo(int client)
{
	vipinfofile = OpenFile("addons/sourcemod/configs/Information_vip_info.ini", "rt");
	if (vipinfofile == INVALID_HANDLE)
	{
		LogError("Information_vip_info.ini Not found. Vip information disabled");
		return true;
	}
	
	char buffer[128];
	char VipInfoL[256];
	
	Format(buffer, sizeof(buffer), "%T", "VipInfoMenu", client);
	
	
	Menu VipInfoMenu = new Menu(MenuHandlerVipInfo, MenuAction_Display);
	VipInfoMenu.SetTitle(buffer);
	
	while (!IsEndOfFile(vipinfofile) && ReadFileLine(vipinfofile, VipInfoL, sizeof(VipInfoL)))
	{
		VipInfoMenu.AddItem("VipInfo", VipInfoL, ITEMDRAW_DISABLED);
	}
	
	CloseHandle(vipinfofile);
	
	VipInfoMenu.Pagination = 7;
	VipInfoMenu.ExitButton = true;
	VipInfoMenu.Display(client, MENU_TIME_FOREVER);
	return true;
}

//Vip info MenuHandler
public int MenuHandlerVipInfo(Menu VipInfoMenu, MenuAction action, int client, int param2)
{
	switch(action){
		
		case MenuAction_Select:
		{	
			char item[32];
			VipInfoMenu.GetItem(param2, item, sizeof(item));
			
		}
		case MenuAction_End:
		{
			delete VipInfoMenu;
		}
	}
	
	return true;
}