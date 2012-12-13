 -- other LR stuff

lrs = {}

local function faceEntity(ea,eb)
	return (eb:LocalToWorld(eb:OBBCenter()) - ea:GetPos()):Angle() + Angle(0,0,0)
end

function JB:GetLRs()
	return lrs;
end
local function addLR(name,discr,mat,numpoints,lrhooks)
	if not lrhooks or type(lrhooks) ~= "table" then 
		lrhooks = {} 
	end
	lrs[#lrs+1] = {name=name,discr=discr,mat=mat,numpoints=numpoints,lrhooks=lrhooks};
end

addLR("Knife fight","Guard and prisoner get a knife, all other weapons will be stripped, they keep fighting until one of both dies. The winner is the last person standing.",
	"HUD/derma/knife",0,{
	OnStart = function(p,g)
		p:SetColor(Color(255,0,0,255))
		g:SetColor(Color(255,0,0,255))

		p:StripWeapons();
		g:StripWeapons();

		p:Give("jb_knife");
		g:Give("jb_knife");

		if not p:Crouching() then
			g:SetPos(p:GetPos());
		end
	end,
	OnGuardDied = function(self)
		activeLR:End();
	end,
	OnPrisonerDied = function(self)
		activeLR:End();
	end
})
if SERVER then
hook.Add( "ShouldCollide", "LRKnifefightTriggerCheck", function(ea,eb)
	if activeLR and activeLR.Name == "Knife fight" then
		if ea:IsPlayer() and eb:IsPlayer() then
			return false;
		end
	end
end)
end
addLR("Race","The requesting prisoner and the guard will race from a predefined point to another predefined point.",
	"HUD/derma/race",2,{
	OnStart = function(p,g)
		p:SetColor(Color(255,0,0,255))
		g:SetColor(Color(255,0,0,255))

		p:StripWeapons();
		g:StripWeapons();

		p:Freeze(true);
		g:Freeze(true);

		p:SetPos(JB:GetMapConfigLR()["Race"][1]);
		g:SetPos(JB:GetMapConfigLR()["Race"][1]);

		local t = ents.Create("jb_trigger");
		t.min = t:SetPos(JB:GetMapConfigLR()["Race"][2] + Vector(50,50,50));
		t.max = t:SetPos(JB:GetMapConfigLR()["Race"][2] - Vector(50,50,50));
		t:Spawn();
	
		umsg.Start("JLRRace", {p,g}); umsg.Vector(JB:GetMapConfigLR()["Race"][2]); umsg.End();
		timer.Simple(5,function(p,g) 
			p:Freeze(false);
			g:Freeze(false);
		end,p,g)

	end,
	OnGuardDied = function(self)
		activeLR:End();
	end,
	OnPrisonerDied = function(self)
		activeLR:End();
	end
})
if SERVER then
hook.Add( "ShouldCollide", "LRRaceTriggerCheck", function(ea,eb)
	if activeLR and activeLR.Name == "Race" then
		if SERVER then
		if ea:IsPlayer() and (eb:GetClass() == "jb_trigger") then
			if ea == activeLR.prisoner then
				activeLR.guard:Kill();
			else
				activeLR.prisoner:Kill();
			end
			return false;
		end
		end
		if ea:IsPlayer() and eb:IsPlayer() then
			return false;
		end
	end
end)
end
local RRGun = NULL;
local RRStuff = {};
addLR("Russian roulette","One gun, one bullet, spin the chamber and take a shot. It's all about luck.",
	"HUD/derma/guntoss",1,{
	OnStart = function(p,g)
		p:SetColor(Color(255,0,0,255))
		g:SetColor(Color(255,0,0,255))

		local n = JB:GetMapConfigLR()["Russian roulette"][1]
		local v;
		for i=1,2 do
			v = ents.Create("prop_vehicle_prisoner_pod");
			v:SetModel("models/nova/chair_plastic01.mdl");
			v:SetPos(n);
			v:Spawn();
			v:Activate();

			local phys = v:GetPhysicsObject();
			if phys:IsValid() then
			    phys:EnableGravity(false);
			    phys:EnableMotion(false);
			end

			if i == 1 then
				g:EnterVehicle(v);
			else
				v:SetAngles(Angle(0,180,0));
				p:EnterVehicle(v);
			end

			RRStuff["chair"..i] = v;

			n = n+(v:GetAngles():Right()*-80);
		end

		local t = ents.Create("prop_physics_multiplayer");
		t:SetPos(n+(v:GetAngles():Right()*40) + Vector(0,0,15));
		t:SetModel("models/props_c17/FurnitureTable001a.mdl");
		t:Spawn();
		t:Activate();

		RRStuff.table = t;

		local phys = t:GetPhysicsObject();
		if phys:IsValid() then
			phys:EnableGravity(false);
		    phys:EnableMotion(false);
		end

		RRGun = ents.Create("prop_physics_multiplayer");
		RRGun:SetPos(n+(v:GetAngles():Right()*40)+Vector(-8,-5,33));
		RRGun:SetAngles(Angle(0,45,90))
		RRGun:SetModel("models/weapons/w_pist_deagle.mdl");
		RRGun:Spawn();
		RRGun:Activate();

		local phys = RRGun:GetPhysicsObject();
		if phys:IsValid() then
			phys:EnableGravity(false);
		    phys:EnableMotion(false);
		end

		umsg.Start("JLRRRRRR",p);
		umsg.Vector(n+(v:GetAngles():Right()*40)+Vector(-8,-5,33));
		umsg.End();

	end,
	OnGuardDied = function(self)
		activeLR:End();
	end,
	OnPrisonerDied = function(self)
		activeLR:End();
	end
})
if SERVER then
hook.Add("KeyRelease","RUssianKeyPressJB",function(p,k)
	if k == IN_USE and activeLR and activeLR.Name == "Russian roulette" and RRGun and ValidEntity(RRGun) then
		RRGun.rotating = true;
		timer.Simple(math.random(3,5),function()
			RRGun.rotating = false;
			if math.random(1,2) == 1 then
				activeLR.prisoner:Kill();
			else
				activeLR.guard:Kill();
			end

			for k,v in pairs(RRStuff)do
				if v and v:IsValid() then
					v:Remove();
				end
			end
			RRGun:Remove();
		end)	
	end
end)
end
addLR("Hot potato","The prisoner and the guard attempt to jump on top of each other, the one who gets jumped on loses.",
	"HUD/derma/hotpotato",0,{
	OnStart = function(p,g)
		p:SetColor(Color(255,0,0,255))
		g:SetColor(Color(255,0,0,255))

	end,
	OnGuardDied = function(self)
		activeLR:End();
	end,
	OnPrisonerDied = function(self)
		activeLR:End();
	end
})
addLR("Shot4Shot","Prisoner and guard shoot each other, they take turns, every turn allows 1 shot to be fired at the opponent.",
	"HUD/derma/shot4shot",2,{
	OnStart = function(p,g)
		p:SetColor(Color(255,0,0,255))
		g:SetColor(Color(255,0,0,255))				

		p:StripWeapons();
		g:StripWeapons();

		p:Give("jb_lr_s4s");
		g:Give("jb_lr_s4s");

		if not JB:GetMapConfigLR() or not JB:GetMapConfigLR()["Shot4Shot"] then return end
		p:SetPos(JB:GetMapConfigLR()["Shot4Shot"][1])
		g:SetPos(JB:GetMapConfigLR()["Shot4Shot"][2])

	end,
	OnGuardDied = function(self)
		activeLR:End();
	end,
	OnPrisonerDied = function(self)
		activeLR:End();
	end
})
addLR("Precision Throwing","Farest throw wins..",
	"HUD/derma/noscope",3,{
	OnStart = function(p,g)
		p:SetColor(Color(255,0,0,255))
		g:SetColor(Color(255,0,0,255))

	end,
	OnGuardDied = function(self)
		activeLR:End();
	end,
	OnPrisonerDied = function(self)
		activeLR:End();
	end
})

if SERVER then
	hook.Add("Think","POWOQODQIW",function()
		if activeLR and activeLR.Name == "Russian roulette" and RRGun and ValidEntity(RRGun) and RRGun.rotating then
			RRGun:SetAngles(Angle(0,RRGun:GetAngles().y+20,90));
		end
	end)

	function JB:StartLR(n,p,g)
		local lr = JB:LastRequest();
		lr:AddPlayers(p,g);
		lr:LoadTemplate(lrs[n]);
		lr();
		
	end

	concommand.Add("jb_lr_start",function(p,c,a)
		JB:DebugPrint("Starting LR")
		local g = team.GetPlayers(TEAM_GUARD)[tonumber(a[1])];
		if not g or not tonumber(a[2]) or not g:IsValid() or not lrs[tonumber(a[2])] or #team.GetPlayers(TEAM_PRISONER) ~= 1 or g:Team() ~= TEAM_GUARD then JB:DebugPrint("Error when starting LR") return end

		JB:StartLR(tonumber(a[2]),p,g);
	end)

elseif CLIENT then
	local function DrawLRText(t)
		draw.SimpleTextOutlined("Press [F3] to set the race starting point.\nThen press [F3] again to set the end point.","HUDNumber5",ScrW()/2,ScrH()/2,Color(255,255,255,255),1,1,1,Color(0,0,0,255))
	end
	hook.Add("HUDPaint","DrawJailBreakLRRaceThingy",function()
		
	end)

	usermessage.Hook("JLRRace",function(u)
		JB:HUDStartTimer(5,"Last Request: Race")
		JB:SetObjective(u:ReadVector(),"Race","Finish, get here first to win the Last Request")
	end)
	
	usermessage.Hook("JLRRRRRR",function(u)
		JB:SetObjective(u:ReadVector(),"Russian Roulette","Press E to take a spin");
	end)

	local lrFrame;
	usermessage.Hook("JOLR",function()
		if lrFrame and lrFrame:IsValid() then
			lrFrame:Remove();
			gui.EnableScreenClicker(false);
			return;
		end

		local w=420;
		local h=55+((#lrs)*95);

		lrFrame=vgui.Create("pbFrame");
		lrFrame:SetSize(w,h)
		lrFrame:SetPos((ScrW()/2)-w/2,(ScrH()/2)-h/2);
		lrFrame.Title="Last Requests";
		local cbut=vgui.Create("pbActionButton",lrFrame);
		cbut:SetSize(25,25);
		cbut:SetPos(lrFrame:GetWide()-40,14);
		cbut.DoClick = function()
			if lrFrame and lrFrame:IsValid() then
				lrFrame:Remove();
				gui.EnableScreenClicker(false);
				return;
			end
		end

		local lrPnls = {}
		for k,v in pairs(lrs)do
			local mdlpnl=vgui.Create("pbPanel",lrFrame);
			mdlpnl:SetSize(90,90);
			mdlpnl:SetPos(5,55+((k-1)*95))

			local pnl=vgui.Create("pbPanel",lrFrame);
			pnl:SetSize(w-5-5-5-90,90);
			pnl:SetPos(5+90+5,55+((k-1)*95))
			function pnl:PaintHook()
				draw.DrawText(v.name,"DefaultBold",5,5,Color(0,0,0),0,0)
				draw.DrawText(JB.util.FormatLine(v.discr,"default",w-5-5-5-90-20),"default",5,20,Color(60,60,60),0,2)
			end
			local img=vgui.Create("DImage",mdlpnl);
			img:SetImage(v.mat);
			img:SetSize(mdlpnl:GetWide()-4,mdlpnl:GetTall()-4);
			img:SetPos(2,2)

			local but=vgui.Create("pbSelectButton",pnl);
			but:SetPos(pnl:GetWide()-105,pnl:GetTall()-30);
			but:SetSize(100,25);
			but.Name = "Choose";
			but.DoClick = function()
				local selectedLR = k;
				but:Remove();
				pnl:SetPos(5+90+5,55);
				lrFrame:SetSize(lrFrame:GetWide(),55+90+5+25+#team.GetPlayers(TEAM_GUARD)*30+5)
				lrFrame:SetPos((ScrW()/2)-(lrFrame:GetWide()/2),(ScrH()/2)-(lrFrame:GetTall()/2))
				mdlpnl:SetPos(5,55);

				for k,v in pairs(lrPnls)do
					if v ~= pnl and v ~=mdlpnl then
						v:Remove();
					end
				end

				local pnl=vgui.Create("pbPanel",lrFrame);
				pnl:SetSize(w-10,25+#team.GetPlayers(TEAM_GUARD)*30);
				pnl:SetPos(5,55+90+5);
				function pnl:PaintHook()
					draw.DrawText("Select the guard you want to play with:","DefaultBold",5,5,Color(0,0,0),0,0)
				end

				for k,v in pairs(team.GetPlayers(TEAM_GUARD))do
					local but=vgui.Create("pbSelectButton",pnl);
					but:SetPos(5,25+(k-1)*30);
					but:SetSize(pnl:GetWide()-10,25);
					but.Name = v:Nick();
					but.DoClick = function()
						RunConsoleCommand("jb_lr_start",k,selectedLR);

						if lrFrame and lrFrame:IsValid() then
							lrFrame:Remove();
							gui.EnableScreenClicker(false);
							return;
						end
					end
				end
			end

			table.insert(lrPnls,pnl)
			table.insert(lrPnls,mdlpnl)
		end
		
		gui.EnableScreenClicker(true);
	end);
end