-- sv_mapconfig
-- handles the map

local mapConfig = {};
function JB:LoadMapConfig()
	mapConfig = (glon.decode(file.Read("jailbreak3/"..game.GetMap()..".txt")) or {}); -- Need a substitute for glon beacause it was removed
end

function JB:SpawnMapConfig()
	for k,v in pairs(mapConfig)do
		local e = ents.Create(v.ent);
		e:SetPos(v.pos);
		e:SetAngles(v.ang);
		e:Spawn();
	end
end

function JB:AddEntityToMapConfig(e,p,a)
	if not e or not p or not a then return end

	local t = 
	{
		ent = e,
		pos = p,
		ang = a,
	};

	mapConfig[#mapConfig+1] = t;

	file.Write("jailbreak3/"..game.GetMap()..".txt",glon.encode(mapConfig));
end

JB:LoadMapConfig();

-----------------------
-- for last requests --
-----------------------

local mapConfigLR = {};
function JB:LoadMapConfigLR()
	mapConfigLR = (glon.decode(file.Read("jailbreak3/lastrequestconfig/"..game.GetMap()..".txt")) or {});
end
function JB:SaveMapConfigLR()
	file.Write("jailbreak3/lastrequestconfig/"..game.GetMap()..".txt",glon.encode(mapConfigLR));
end
function JB:GetMapConfigLR()
	return mapConfigLR;
end


JB:LoadMapConfigLR();