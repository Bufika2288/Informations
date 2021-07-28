#pragma semicolon 1

#define DEBUG

#define PLUGIN_AUTHOR "Levi2288"
#define PLUGIN_VERSION "1.00"

#include <sourcemod>
#include <sdktools>
#include <multicolors>

Handle sm_steamgroup_enable = INVALID_HANDLE;
Handle sm_discord_enable = INVALID_HANDLE;
Handle sm_owner_enable = INVALID_HANDLE;
Handle sm_ts3_enable = INVALID_HANDLE;
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