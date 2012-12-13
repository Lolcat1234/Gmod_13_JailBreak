local arrowtex = surface.GetTextureID("prisonbreak/arrow");

local BUTTON = {}
function BUTTON:Init()
	self.Hover = false;
	self.DoClick = function() end
	self.Rotation = 0;
end
function BUTTON:OnCursorEntered()
	self.Hover = true;
end
function BUTTON:OnCursorExited()
	self.Hover = false;
end
function BUTTON:OnMouseReleased()
	self:DoClick();
end
function BUTTON:Paint()
	surface.SetTexture(arrowtex);
	surface.SetDrawColor(255,255,255,255);
	surface.DrawTexturedRectRotated(self:GetWide()/2,self:GetTall()/2,self:GetWide(),self:GetTall(),self.Rotation);

end
vgui.Register("pbArrowButton",BUTTON,"Panel")