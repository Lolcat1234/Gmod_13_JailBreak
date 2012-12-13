-- cl_mapvotes
local f;
function JB:CreateMapVoteMenu(t)
	if f and f:IsValid() then f:Remove() if timer.IsTimer("jbTimeMapVoteMenu") then timer.Remove("jbTimeMapVoteMenu") end end
	
	f=vgui.Create("pbFrame");
	f:SetSize(300, 95+30*(#t));
	f:SetPos(10, 350);
	f.Title= "Vote";
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
	
	local l=Label("x",f);
	l.t = CurTime()+30;
	l:SetPos(10,55);
	l:SetFont("DefaultBold")
	l:SetColor(Color(20,20,20,255));
	function l:Think()
		self:SetText("Select the map you want to play.\nYou have "..math.ceil(self.t - CurTime()).." seconds left to vote.")
		self:SizeToContents();
	end
	
	local l=Label("Hold 'C' to show your cursor.",f);
	l:SetFont("Default")
	l:SetColor(Color(255,255,255,255));
	l:SizeToContents();
	l:SetPos(90,29);
	
	for k,v in pairs(t)do
		local but=vgui.Create("pbSelectButton",f)
		but:SetPos(10,90+((k-1)*30));
		but:SetSize(280,25)
		but.Name = v;
		but.DoClick = function()
			f:Remove();
		end
	end

	timer.Create("jbTimeMapVoteMenu",30,1,function()
		if f and f:IsValid() then f:Remove() end
	end)
end
usermessage.Hook("JSMV",function(um) JB:CreateMapVoteMenu{um:ReadString(),um:ReadString(),um:ReadString(),um:ReadString(),um:ReadString()} end);