AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()
	self.Entity:SetModel("models/Humans/Group01/Male_04.mdl");
	self.Entity:PhysicsInit(SOLID_NONE);
	self.Entity:SetMoveType(MOVETYPE_NONE);
	self.Entity:SetSolid(SOLID_VPHYSICS);
	self.Entity:AddEffects(EF_NOSHADOW);
	local phys = self:GetPhysicsObject();
	if phys:IsValid() then
		phys:EnableMotion(false)
	end
end