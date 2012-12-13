-- cl_spectators

--cl_spectator

local nextPress = CurTime();
hook.Add("Think","jbMousePressSpec",function()
	if LocalPlayer():Team() == TEAM_GUARD_DEAD  or LocalPlayer():Team() == TEAM_PRISONER_DEAD then
		if nextPress > CurTime() then return end
	
		if input.IsMouseDown(MOUSE_LEFT) then
			RunConsoleCommand("jb_spectate_switch_plus");
			JB:DebugPrint("Spectating next entity");
		elseif input.IsMouseDown(MOUSE_RIGHT) then
			RunConsoleCommand("jb_spectate_switch_minus");
			JB:DebugPrint("Spectating previous entity");
		else
			return
		end
	
		nextPress = CurTime()+0.5;
	end
end);

local barTall = 70;
hook.Add("HUDPaint", "jbSpectatorHud", function()
	if LocalPlayer():GetObserverMode() ~= OBS_MODE_CHASE then return end
	
	surface.SetTexture();
	surface.SetDrawColor(0,0,0,255);
	
	surface.DrawRect(0,0,ScrW(),barTall);
	surface.DrawRect(0,ScrH()-barTall,ScrW(),barTall);
	
	surface.SetDrawColor(255,255,255,50);
	surface.DrawRect(0,barTall-3,ScrW(),2);
	surface.DrawRect(0,ScrH()-barTall+1,ScrW(),2);
	
	local pplPlaying = "There are "..(#player.GetAll()-1).." other people playing.";
	if #player.GetAll() <= 1 then
		pplPlaying = "Only you are playing...";
	end
	local spec = "You are spectating "..(LocalPlayer():GetObserverTarget():Nick() or "nobody").."."
	if LocalPlayer():GetObserverTarget() and LocalPlayer():GetObserverTarget():IsValid() and LocalPlayer():GetObserverTarget():IsAwesome() then
		spec = spec.."\n"..LocalPlayer():GetObserverTarget():Nick().." is a gamemode developer!"
	end
	draw.DrawText("You are playing Excl's JailBreak 3, at "..GetHostName()..".\n"..pplPlaying.."", "DefaultBold", 20,17,Color(255,255,255))
	draw.DrawText("You can press F4 to open the menu.", "DefaultBold", ScrW()-20,17,Color(255,255,255),2)
	draw.DrawText(spec, "DefaultBold", 20,ScrH()-barTall+23,Color(255,255,255),0) --no YAlign :(
	draw.DrawText("Press Left Mouse to go to the next player\nPress Right Mouse to go to the previous player.", "DefaultBold", ScrW()-20,ScrH()-barTall+23,Color(255,255,255),2) --no YAlign :(
end);