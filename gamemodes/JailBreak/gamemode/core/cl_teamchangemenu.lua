-- cl_teamchangemenu.lua

local teamchangepanel
local function SetChary(n,lab1,lab2,mdlp,w)
	lab1:SetText(JB.Characters.Prisoner[n].name)
	lab1:SetFont("DefaultBold");
	lab1:SizeToContents();
	lab2:SetText(JB.util.FormatLine(JB.Characters.Prisoner[n].background,"default",w));
	lab2:SetFont("DefaultBold");
	lab2:SetPos(5,20);
	lab2:SizeToContents();
	mdlp:SetModel(JB.Characters.Prisoner[n].model);
	mdlp:SetSize( 350, 350 )
	mdlp:SetPos(-80,30)
	mdlp:SetCamPos( Vector( 80, 0, 40 ) )
	mdlp:SetLookAt( Vector( 0, 0, 40 ) )
	mdlp.LayoutEntity = function() end;
end
local selChr = 1;
usermessage.Hook("JBOTCM",function()
	if LocalPlayer():Team() == TEAM_SPECTATOR then return end
	if teamchangepanel and teamchangepanel:IsValid() then gui.EnableScreenClicker(false); timer.Remove("JBInGameCHarCheckIfWeCanActuallyJoinThisTeam"); teamchangepanel:Remove(); return; end

	gui.EnableScreenClicker(true);

	teamchangepanel = vgui.Create("pbFrame");
	teamchangepanel.Title = "Team change";
	teamchangepanel:SetSize(400,420);
	teamchangepanel:SetPos((ScrW()/2)-(teamchangepanel:GetWide()/2),(ScrH()/2)-(teamchangepanel:GetTall()/2));
	local cbut=vgui.Create("pbActionButton",teamchangepanel);
	cbut:SetSize(25,25);
	cbut:SetPos(teamchangepanel:GetWide()-40,13);
	cbut.DoClick = function()
		if teamchangepanel and teamchangepanel:IsValid() then gui.EnableScreenClicker(false); timer.Remove("JBInGameCHarCheckIfWeCanActuallyJoinThisTeam"); teamchangepanel:Remove(); return; end
	end

	local mPri = vgui.Create( "DModelPanel", teamchangepanel)
	mPri:SetModel("models/Humans/Group01/Male_02.mdl")
	mPri:SetSize( 350, 350 )
	mPri:SetPos(-80,30)
	mPri:SetCamPos( Vector( 80, 0, 40 ) )
	mPri:SetLookAt( Vector( 0, 0, 40 ) )
	mPri.LayoutEntity = function(self) 
	end;
	local sPri = vgui.Create( "pbSelectButton",teamchangepanel);
	sPri.Name = "Prisoners"
	sPri:SetSize((teamchangepanel:GetWide()/2)-5-10,25);
	sPri:SetPos(10,teamchangepanel:GetTall()-25-10);
	local mGua = vgui.Create( "DModelPanel", teamchangepanel)
	mGua:SetModel("models/player/police.mdl")
	mGua:SetSize( 350, 350 )
	mGua:SetPos(teamchangepanel:GetWide()+70-350,30)
	mGua:SetCamPos( Vector( 80, 0, 40 ) )
	mGua:SetLookAt( Vector( 0, 0, 40 ) )
	mGua.LayoutEntity = function(self) 
	end;
	local sGua = vgui.Create( "pbSelectButton",teamchangepanel);
	sGua.Name = "Guards"
	sGua:SetSize((teamchangepanel:GetWide()/2)-5-10,25);
	sGua:SetPos(teamchangepanel:GetWide()/2+5,teamchangepanel:GetTall()-25-10);
	sGua.DoClick = function() 
		RunConsoleCommand("jb_menu_selectcharacter_ingame","guard",1)
		if teamchangepanel and teamchangepanel:IsValid() then gui.EnableScreenClicker(false); timer.Remove("JBInGameCHarCheckIfWeCanActuallyJoinThisTeam"); teamchangepanel:Remove(); return; end
	end
	sPri.sGua = sGua;
	sPri.mGua = mGua;
	local full = vgui.Create("DImage",teamchangepanel);
	full:SetPos(teamchangepanel:GetWide()-80,70);
	full:SetSize(74,74);
	full:SetImage("excljailbreak/full")
	full:SetVisible(false);
	timer.Create("JBInGameCHarCheckIfWeCanActuallyJoinThisTeam",.2,0,function() 
		if not teamchangepanel or not teamchangepanel:IsValid() or not full or not full:IsValid() then return end
		if JB:CanBeGuard() then
			full:SetVisible(false);
			sGua.Disabled = false;
		else
			full:SetVisible(true)
			sGua.Disabled = true;
		end
	end)

	sPri.DoClick = function(self)
		if full and full:IsValid() then full:Remove(); end
		
		self:Remove();
		self.sGua.Name = "Select";
		self.mGua:Remove();
		self.sGua.DoClick = function()
			RunConsoleCommand("jb_menu_selectcharacter_ingame","prisoner",selChr)
			if teamchangepanel and teamchangepanel:IsValid() then gui.EnableScreenClicker(false); timer.Remove("JBInGameCHarCheckIfWeCanActuallyJoinThisTeam"); teamchangepanel:Remove(); return; end
		end
		self.sGua.Disabled = false;
		local bNxt = vgui.Create("pbTickButton",teamchangepanel);
		bNxt:SetPos((teamchangepanel:GetWide()/2-10-5)/2+15,teamchangepanel:GetTall()-25-10);
		bNxt:SetSize((teamchangepanel:GetWide()/2-10-5)/2-5,25)
		bNxt.Name = "Next";
		local bPrv = vgui.Create("pbTickButton",teamchangepanel);
		bPrv:SetPos(10,teamchangepanel:GetTall()-25-10);
		bPrv:SetSize((teamchangepanel:GetWide()/2-10-5)/2-5,25)
		bPrv.Name = "Previous";
		local pDiscr = vgui.Create("pbPanel",teamchangepanel);
		pDiscr:SetPos(teamchangepanel:GetWide()/2+5,60)
		pDiscr:SetSize(teamchangepanel:GetWide()/2-15,teamchangepanel:GetTall()-60-10-10-25)
		local lbl = Label("peoeoeoepeoo",pDiscr)
		lbl:SetPos(5,30);
		lbl:SetSize(pDiscr:GetWide()-10,pDiscr:GetTall()-10);
		lbl:SetColor(Color(0,0,0,255));
		lbl:SetExpensiveShadow( 1, Color( 0, 0, 0, 100 ) )
		local txt = Label("peoeoeoepeoo",pDiscr)
		txt:SetPos(5,5);
		txt:SizeToContents();
		txt:SetColor(Color(0,0,0,255));
		txt:SetExpensiveShadow( 1, Color( 0, 0, 0, 100 ) )

		bNxt.DoClick = function()
			selChr = selChr+1;
			if selChr > #JB.Characters.Prisoner then
				selChr = 1;
			end
			SetChary(selChr,txt,lbl,mPri,pDiscr:GetWide()-15);
		end
		bPrv.DoClick = function()
			selChr = selChr+1;
			if selChr < 1 then
				selChr = #JB.Characters.Prisoner;
			end
			SetChary(selChr,txt,lbl,mPri,pDiscr:GetWide()-15);
		end

		SetChary(1,txt,lbl,mPri,pDiscr:GetWide()-15);
	end
end)