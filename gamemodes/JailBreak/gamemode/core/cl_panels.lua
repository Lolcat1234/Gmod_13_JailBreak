-- cl_panels
-- some premade panels

-- error panel
JB.premadepnl = {}

local t={
"Shit is on fire yo",
"Cool story bro",
"Error",
"No way jose",
"Silly you",
}
function JB.premadepnl.error(m, KeepClicker)
	if not m then return end

	gui.EnableScreenClicker(true);

	local f=vgui.Create("pbFrame");
	f:SetSize(500, 200);
	f:SetPos(ScrW()/2-250, ScrH()/2-175);
	f.Title= t[math.random(1,#t)]
	
	local p=vgui.Create("pbPanel",f);
	p:SetSize(385,140);
	p:SetPos(5,55);
	
	local but=vgui.Create("pbSelectButton",f)
	but:SetPos(395,200-31)
	but:SetSize(100,25)
	but.Name = "Okay";
	but.DoClick = function()
		f:Remove();
		if not KeepClicker then
			gui.EnableScreenClicker(false);
		end
	end
	
	local m=JB.util.FormatLine("Jailbreak 3 version 1.0: \n"..m,"Default",365);
	local l=Label(m,p);
	l:SizeToContents();
	l:SetPos(10,10);
	l:SetColor(Color(20,20,20,255));
	
end

-- yes-no votes
function JB.premadepnl.voteYesNo(m, onYes, onNo)
	if JB.fVote and JB.fVote:IsValid() then JB.fVote:Remove() end
	
	JB.fVote=vgui.Create("pbFrame");
	JB.fVote:SetSize(280, 150);
	JB.fVote:SetPos(10, 350);
	JB.fVote.Title= "Vote";
	local cbut=vgui.Create("jbActionButton",JB.fVote);
	cbut:SetSize(25,25);
	cbut:SetPos(JB.fVote:GetWide()-40,15);
	cbut.DoClick = function()
		if JB.fVote and JB.fVote:IsValid() then
			JB.fVote:Remove();
			gui.EnableScreenClicker(false);
			return;
		end
	end
	
	local m=JB.util.FormatLine(m,"DefaultBold",260);
	local l=Label(m,JB.fVote);
	l:SetPos(10,55);
	l:SetFont("DefaultBold")
	l:SetColor(Color(20,20,20,255));
	l:SizeToContents();
	
	local l=Label("press 'C' to vote.",JB.fVote);
	l:SetFont("Default")
	l:SetColor(Color(255,255,255,255));
	l:SizeToContents();
	l:SetPos(90,29);
	
	local but=vgui.Create("jbSelectButton",JB.fVote)
	but:SetPos(10,150-35)
	but:SetSize(280/2-15,25)
	but.Name = "Yes";
	but.DoClick = function()
		JB.fVote:Remove();
		onYes()
	end
	
	local but=vgui.Create("jbSelectButton",JB.fVote)
	but:SetPos(280/2-15+20,150-35)
	but:SetSize(280/2-15,25)
	but.Name = "No";
	but.DoClick = function()
		JB.fVote:Remove();
		onYes()
	end
end

