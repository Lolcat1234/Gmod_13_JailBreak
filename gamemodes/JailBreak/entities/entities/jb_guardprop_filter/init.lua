AddCSLuaFile"cl_init.lua"

ENT.Type             = "anim"
ENT.Base             = "base_anim"

function ENT:Initialize()    
    self.Entity:SetModel( "models/props_building_details/Storefront_Template001a_Bars.mdl" )

    self.Entity:PhysicsInit(SOLID_VPHYSICS)
    self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
    self.Entity:SetSolid(SOLID_VPHYSICS)

    local phys = self.Entity:GetPhysicsObject()
    if (phys:IsValid()) then
        phys:Wake()
    end
end

