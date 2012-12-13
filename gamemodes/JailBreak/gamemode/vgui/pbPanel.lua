local PNL = {}

function PNL:Init()
	self.PaintHook = false;
end
function PNL:Paint()
	surface.SetDrawColor(0,0,0,255);
	surface.DrawRect(0,0,self:GetWide(),1);
	surface.DrawRect(0,self:GetTall()-1,self:GetWide(),1);
	surface.DrawRect(0,0,1,self:GetTall());
	surface.DrawRect(self:GetWide()-1,0,1,self:GetTall());
	surface.SetDrawColor(255,255,255,100);
	surface.DrawRect(1,1,self:GetWide()-2, self:GetTall()-2);
	
	if self.PaintHook and (type(self.PaintHook)=="function") then
		self.PaintHook();
	end
end
vgui.Register( "pbPanel", PNL, "Panel" );