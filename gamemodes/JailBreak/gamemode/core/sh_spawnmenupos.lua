
MenuMain = {pos=Vector(0,0,0),ang=Angle(0,0,0)};
if game.GetMap() == "ba_jail_hellsgamers_se_r2" then
	MenuMain = {pos=Vector(-1419.506470, -399.830292, 243.897842),ang=Angle(0.403056, 90.340294, 0)};
elseif game.GetMap() == "ba_jail_lockdown_final" then
	MenuMain = {pos=Vector(-1419.506470, -399.830292, 243.897842),ang=Angle(0.403056, 90.340294, 0)};
elseif game.GetMap() == "jb_no1_jail_v2b9" then
	MenuMain = {pos=Vector(-1419.506470, -399.830292, 243.897842),ang=Angle(0.403056, 90.340294, 0)};
elseif game.GetMap() == "rp_jail_mars_final" then
	MenuMain = {pos=Vector(76.887749, 13.867681, 296.946),ang=Angle(0.403056, 90.340294, 0)};
elseif game.GetMap() == "jb_lego_jail_v4" then
	MenuMain = {pos=Vector(70.737047,874.683716, 425.5970),ang=Angle(0.403056, 90.340294, 0)};
elseif game.GetMap() == "ba_jail_blackops" then
	MenuMain = {pos=Vector(147.281860, 877.633545, 105.291),ang=Angle(0.403056, 90.340294, 0)};
elseif game.GetMap() == "ba_jail_alcatraz_pre-final" then
	MenuMain = {pos=Vector(1495.040894, -892.771790, 179.1344),ang=Angle(0.403056, 90.340294, 0)};
elseif game.GetMap() == "ba_jail_nightprison_v2" then
	MenuMain = {pos=Vector(2076.614990, -2056.962402, 137.676),ang=Angle(0.403056, 90.340294, 0)};
else
	MenuMain = {pos=Vector(-1419.506470, -399.830292, 243.897842),ang=Angle(0.403056, 90.340294, 0)};
end
MenuCharacter = {pos=MenuMain.pos - Vector(163.4557, 0.0000, 27.9429),ang = MenuMain.ang - Angle(-2.797, 0.320, 0)};

local function CopyTable(t) -- normal table.copy doesn't work ;(
	local tbl = {}
	for k,v in pairs(t)do
		if type(v) == "table" then
			tbl[k] = CopyTable(v)
		elseif type(v) == "Vector" then
			tbl[k] = Vector(v.x,v.y,v.z);
		else
			tbl[k] = v;
		end
	end
	return tbl; 
end

MenuPos = CopyTable(MenuMain);