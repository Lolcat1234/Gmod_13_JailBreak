-- sh_quickcommands.lua

JB.qcmds = {}
local function CreateQuickCommand(n,i)
	local t = {}
	t.Text = n;
	if CLIENT then
		t.Icon = surface.GetTextureID(i);
	end
	
	table.insert(JB.qcmds, t);
end

CreateQuickCommand("Move","prisonbreak/commands/arrows");
CreateQuickCommand("Use","prisonbreak/commands/exclamation");
CreateQuickCommand("Check out","prisonbreak/commands/questionmark");
CreateQuickCommand("Line up","prisonbreak/commands/lineup");
CreateQuickCommand("Destroy","prisonbreak/commands/xmark");


if CLIENT then
	local up = 0
	local up_dir = true;
	local v;
	local c;
	hook.Add("HUDPaint", "QCMDPaint", function()
		if not c or c < 1 or c > 5 then return end
		
		surface.SetTexture(JB.qcmds[c].Icon);
		surface.SetDrawColor(255,255,255,255)
			
		local m = math.Round(v:Distance(LocalPlayer():GetPos())); m= string.Left(m, string.len(m)-2);
		local p = v:ToScreen();
		p.y = p.y-12.5
		
		if p.x+15 > ScrW() then
			p.x = ScrW()-25;
		elseif p.x < 0 then
			p.x = 25;
		end
		
		if p.y+up+54 > ScrH() then
			p.y = ScrH()-55;
		elseif p.y+up < 0 then
			p.y = 3;
		else
			if up_dir then
			up = up + 0.1;
			else
				up = up - 0.1;
			end
			
			if up < 0 then
				up_dir = true;
			elseif up > 10 then
				up_dir = false;
			end
		end
		
		surface.DrawTexturedRect(p.x-12.5,p.y+up,25,25);
		draw.SimpleTextOutlined(JB.qcmds[c].Text, "DefaultBold", p.x, p.y+25+up, Color(223,223,223,180), 1,0,1,Color(0,0,0,100));
		draw.SimpleTextOutlined((m or 0).." m", "Default", p.x, p.y+37+up, Color(223,223,223,180), 1,0,1,Color(0,0,0,100));
	end)

	usermessage.Hook("JBSQC",function(u)
		v = u:ReadVector();
		c = tonumber(u:ReadChar());

		JB:DebugPrint("Quick command set: "..c)
	end)
elseif SERVER then
	SetGlobalInt("cmd",0);
	SetGlobalVector("cmdpos",Vector(0,0,0));
	
	function JB:SetQuickCommand(n,p)
		umsg.Start("JBSQC");
		umsg.Vector(p);
		umsg.Char(n);
		umsg.End();
	end
	
	local LastCmd = CurTime();
	concommand.Add("jb_doqcmd", function(p,c,a)
		if p:Team() ~= TEAM_GUARD
		or LastCmd+1 > CurTime() then return end
		
		LastCmd = CurTime();
		JB:SetQuickCommand(math.Round(tonumber(a[1])), p:GetEyeTraceNoCursor().HitPos + Vector(0,0,0))
	end)
end