-- sv_hooks.lua
-- for all hooks that have nothing to do with the player

function JB:GetGameDescription() 
 	return "Excl's JailBreak"; 
end

function JB:InitPostEntity()
	local e = ents.Create("jb_previewmodel");
	e:SetPos(MenuMain.pos + Vector(-180.4935, 39.8303, -78.2938));
	e:SetAngles(Angle(0,270,0));
	e:Spawn();
	
	local e = ents.Create("jb_previewmodel");
	e:SetPos(MenuMain.pos + Vector(22.5065, 39.8303, -53.897));
	e:SetAngles(Angle(0,235,0));
	e:Spawn();
	
	local e = ents.Create("prop_physics");
	e:SetModel("models/hunter/plates/plate8x8.mdl");
	e:SetPos(MenuMain.pos+Vector(-80.4935, 46.8303, -93.897)); --Vector(-1419.506470, -399.830292, 243.897842) + Vector() = Vector( -1500, -353, 150)
	e:SetAngles(Angle(0,0,90));
	e:AddEffects(EF_NOSHADOW);
	e:SetColor(0,0,0,0)
	e:SetCollisionGroup(COLLISION_GROUP_WORLD)
	e:Spawn();
	e:SetMoveType(MOVETYPE_NONE);
	local phys = e:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end
	e:Activate();
end


removeWeps = {"weapon_ak47",
"weapon_aug",
"weapon_awp",
"weapon_c4",
"weapon_deagle",
"weapon_elite",
"weapon_famas",
"weapon_fiveseven",
"weapon_flashbang",
"weapon_g3sg1",
"weapon_galil",
"weapon_glock",
"weapon_hegrenade",
"weapon_knife",
"weapon_m249",
"weapon_m3",
"weapon_m4a1",
"weapon_mac10",
"weapon_mp5navy",
"weapon_p228",
"weapon_p90",
"weapon_scout",
"weapon_sg550",
"weapon_sg552",
"weapon_smokegrenade",
"weapon_tmp",
"weapon_ump45",
"weapon_usp",
"weapon_xm1014",}
function JB:OnEntityCreated(e)
	timer.Simple(1,function(e)
		if e and e:IsValid() and table.HasValue(removeWeps,e:GetClass()) then
			e:Remove();
		end
	end,e);
end
