local BUTTON = {}
function BUTTON:Init()
	self.Hover = false;
	self.DoClick = function() 
		if not self.Table then return end
	
		LocalPlayer():ConCommand("pb_requestteam "..self.Table[2]);
		pb.menu:Remove()
		gui.EnableScreenClicker(false)
	end
	self.Table = {}
end
function BUTTON:OnCursorEntered()
	surface.PlaySound("cry_close.wav");
	self.Hover = true;
end
function BUTTON:OnCursorExited()
	self.Hover = false;
end
function BUTTON:OnMouseReleased()
	self:DoClick()
end
function BUTTON:Paint()
	if not self.Table then return end

	draw.RoundedBox(0,2,2,self:GetWide()-2,self:GetTall()-2,Color(0,0,0,200));
	draw.RoundedBox(0,0,0,self:GetWide()-2,self:GetTall()-2,Color(0,0,0,255));
	if self.Hover then
		draw.SimpleText(self.Table[1],"pbTitleFont",self:GetWide()/2-1,(self:GetTall()/2)-2,Color(255,255,255,50),1,1);
		draw.SimpleText(self.Table[1],"pbTitleFont",self:GetWide()/2+1,(self:GetTall()/2)+2,Color(255,255,255,50),1,1);
		draw.SimpleText(self.Table[1],"pbTitleFont",self:GetWide()/2-2,(self:GetTall()/2)-1,Color(255,255,255,50),1,1);
		draw.SimpleText(self.Table[1],"pbTitleFont",self:GetWide()/2+2,(self:GetTall()/2)+1,Color(255,255,255,50),1,1);
	end	
	draw.SimpleText(self.Table[1],"pbTitleFont",self:GetWide()/2,(self:GetTall()/2),Color(255,255,255,255),1,1);
end
vgui.Register( "pbMenuTeamButton", BUTTON, "Panel" );
