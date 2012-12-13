-- sv_player_cmds

concommand.Add("jb_menu_gocharacterpos",function(p)
	if p:Team() ~= TEAM_SPECTATOR then return end

	p:SetAngles(MenuMain.ang);
	p:SetPos(MenuCharacter.pos-Vector(0,0,64));
end)
concommand.Add("jb_menu_backtomain",function(p)
	if p:Team() ~= TEAM_SPECTATOR then return end

	p:SetPos(MenuPos.pos-Vector(0,0,64));
	p:SetAngles(Angle(0.403056, 90.340294, 0));
end)
concommand.Add("jb_menu_selectcharacter_ingame",function(p,c,a)
	if p:Team() == TEAM_SPECTATOR then return end
	
	local t,c = a[1],tonumber(a[2] or 1);
	if not t or not c then JB:DebugPrint("Failed to create character. Args are invalid."); return end
	
	JB:DebugPrint("Player has selected character");
	
	local n;
	if t == "guard" then
		n = TEAM_GUARD_DEAD;
		c = JB.Characters.Guard[1];
	else
		n = TEAM_PRISONER_DEAD;
		c = JB.Characters.Prisoner[c];
	end
	p:KillSilent();
	p:SetTeam(n);
	p.character = c;
	p:Spawn();
	
	umsg.Start("JCMM",p); umsg.End(); -- disable the main menu;
	p:SynchCharacter()
	JB:CheckRoundEnd()
end)
concommand.Add("jb_menu_selectcharacter",function(p,c,a)
	if p:Team() ~= TEAM_SPECTATOR or p.character then JB:DebugPrint("Failed to create character. Character already set."); return end
	
	local t,c = a[1],tonumber(a[2] or 1);
	if not t or not c then JB:DebugPrint("Failed to create character. Args are invalid."); return end
	
	JB:DebugPrint("Player has selected character");
	
	local n;
	if t == "guard" then
		n = TEAM_GUARD_DEAD;
		c = JB.Characters.Guard[1];
	else
		n = TEAM_PRISONER_DEAD;
		c = JB.Characters.Prisoner[c];
	end
	p:KillSilent()
	p:SetTeam(n);
	p.character = c;
	p:Spawn();

	umsg.Start("JCMM",p); umsg.End(); -- disable the main menu;
	p:SynchCharacter()
	JB:CheckRoundEnd()
end)

local noDrop = {"jb_hands"}
concommand.Add("jb_dropweapon",function(p)
	if p:Team() > 2 or not p:GetActiveWeapon() or not p:GetActiveWeapon():IsValid() or table.HasValue(noDrop,p:GetActiveWeapon():GetClass()) then return end

	p:DropWeapon(p:GetActiveWeapon());
end)

local function SpectateChange(p,c)
	if p:Team() ~= TEAM_SPECTATOR and p:Team() ~= TEAM_PRISONER_DEAD and p:Team() ~= TEAM_GUARD_DEAD then return end

	bDir = (c == "jb_spectate_switch_minus");
	
	local num=1;
	if bDir then
		num=-num;
	end
	
	if not p.spec then p.spec = 1; end
	
	p.spec = p.spec+num;
	
	if p.spec > (#team.GetPlayers(TEAM_GUARD)+ #team.GetPlayers(TEAM_PRISONER)) then 
		p.spec = 1;
	elseif p.spec < 1 then
		p.spec = (#team.GetPlayers(TEAM_GUARD)+ #team.GetPlayers(TEAM_PRISONER));
	end
	
	if p.spec > #team.GetPlayers(TEAM_GUARD) then
		p:SpectateEntity(team.GetPlayers(TEAM_PRISONER)[p.spec]);
	else
		p:SpectateEntity(team.GetPlayers(TEAM_GUARD)[p.spec]);
	end
end
concommand.Add("jb_spectate_switch_plus",SpectateChange)
concommand.Add("jb_spectate_switch_minus",SpectateChange)