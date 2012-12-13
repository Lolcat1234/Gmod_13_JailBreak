surface.CreateFont( "pbSelButFont", {
	font        = "Sports Jersey",
	size        = 22,
	weight      = 400,
	antialias   = true,
} ) 

local BUTTON = {}
function BUTTON:Init()
	self.Hover = false;
	self.Len = 23
	self.Len_min = 23
	self.DoClick = function() end
	self.Name = "Unnamed";
	self.Disabled = false;
end
function BUTTON:OnCursorEntered()
	if self.Disabled then return end
	surface.PlaySound("cry_hover.wav");
	self.Hover = true;
end
function BUTTON:OnCursorExited()
	if self.Disabled then return end
	self.Hover = false;
end
function BUTTON:OnMouseReleased()
	if self.Disabled then return end
	surface.PlaySound("cry_select.wav");
	self:DoClick()
end
function BUTTON:Paint()
	if(self.Hover and (self.Len < (self:GetWide()-4))) and not self.Disabled then
		self.Len = Lerp(0.2, self.Len, self:GetWide()-4)
	elseif self.Len>self.Len_min and (not self.Hover) then
		self.Len = Lerp(0.2, self.Len, self.Len_min)
	end

	surface.SetDrawColor(0,0,0,255);
	surface.DrawRect(0,0,self:GetWide(),self:GetTall());
	local c;
	if self.Disabled then
		surface.SetDrawColor(170,170,170,255);
		c = Color(170,170,170);
	else
		surface.SetDrawColor(200,145,23,255);
		c = Color(255,255,255);
	end
	surface.DrawRect(2,2,self.Len,self:GetTall()-4);
	draw.SimpleText(">","TargetID",(self:GetTall()/2),self:GetTall()/2,Color(0,0,0),1,1);
	draw.SimpleTextOutlined(string.upper(self.Name),"pbSelButFont",6+self:GetTall(),self:GetTall()/2-1,c,0,1,1,Color(0,0,0));	
end
vgui.Register( "pbSelectButton", BUTTON, "Panel" );
