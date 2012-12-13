AddCSLuaFile"cl_init.lua"

ENT.Type             = "anim"
ENT.Base             = "base_anim"

function ENT:Initialize()    
    self.Entity:SetModel( "models/dav0r/hoverball.mdl" )

    self.Entity:PhysicsInitSphere( 4, "metal_bouncy" )
        
    local phys = self.Entity:GetPhysicsObject()
    if (phys:IsValid()) then
        phys:Wake()
    end

    self.Entity:SetCollisionBounds( Vector( -4, -4, -4 ), Vector( 4, 4, 4 ) )
end

function ENT:PhysicsCollide( data, physobj )
    
    // Play sound on bounce
    if (data.Speed > 80 && data.DeltaTime > 0.2 ) then
        self.Entity:EmitSound( "Rubber.BulletImpact" )
    end
    
    // Bounce like a crazy bitch
    local LastSpeed = math.max( data.OurOldVelocity:Length(), data.Speed )
    local NewVelocity = physobj:GetVelocity()
    NewVelocity:Normalize()
    
    LastSpeed = math.max( NewVelocity:Length(), LastSpeed )
    
    local TargetVelocity = NewVelocity * LastSpeed * 0.9
    
    physobj:SetVelocity( TargetVelocity )
    
end

function ENT:OnTakeDamage( dmginfo )

    // React physically when shot/getting blown
    self.Entity:TakePhysicsDamage( dmginfo )
    
end