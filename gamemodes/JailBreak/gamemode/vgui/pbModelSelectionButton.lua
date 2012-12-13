-- This is for the model selection windows :3
local BUTTON = {}
function BUTTON:Init()
	self.Hover = false;
	self.Model = "models/player/Group01/male_09.mdl";
	self.DoClick = function() end
end
function BUTTON:OnCursorEntered()
	surface.PlaySound("buttons/lightswitch2.wav");
	self.Hover = true;
end
function BUTTON:OnCursorExited()
	self.Hover = false;
end
function BUTTON:OnMouseReleased()
	self:DoClick();
end
function BUTTON:LayoutEntity()
	if self.Hover then
		self:RunAnimation();
	end
end
function BUTTON:PaintOver()
	draw.RoundedBox(0,0,0,self:GetWide(),8,Color(0,0,0,100));
	draw.RoundedBox(0,0,8,5,self:GetTall()-8,Color(0,0,0,100));
	
	draw.RoundedBox(0,5,8,self:GetWide()-5,1,Color(0,0,0,100));
	draw.RoundedBox(0,5,8,1,self:GetTall()-8,Color(0,0,0,100));
	if self.Hover then return end
	draw.RoundedBox(0,0,0,self:GetWide(),self:GetTall(),Color(0,0,0,150));
end
vgui.Register("pbModelSelectionButton",BUTTON,"DModelPanel")--Attention: Deviate is NOT directly Panel.