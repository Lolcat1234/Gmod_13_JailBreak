-- cl_weapondrawing
-- draws weapons on the players

local clientModels = {}
clientModels["jb_knife"] = ClientsideModel("models/weapons/w_knife_t.mdl");
clientModels["jb_grenade_smoke"] = ClientsideModel("models/weapons/w_eq_smokegrenade.mdl");

hook.Add("PostPlayerDraw","JBDrawWeaponsOnPlayer",function(p)
	local weps = p:GetWeapons();

	for k, v in pairs(weps)do
		local mdl = clientModels[v:GetClass()];
		if mdl and p:GetActiveWeapon() and p:GetActiveWeapon():IsValid() and p:GetActiveWeapon():GetClass() ~= v:GetClass() then
			if string.Left(v:GetClass(),12) == "jb_secondary" then
				local boneindex = p:LookupBone("ValveBiped.Bip01_R_Thigh")
				if boneindex then
					local pos, ang = p:GetBonePosition(boneindex)

					ang:RotateAroundAxis(ang:Forward(),90)
					mdl:SetRenderOrigin(pos+(ang:Right()*4.5)+(ang:Up()*-1.5));
					mdl:SetRenderAngles(ang);
					mdl:DrawModel();
				end
			elseif string.Left(v:GetClass(),10) == "jb_primary" then
				local boneindex = p:LookupBone("ValveBiped.Bip01_Spine2")
				if boneindex then
					local pos, ang = p:GetBonePosition(boneindex)

					ang:RotateAroundAxis(ang:Forward(),0)
					mdl:SetRenderOrigin(pos+(ang:Right()*4)+(ang:Forward()*-5));
					ang:RotateAroundAxis(ang:Right(),-15)
					mdl:SetRenderAngles(ang);
					mdl:DrawModel();
				end
			elseif v:GetClass() == "jb_knife" then
				local boneindex = p:LookupBone("ValveBiped.Bip01_L_Thigh")
				if boneindex then
					local pos, ang = p:GetBonePosition(boneindex)

					ang:RotateAroundAxis(ang:Forward(),90)
					ang:RotateAroundAxis(ang:Right(),-56)
					mdl:SetRenderOrigin(pos+(ang:Right()*-4.2)+(ang:Up()*2));
					mdl:SetRenderAngles(ang);
					mdl:DrawModel();
				end
			elseif string.Left(v:GetClass(),10) == "jb_grenade" then
				local boneindex = p:LookupBone("ValveBiped.Bip01_L_Thigh")
				if boneindex then
					local pos, ang = p:GetBonePosition(boneindex)

					ang:RotateAroundAxis(ang:Forward(),10)
					ang:RotateAroundAxis(ang:Right(),90)
					mdl:SetRenderOrigin(pos+(ang:Right()*-6.5)+(ang:Up()*-1));
					mdl:SetRenderAngles(ang);
					mdl:DrawModel();
				end
			end
		end	
	end
end)

function JB:CheckWeaponTable(class,model)
	if clientModels[class] then return end

	clientModels[class] = ClientsideModel(model,RENDERGROUP_OPAQUE);
end

function printmodels()
	PrintTable(clientModels)
end