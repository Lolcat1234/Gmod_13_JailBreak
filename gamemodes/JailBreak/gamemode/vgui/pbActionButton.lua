local BUTTON = {}
function BUTTON:Init()
	self.Hover = false;
	self.DoClick = function() end
	self.Char = "X";
end
function BUTTON:OnCursorEntered()
	self.Hover = true;
end
function BUTTON:OnCursorExited()
	self.Hover = false;
end
function BUTTON:OnMouseReleased()
	self:DoClick()
end
function BUTTON:Paint()
	surface.SetDrawColor(213,213,213,255);
	surface.DrawRect(0,0,self:GetWide(),self:GetTall());
	surface.SetDrawColor(0,0,0,255);
	surface.DrawRect(1,1,self:GetWide()-2,self:GetTall()-2);
	surface.SetDrawColor(213,213,213,255);
	surface.DrawRect(3,3,self:GetWide()-6,self:GetTall()-6);
	
	local c=Color(0,0,0);
	if self.Hover then
		surface.SetDrawColor(200,145,23,255);
		surface.DrawRect(4,4,self:GetWide()-8,self:GetTall()-8);	
		c=Color(255,255,255);
	end
	
	draw.SimpleText(string.upper(self.Char),"TargetID",self:GetTall()/2,self:GetTall()/2-1,c,1,1);		
end
vgui.Register( "pbActionButton", BUTTON, "Panel" );
