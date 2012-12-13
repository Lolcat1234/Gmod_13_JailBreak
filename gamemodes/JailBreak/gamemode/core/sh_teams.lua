TEAM_PRISONER = 1;
TEAM_GUARD = 2;
TEAM_PRISONER_DEAD = 3;
TEAM_GUARD_DEAD = 4;
--Below is anti-typo
TEAM_PRISONERS = 1;
TEAM_GUARDS = 2;
TEAM_PRISONERS_DEAD = 3;
TEAM_GUARDS_DEAD = 4;
TEAM_SPECTATORS = TEAM_SPECTATOR;


CreateConVar( "jb_guardpresence", "40", { FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_SERVER_CAN_EXECUTE });
function JB:CanBeGuard()
	if (#team.GetPlayers(TEAM_GUARD) + #team.GetPlayers(TEAM_GUARD_DEAD)) < 1 then
		return true;
	elseif ((#team.GetPlayers(TEAM_GUARD) + #team.GetPlayers(TEAM_GUARD_DEAD) + 1)/(#team.GetPlayers(TEAM_GUARD) + #team.GetPlayers(TEAM_PRISONER) + #team.GetPlayers(TEAM_GUARD_DEAD) + #team.GetPlayers(TEAM_PRISONER_DEAD)))*100 <= tonumber(GetConVar("jb_guardpresence"):GetString()) then
		return true;
	end
	return false;
end

--SetUpteams
team.SetUp (TEAM_PRISONER,"Prisoners",Color(255,61,61,255));
team.SetUp (TEAM_GUARD,"Guards",Color(0,128,255,255));
team.SetUp (TEAM_PRISONER_DEAD,"Dead Prisoners",Color(210,0,0,255));
team.SetUp (TEAM_GUARD_DEAD,"Dead Guards",Color(0,80,200,255));
team.SetUp (TEAM_SPECTATOR,"Spectators",Color(255,228,122,255));

--Hooks
function GM:PlayerJoinTeam() return false end
function GM:PlayerRequestTeam() return false end
