-- Notification system
local randomnotes = {
"You can press [F1] to view the help menu.",
"_NewBee is awesome and stuff",
"Cows grow in trees.",
"At the end of everey round you can view your very own protip.",
"You can view our VIP benefits at our website.",
}
local meta={}
JB.notify = {}
JB.notify.tbl = {}
JB.notify.icons = {}
JB.notify.icons["boom"] =surface.GetTextureID("prisonbreak/notices/cleanup");
JB.notify.icons["generic"] =surface.GetTextureID("prisonbreak/notices/generic");
JB.notify.icons["error"]	=surface.GetTextureID("prisonbreak/notices/error");
JB.notify.icons["undo"] =surface.GetTextureID("prisonbreak/notices/undo");
JB.notify.icons["hint"] =surface.GetTextureID("prisonbreak/notices/hint");

function meta:SetText(s)
	if not s then s="Unidentified"; end
	surface.SetFont("DefaultBold");
	
	local w=surface.GetTextSize(s);	
	self.Text=s;
	self.w=(w+60);
end
function meta:SetIcon(s)
	if pb.notify.icons[s] then
		self.Icon=pb.notify.icons[s];
	end
end
function meta:Draw()
	surface.SetFont("DefaultBold");

	local t=self.Text;
	local x=self.x;
	local y=self.y;
	local w=self.w;
	local h=self.h;
	local icon=self.Icon;
	local c=self.Color;
	
	draw.RoundedBox(4,x,y,w,h,Color(0,0,0,200));
	draw.RoundedBox(4,x+2,y+2,w-4,h-4,c);
	draw.RoundedBox(4,x+3,y+3,w-6,(h-6)/2,Color(255,255,255,100));
	
	surface.SetDrawColor( 255, 255, 255, 255 );
	surface.SetTexture(icon);
	surface.DrawTexturedRect(x+5,y-8,40,40);
	
	draw.SimpleText(t,"DefaultBold",x+50,y+11,Color(0,0,0),0,1);
end
function meta:CalculatePos(val)
	local moveto=60+(val*50);
	self.y=Lerp(0.1, self.y, moveto);
	local x
	if not self.Close then
		x= ScrW()-10-self.w;
	else
		x= self.movex+50;
	end
	self.x=Lerp(0.1, self.x, x);
	if self.x>ScrW()+1 then
		table.remove(JB.notify.tbl,val);
	end
end	

function JB.notify.create(t,i,c)
	local obj={}
	if (not i) or (not JB.notify.icons[string.lower(i)]) then
		i="generic";
	else
		i=string.lower(i);
	end
	
	if not c then
		c=Color(213,213,213);
	end
	
	setmetatable(obj,meta);
	meta.__index = meta;
	
	obj.x=ScrW();
	obj.movex= ScrW();
	obj.y=120;
	obj.w=200;
	obj.h=24;
	obj.Text="Unknown";
	obj:SetText(t)
	obj.Color=c;
	obj.Icon=JB.notify.icons[i];
	obj.Close=false;
	
	surface.PlaySound("ambient/levels/canals/drip"..math.random(1,4)..".wav");
	
	table.insert(JB.notify.tbl,obj);
	timer.Simple(4,function()
		obj.Close=true
		obj.movex=ScrW()
	end)
end

usermessage.Hook("JNC",function(u)
	local m=u:ReadString();
	local i=u:ReadString() or nil;

	JB.notify.create(m,i);
end)

hook.Add("HUDPaint", "JBNoteHUD", function()
	for k,v in ipairs(JB.notify.tbl)do
		v:CalculatePos(k)
		v:Draw()
	end
end)

timer.Create("jbTimeNotes", 75, 0, JB.notify.create, randomnotes[math.random(1,#randomnotes)],"hint")