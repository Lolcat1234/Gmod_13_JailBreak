if (SERVER) then

	AddCSLuaFile( "shared.lua" );
	SWEP.Weight				= 5;
	SWEP.AutoSwitchTo			= false;
	SWEP.AutoSwitchFrom		= false;
end


if ( CLIENT ) then
	SWEP.PrintName			= "knife"	;
	SWEP.Author				= "NewBee";
	SWEP.DrawAmmo 			= false;
	SWEP.DrawCrosshair 		= false;
	SWEP.ViewModelFOV			= 65;
	SWEP.ViewModelFlip		= false;
	SWEP.CSMuzzleFlashes		= false;
	
	SWEP.Slot				= 2;
	SWEP.SlotPos			= 0;
end

SWEP.Category				= "newbee";

SWEP.Spawnable				= false;
SWEP.AdminSpawnable			= false;

SWEP.ViewModel 				= "models/weapons/v_knife_t.mdl";
SWEP.WorldModel 			= "models/weapons/w_knife_t.mdl" ;

SWEP.Weight					= 5;
SWEP.AutoSwitchTo			= false;
SWEP.AutoSwitchFrom			= false;

SWEP.Primary.ClipSize			= -1;
SWEP.Primary.Damage				= 20;
SWEP.Primary.DefaultClip		= -1;
SWEP.Primary.Automatic			= true;
SWEP.Primary.Ammo				= "";

SWEP.Secondary.ClipSize			= -1;
SWEP.Secondary.DefaultClip		= -1;
SWEP.Secondary.Damage			= 20;
SWEP.Secondary.Automatic		= true;
SWEP.Secondary.Ammo			= "none";

SWEP.MissSound 					= Sound("weapons/knife/knife_slash1.wav");
SWEP.WallSound 				= Sound("weapons/knife/knife_hitwall1.wav");
SWEP.DeploySound				= Sound("weapons/knife/knife_deploy1.wav");
SWEP.Ragdollhit 				= Sound("weapons/knife/knife_stab.wav");

function SWEP:Think()		
	if self.Owner:KeyDown(IN_SPEED) and self.Owner:GetVelocity():Length() > 10 then
		self:SetWeaponHoldType("melee") ;
	else	
		self:SetWeaponHoldType("knife") ;
	end
end


function SWEP:Initialize()
	self:SetWeaponHoldType("knife") ;
end

function SWEP:Deploy()
	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
	self.Weapon:SetNextPrimaryFire(CurTime() + 1)
	self.Weapon:EmitSound( self.DeploySound, 50, 100 )
	return true
end

function SWEP:SecondaryAttack()
end

function SWEP:PrimaryAttack()
	local trace = self.Owner:GetEyeTrace();
	
    self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	if trace.HitPos and trace.HitPos:Distance(self.Owner:EyePos()) < 70 then
		self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)

		util.Decal("ManhackCut", trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal);
		if CLIENT then return end
		if trace.Entity and trace.Entity:IsValid() then
			if trace.Entity:IsPlayer() and (self.Owner:Team() != trace.Entity:Team()) then
				trace.Entity:TakeDamage(20);
			elseif not trace.Entity:IsPlayer() then
				trace.Entity:TakeDamage(30);
			end
			if trace.Entity:IsPlayer() then
				self.Weapon:EmitSound(self.Ragdollhit,100,math.random(80,120));	
			else
				self.Weapon:EmitSound(self.WallSound,100,math.random(80,120));	
			end
		else
			self.Weapon:EmitSound(self.WallSound,100,math.random(80,120));	
		end		
	else
		self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
		if CLIENT then return end
		self.Weapon:EmitSound(self.MissSound,100,math.random(80,120))
	end
end

function SWEP:Reload()
	return false
end

function SWEP:OnRemove()
	return true
end

function SWEP:Holster()
	return true
end
