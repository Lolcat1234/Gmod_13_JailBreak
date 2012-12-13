local sin = math.sin;
local banner = surface.GetTextureID("vgui/jb_banner");

local PNL = { }
function PNL:Paint()
	surface.SetDrawColor(0,0,0,100)
	surface.DrawRect(0,0,self:GetWide(), self:GetTall())	
	surface.SetDrawColor(255,255,255,100)
	surface.DrawRect(1,1,self:GetWide()-2, self:GetTall()-2)

	surface.SetTexture(banner);
	surface.SetDrawColor(255,255,255,255);
	surface.DrawTexturedRect(2,2,512,128)

	surface.SetDrawColor(0,0,0,230)
	surface.DrawRect((self:GetWide()/2)+1,131,(self:GetWide()/2)-3, 20)
	surface.SetDrawColor(255,255,255,5)
	surface.DrawRect((self:GetWide()/2)+1,131,(self:GetWide()/2)-3, 10)
	
	surface.SetDrawColor(0,0,0,230)
	surface.DrawRect(2,131,(self:GetWide()/2)-3, 20)
	surface.SetDrawColor(255,255,255,5)
	surface.DrawRect(2,131,(self:GetWide()/2)-3, 10)

	draw.SimpleTextOutlined("Nickname", "Default",48,134, Color(255,255,255),0,0,1, Color(0,0,0,50))
	draw.SimpleTextOutlined("Ping", "Default",(self:GetWide()/2)-10,134, Color(255,255,255),2,0,1, Color(0,0,0,50))
	draw.SimpleTextOutlined("Points", "Default",(self:GetWide()/2)-45,134, Color(255,255,255),2,0,1, Color(0,0,0,50))

	draw.SimpleTextOutlined("Nickname", "Default",(self:GetWide()/2)+48,134, Color(255,255,255),0,0,1, Color(0,0,0,50))
	draw.SimpleTextOutlined("Ping", "Default",self:GetWide()-10,134, Color(255,255,255),2,0,1, Color(0,0,0,50))
	draw.SimpleTextOutlined("Points", "Default",self:GetWide()-45,134, Color(255,255,255),2,0,1, Color(0,0,0,50))

	local tSpec = team.GetPlayers(TEAM_SPECTATOR);

	local s="Spectators: ";
	for k,v in pairs(tSpec) do
		s=s..v:Nick().." ";
	end

	if #tSpec < 1 then s=s.."none" end

	surface.SetDrawColor(0,0,0,230);
	surface.DrawRect(2,self:GetTall()-22,self:GetWide()-4, 20);
	draw.SimpleTextOutlined(s, "DefaultBold",self:GetWide()/2,self:GetTall()-20, Color(255,255,255),1,0,1, Color(0,0,0,50));
end
vgui.Register( "jbScoreboardPanel", PNL, "Panel" );


--Player rows
--For players
PNL = { }
function PNL:Init()
	self.Player = Entity(1);
end
function PNL:SetUp(p)
	self.Player = p;

	local avatar= vgui.Create("AvatarImage", self);
	avatar:SetSize(32, 32);
	avatar:SetPos(4,4);
	avatar:SetPlayer( p, 32 );
end
function PNL:Paint()
	local p=self.Player;
	if not p or not p:IsValid() then return end

	local alpha = 200;
	if p == LocalPlayer() then
		alpha= 225+(25*(sin(CurTime()*2)));
	end
	local col = team.GetColor(p:Team());
	surface.SetDrawColor(col.r,col.g,col.b, alpha);
	surface.DrawRect(0,0,self:GetWide(), self:GetTall());
	surface.SetDrawColor(0,0,0,130);
	surface.DrawRect(3,3,34,34);
	
	
	draw.SimpleTextOutlined(string.Left(p:Nick(),15), "Trebuchet22", 45,1, Color(255,255,255),0,0,1, Color(0,0,0,150));
	local t=team.GetName(p:Team());
	if p:IsAwesome() then
		t=t.." | DEV"
	end
	draw.SimpleTextOutlined(t, "DefaultBold", 46,22, Color(255,255,255),0,0,1, Color(0,0,0,150));
	
	local bars = 4;
	local col = Color(80,255,20)
	if p:Ping() > 250 then
		bars=1;
		col = Color(255,0,0);
	elseif p:Ping() > 200 then
		bars=1;
		col = Color(255,153,0);
	elseif p:Ping() > 150 then
		bars=1;
	elseif p:Ping() > 100 then
		bars=2;
	elseif p:Ping() > 50 then
		bars=3;
	end
	
	local x=self:GetWide()-38;
	--draw.SimpleTextOutlined(p:Ping(), "DefaultBold", x+4,22, Color(255,255,255),2,0,1, Color(0,0,0,150))
	for i=1,4 do
		surface.SetDrawColor(0,0,0,255);
		surface.DrawRect(x+i*5+5, 21-i*3 ,4,6+i*3);
		
		if i <= bars then
			surface.SetDrawColor(col.r,col.g,col.b,255);
			surface.DrawRect(x+i*5+6, 22-i*3 ,2,4+i*3);
		end
	end

	local x=self:GetWide()-40;
	surface.SetDrawColor(0,0,0,100);
	surface.DrawRect(x-36,0,40,self:GetTall());
	draw.SimpleTextOutlined(p:Frags(), "TargetID", x-19,8, Color(255,255,255),1,0,1, Color(0,0,0,150))
	
end
vgui.Register( "jbScoreboardRow", PNL, "Panel" );