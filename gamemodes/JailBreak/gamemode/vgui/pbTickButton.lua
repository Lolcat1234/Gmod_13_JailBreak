-- pbTickButton

surface.CreateFont ("Sports Jersey", 22, 400, true, false, "pbSelButFont");

local BUTTON = {}
function BUTTON:Init()
	self.Hover = false;
	self.sel = false;
	self.DoClick = function() end
	self.Name = "Unnamed";
end
function BUTTON:OnCursorEntered()
	surface.PlaySound("cry_hover.wav");
	self.Hover = true;
end
function BUTTON:OnCursorExited()
	self.Hover = false;
end
function BUTTON:OnMouseReleased()
	surface.PlaySound("cry_select.wav");
	self:DoClick()
end
function BUTTON:SetSelected(b)
	self.sel = b;
end
function BUTTON:Paint()
	surface.SetDrawColor(0,0,0,255);
	surface.DrawRect(0,0,self:GetWide(),self:GetTall());
	surface.SetDrawColor(200,145,23,255);
	if self.sel then
		surface.DrawRect(2,2,self:GetWide()-4, self:GetTall()-4);
	end
	if self.Hover then
		draw.SimpleText(string.upper(self.Name),"pbSelButFont",self:GetWide()/2+1,self:GetTall()/2+1,Color(255,255,255,50),1,1);	
		draw.SimpleText(string.upper(self.Name),"pbSelButFont",self:GetWide()/2-1,self:GetTall()/2-1,Color(255,255,255,50),1,1);	
	end
	draw.SimpleText(string.upper(self.Name),"pbSelButFont",self:GetWide()/2,self:GetTall()/2-1,Color(255,255,255),1,1);	
end
vgui.Register( "pbTickButton", BUTTON, "Panel" );
