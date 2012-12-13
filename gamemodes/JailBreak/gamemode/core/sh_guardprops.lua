local props = {}
local function addProp(name,discr,ent,max,mdl)
	props[#props+1] = {name=name,discr=discr,ent=ent,max=max,mdl=mdl}
end
addProp("Colorful bouncy ball", "A bouncy ball used to play games. \nCan be picked up.","jb_guardprop_ball",4,"models/dav0r/hoverball.mdl")
addProp("Wooden crate", "A crate. Used for building purposes.","jb_guardprop_box",16,"models/props_junk/wood_crate001a.mdl")
addProp("Instrument", "Multi-functional instrument. Everey button makes a sound. ","jb_guardprop_music",3,"models/hunter/plates/plate1x1.mdl")

if CLIENT then
	local propFrame;
	usermessage.Hook("JOGP",function()
		if propFrame and propFrame:IsValid() then
			propFrame:Remove();
			gui.EnableScreenClicker(false);
			return;
		end

		local w=420;
		local h=55+((#props)*95);

		propFrame=vgui.Create("pbFrame");
		propFrame:SetSize(w,h)
		propFrame:SetPos((ScrW()/2)-w/2,(ScrH()/2)-h/2);
		propFrame.Title="Spawnable props";
		local cbut=vgui.Create("pbActionButton",propFrame);
		cbut:SetSize(25,25);
		cbut:SetPos(propFrame:GetWide()-40,14);
		cbut.DoClick = function() 
			if propFrame and propFrame:IsValid() then
				propFrame:Remove();
				gui.EnableScreenClicker(false);
				return;
			end
		end
		for k,v in pairs(props)do
			local mdlpnl=vgui.Create("pbPanel",propFrame);
			mdlpnl:SetSize(90,90);
			mdlpnl:SetPos(5,55+((k-1)*95))
			local mdl=vgui.Create("DModelPanel",propFrame);
			mdl:SetSize(90,90);
			mdl:SetPos(5,55+((k-1)*95))
			mdl:SetModel(v.mdl);
			mdl:SetLookAt(Vector(0,0,0))
			mdl:SetCamPos(Vector(0,70,30))

			local pnl=vgui.Create("pbPanel",propFrame);
			pnl:SetSize(w-5-5-5-90,90);
			pnl:SetPos(5+90+5,55+((k-1)*95))
			function pnl:PaintHook()
				draw.DrawText(v.name,"DefaultBold",5,5,Color(0,0,0),0,0)
				draw.DrawText("Limit: "..#ents.FindByClass(v.ent).."/"..v.max,"DefaultBold",400-5-5-5-80-10,5,Color(60,60,60),2,0)
				draw.DrawText(v.discr,"default",5,20,Color(60,60,60),0,2)
			end

			local but=vgui.Create("pbSelectButton",pnl);
			but:SetPos(pnl:GetWide()-105,pnl:GetTall()-30);
			but:SetSize(100,25);
			but.Name = "Spawn";
			but.DoClick = function()
				RunConsoleCommand("jb_spawnguardprop",k);
			end
		end
		
		gui.EnableScreenClicker(true);
	end);
elseif SERVER then
	concommand.Add("jb_spawnguardprop",function(p,c,a)
		local n=tonumber(a[1]);
		if p:Team() ~= TEAM_GUARD or not props[n] then return
		elseif #ents.FindByClass(props[n].ent) >= props[n].max then umsg.Start("JNC",p); umsg.String("You can not spawn any more of these."); umsg.String("boom"); umsg.End(); return end

		local e=ents.Create(props[n].ent);
		e:SetPos(p:EyePos()+p:GetAngles():Forward()*50);
		e:SetAngles(p:GetAngles());
		e:Spawn();
		e:Activate();
	end)
end



