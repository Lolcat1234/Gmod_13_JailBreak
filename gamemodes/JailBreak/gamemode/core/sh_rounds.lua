-- sv_rounds
-- this is the thing you started, clark.


-- tbls
local noRemoveOnRound = {
	"jb_previewmodel",
	"prop_physics"
}

-- "enums"
ROUND_INITIALIZE = 0;
ROUND_START = 1;
ROUND_PLAY = 2;
ROUND_END = 3;

WIN_DRAW = 0;
WIN_PRISONER = 1;
WIN_GUARD = 2;

-- locals
local roundActive = ROUND_INITIALIZE;
local roundWinner = "Neither team";

--actual things
function JB:RoundStatus() -- debug thing
	return roundActive or ROUND_INITIALIZE;
end

--Who won the round(should only be used when the round is over.)
function JB:GetWinner()
	return roundWinner or "WTF BUG?!.";
end

if SERVER then
	local teamGetPlayers = team.GetPlayers -- why is this here? well. I want to do EVEREYTHING possible to optimise the rounds. Even the really stupid stuff.

	local roundCount = 0;

	local function startPlayer(p)
		if p:Team() == TEAM_GUARD_DEAD then
			p:SetTeam(TEAM_GUARD);
		elseif p:Team() == TEAM_PRISONER_DEAD then
			p:SetTeam(TEAM_PRISONER);
		end 
		
		if (p:Team() == TEAM_GUARD or p:Team() == TEAM_GUARD_DEAD) and not p:HasAwnseredMic() then
			umsg.Start("JSHM",p); umsg.End()
		end
	end
	function JB:RoundStart()

		roundActive = ROUND_START;
		activeLR = false;
		
		for k,v in pairs(team.GetPlayers(TEAM_GUARD))do
			v:StripWeapons();
			v:SetHealth(100);
			v:SetArmor(0);
			startPlayer(v);
			v:Spawn();
		end
		for k,v in pairs(team.GetPlayers(TEAM_PRISONER))do
			v:StripWeapons();
			v:SetHealth(100);
			v:SetArmor(0);
			startPlayer(v);
			v:Spawn();
		end
		for k,v in pairs(team.GetPlayers(TEAM_GUARD_DEAD))do
			startPlayer(v);
			v:Spawn();
		end
		for k,v in pairs(team.GetPlayers(TEAM_PRISONER_DEAD))do
			startPlayer(v);
			v:Spawn();
		end

		timer.Create("RoundEnd",600,0,function()
			JB:RoundEnd();
		end)

		timer.Create("TimeWarden",10,1,function()
			local t = {}
			for k,v in pairs(team.GetPlayers(TEAM_GUARD))do
				if v:HasMic() then
					t[#t+1] = v;
				end
			end
			if t and t[1] then
				JB:SetWarden(table.Random(t));
			else
				JB:ResetWarden()
			end
		end)
	end

	function JB:RoundEnd(win)
		if JB:RoundStatus() == ROUND_END then return end

		JB:ShouldVoteMap()

		roundActive = ROUND_END;
		
		
		for k,v in pairs(ents.FindByClass("jb_guardprop_ball"))do
			if v and v:IsValid() then
				v:Remove();
			end
		end

		if timer.IsTimer("RoundEnd") then
			timer.Stop("RoundEnd");
			timer.Remove("RoundEnd");
		end

		if timer.IsTimer("TimeWarden") then
			timer.Stop("TimeWarden");
			timer.Remove("TimeWarden");
		end

		JB:ResetWarden()

		umsg.Start("JBRE"); umsg.Char(win); umsg.End(); --JailBreakRoundEnd
		
		if win == WIN_PRISONER then
			roundWinner = "PRISONERS";
		elseif win == WIN_GUARD then
			roundWinner = "GUARDS";
		else
			roundWinner = "Neither team";
		end
		
		timer.Simple(1,function()
			game.CleanUpMap(true,noRemoveOnRound);
		end)
		timer.Simple(3,function()
			JB:SpawnMapConfig();
		end)
		timer.Simple(4, function()
			JB:RoundStart()
		end)


	end

	function JB:CheckRoundEnd() -- edited this so it supports winning teams <3
		local numGuard = #team.GetPlayers(TEAM_GUARD);
		local numPrisoner = #team.GetPlayers(TEAM_PRISONER);
	
		if (numGuard <= 0) and (numPrisoner >= 1) then
			JB:RoundEnd(WIN_PRISONER);
			return true;
		elseif (numPrisoner <= 0) and (numGuard >= 1) then
			JB:RoundEnd(WIN_GUARD);
			return true;
		elseif  (numPrisoner <= 0) and (numGuard <= 0) then
			JB:RoundEnd(WIN_DRAW);
			return true;
		end	
		return false;
	end
elseif CLIENT then
	surface.CreateFont( "akbar", 128, 500, true, true, "HugeFont" )


	local BackgroundTId = surface.GetTextureID("prisonbreak/background_texture"); --Texture ID
	local GradientTId = surface.GetTextureID("prisonbreak/gradient"); --Texture ID
	local protips = {
	"protip: Everybody loves Excl.",
	"protip: Guns kill people.",
	"protip: Switching to your sidearm is faster than reloading.",
	"protip: The last prisoner can press [F4] to do his last request.",
	"protip: Guards will only kill naughty prisoners, listen to them to live.",
	"protip: You knife's secondary attack does more damage, but no critical hits.",
	"protip: Obey commands, you will last longer.",
	"protip: Press [F1] to open a rules menu.",
	"protip: Excl's Jailbreak has no annoying hunger system.",
	"protip: If you need help playing, press [F1].",
	"protip: Do not cry when you die. Dead people don't cry.",
	"protip: We are better than LifePunch."
	}
	local protipActive = protips[1];


	hook.Add("HUDPaint","JBRoundPaint", function()
		if JB:RoundStatus() == ROUND_START or JB:RoundStatus() == ROUND_END then

			surface.SetFont("Trebuchet19");
		
			local sWin = "PREPARING";
			if JB:RoundStatus() == ROUND_END then
				sWin = roundWinner;
			end
			local s=JB.util.FormatLine(protipActive or protips[1], "Trebuchet19", 280);
			local w,h=surface.GetTextSize(s);
			local rh=180+h+8;

			
			draw.RoundedBox( 6, (ScrW()/2)-152, ScrH()-352, 304, rh+4, Color( 0, 0, 0, 255 ) )
			draw.RoundedBox( 6, (ScrW()/2)-150, ScrH()-350, 300, rh, Color( 200, 200, 200, 200 ) )
			draw.RoundedBox( 4, (ScrW()/2)-150+5, (ScrH()-350)+50+130, 290, h+2, Color(0,0,0,255))
			draw.RoundedBox( 4, (ScrW()/2)-150+6, (ScrH()-350)+51+130, 288, h, Color(225,225,225,255))
			draw.RoundedBox( 4, (ScrW()/2)-150+8, (ScrH()-350)+53+130, 284, h/2, Color(255,255,255,20))
			
			draw.SimpleText(sWin, "HUDNumber5", (ScrW()/2), (ScrH()-350)+3, Color(50,50,50,255), TEXT_ALIGN_CENTER, 0)
			draw.DrawText(s, "Trebuchet19", (ScrW()/2), (ScrH()-350)+50+130, Color(30,30,30,255), TEXT_ALIGN_CENTER, 0)
			
			draw.RoundedBox( 4, ((ScrW()/2)-150)+5, (ScrH()-350)+45, ((300/2)-8), 130, Color(0,0,0,255) )
			draw.RoundedBox( 4, ((ScrW()/2)-150)+6, (ScrH()-350)+46, ((300/2)-8)-2, 130-2, Color( 200, 50, 10, 240 ) )
			draw.SimpleText("PRISONERS", "Trebuchet24", ((ScrW()/2)-150)+((300/2)-8)/2, (ScrH()-350)+50, Color(250,250,250,255), TEXT_ALIGN_CENTER, 0)
			draw.SimpleText(team.GetScore(TEAM_PRISONER), "HugeFont", ((ScrW()/2)-150)+((300/2)-8)/2, (ScrH()-350)+55, Color(250,250,250,255), TEXT_ALIGN_CENTER, 0)
			
			draw.RoundedBox( 4, ((ScrW()/2)-150)+10+((300/2)-8), (ScrH()-350)+45, ((300/2)-8), 130, Color(0,0,0,255) )
			draw.RoundedBox( 4, ((ScrW()/2)-150)+11+((300/2)-8), (ScrH()-350)+46, ((300/2)-8)-2, 130-2, Color( 0, 100, 255, 240 ) )
			draw.SimpleText("GUARDS", "Trebuchet24", ((ScrW()/2)-150)+10+((300/2)-8)+((300/2)-8)/2, (ScrH()-350)+50, Color(250,250,250,255), TEXT_ALIGN_CENTER, 0)
			draw.SimpleText(team.GetScore(TEAM_GUARD), "HugeFont", ((ScrW()/2)-150)+10+((300/2)-8)+((300/2)-8)/2, (ScrH()-350)+55, Color(250,250,250,255), TEXT_ALIGN_CENTER, 0)
			
		end
	end);

	roundtimeLen = 600; 
	roundtimeStart = CurTime();

	usermessage.Hook("JBRE", function(u)
		local win = u:ReadChar();
		
		if win == WIN_PRISONER then
			roundWinner = "PRISONERS";
		elseif win == WIN_GUARD then
			roundWinner = "GUARDS";
		else
			roundWinner = "DRAW";
		end
		
		roundActive = ROUND_END;
		
		protipActive = protips[math.random(1,#protips)];

		JB:KillObjective()
		
		game.CleanUpMap();
		
		surface.PlaySound("vo/k_lab/kl_initializing02.wav");
		

		endRoundHud = true;
		timer.Simple(4,function()
			roundActive = ROUND_START;
			roundtimeStart = CurTime();
			endRoundHud = false;
			timer.Simple(1,function()
				roundActive = ROUND_PLAYING;
			end);
		end);
	end);


	function JB:GetRoundTime()
		return math.Round(roundtimeLen-(CurTime()-roundtimeStart));
	end

	function JB:RoundTimeToString()
		local t= JB:GetRoundTime();

		local m= tostring(math.floor(t/60));
		local s= tostring(t-(m*60));
		if tonumber(s) < 10 then
			s= "0"..s;
		end
		
		return m..":"..s;
	end

end