-- cl_warden

local f;
function JB:CreateHasMic()
	if f and f:IsValid() then f:Remove() end
	
	f=vgui.Create("pbFrame");
	f:SetSize(280, 150);
	f:SetPos(10, 350);
	f.Title= "Mic";
	local cbut=vgui.Create("pbActionButton",f);
	cbut:SetSize(25,25);
	cbut:SetPos(f:GetWide()-40,15);
	cbut.DoClick = function()
		if f and f:IsValid() then
			f:Remove();
			gui.EnableScreenClicker(false);
			return;
		end
	end
	
	local l=Label("Do you have a microphone?\nYou will be added to the list if you do.\nA random person in the list will be warden.",f);
	l:SetPos(10,55);
	l:SetFont("DefaultBold")
	l:SetColor(Color(20,20,20,255));
	l:SizeToContents();
	
	local l=Label("Hold 'C' to show your cursor.",f);
	l:SetFont("Default")
	l:SetColor(Color(255,255,255,255));
	l:SizeToContents();
	l:SetPos(90,29);
	
	local but=vgui.Create("pbSelectButton",f)
	but:SetPos(10,150-35)
	but:SetSize(280/2-15,25)
	but.Name = "Yes";
	but.DoClick = function()
		f:Remove();
		RunConsoleCommand("jb_hasmic",1)
	end
	
	local but2=vgui.Create("pbSelectButton",f)
	but2:SetPos(280/2-15+20,150-35)
	but2:SetSize(280/2-15,25)
	but2.Name = "No";
	but2.DoClick = function()
		f:Remove();
		RunConsoleCommand("jb_hasmic",0)
	end
end
usermessage.Hook("JSHM",function() JB:CreateHasMic() end);

usermessage.Hook("JRSW",function()
	JB.wardenPlayer =nil;
end)
usermessage.Hook("JSWP",function(um)
	JB.wardenPlayer =um:ReadEntity();
end)

local tri = {{x=-10,y=30},{x=10,y=30},{x=0,y=50}}
hook.Add( "PostPlayerDraw", "JBWardenDrawName", function()
 	if JB.wardenPlayer and JB.wardenPlayer == ply then
		local offset = Vector( 0, 0, 85 )
		local ang = LocalPlayer():EyeAngles()
		local pos = ply:GetPos() + offset + ang:Up()
	 
		ang:RotateAroundAxis( ang:Forward(), 90 )
		ang:RotateAroundAxis( ang:Right(), 90 )

		surface.SetFont("TargetID");
		surface.SetDrawColor(0,0,0,255)
		local w,h = surface.GetTextSize("WARDEN");
		w=w+15

		cam.Start3D2D( pos, Angle( 0, ang.y, ang.r), 0.25 )
			draw.RoundedBox(6,-w/2,-3,w,30,Color(0,0,0))
			draw.RoundedBox(6,(-w/2)+1,-2,w-2,28,Color(213,213,213))
			surface.SetDrawColor(0,0,0,255)
			surface.DrawPoly(tri)
			draw.DrawText( "WARDEN", "TargetID", 0,0, Color(0,0,0), TEXT_ALIGN_CENTER )
		cam.End3D2D()
 	end
end)
