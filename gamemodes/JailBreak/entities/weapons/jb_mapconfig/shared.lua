if (SERVER) then

	AddCSLuaFile( "shared.lua" );
	SWEP.Weight				= 5;
	SWEP.AutoSwitchTo			= false;
	SWEP.AutoSwitchFrom		= false;
end


if ( CLIENT ) then
	SWEP.PrintName			= "Mapconfig"	;
	SWEP.Author				= "NewBee";
	SWEP.DrawAmmo 			= false;
	SWEP.DrawCrosshair 		= false;
	SWEP.ViewModelFOV			= 65;
	SWEP.ViewModelFlip		= false;
	SWEP.CSMuzzleFlashes		= false;
	
	SWEP.Slot				= 0;
	SWEP.SlotPos			= 0;
end

SWEP.Category				= "newbee";

SWEP.Spawnable				= false;
SWEP.AdminSpawnable			= false;

SWEP.ViewModel 				= "";
SWEP.WorldModel 			= "models/weapons/w_knife_t.mdl" ;

SWEP.Weight					= 5;
SWEP.AutoSwitchTo			= false;
SWEP.AutoSwitchFrom			= false;

SWEP.Primary.ClipSize			= -1;
SWEP.Primary.Damage				= 0;
SWEP.Primary.DefaultClip		= -1;
SWEP.Primary.Automatic			= false;
SWEP.Primary.Ammo				= "";

SWEP.Secondary.ClipSize			= -1;
SWEP.Secondary.DefaultClip		= -1;
SWEP.Secondary.Damage			= 0;
SWEP.Secondary.Automatic		= false;
SWEP.Secondary.Ammo			= "none";

SWEP.CMdl = NULL;

SWEP.SelectedWep = nil;

SWEP.Avalable = {
"jb_primary_ak74",
"jb_primary_mp5",
"jb_primary_ump",
"jb_primary_m4a1",
"jb_secondary_p228",
"jb_secondary_glock18",
"jb_secondary_fivenseven",
"jb_knife",
}

function SWEP:SetupDataTables()
    self:DTVar( "Int", 0, "AngYaw" );
    self:DTVar( "Int", 1, "Count" );
end

function SWEP:Initialize()
	self:SetWeaponHoldType("normal") ;
end

function SWEP:Deploy()

	self.Weapon:SetNextPrimaryFire(CurTime() + 1)

	return true
end

function SWEP:Think()
	if CLIENT then
		if not self.Avalable[self:GetDTInt(1)] then return end
		if not self.CMdl or not ValidEntity(self.CMdl) then
    		self.CMdl = ClientsideModel("models/weapons/w_knife_t.mdl");
   	 	end

		local trace = self.Owner:GetEyeTrace();

		local c= self:GetDTInt(1);
		if not c or c < 1 or c > #self.Avalable then
			c = 1;
		end
		self.CMdl:SetModel(weapons.Get(self.Avalable[c]).WorldModel or "models/weapons/w_knife_t.mdl")
		self.CMdl:SetPos(trace.HitPos + Vector(0,0,13));
		self.CMdl:SetAngles(Angle(0,self:GetDTInt(0),0));
	end
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime() +.3);
	self:SetDTInt(0,(self:GetDTInt(0)+45)%361);
end

function SWEP:PrimaryAttack()
	if not self.Avalable[self:GetDTInt(1)] then return end

	local trace = self.Owner:GetEyeTrace();
	
 	JB:AddEntityToMapConfig(self.Avalable[self:GetDTInt(1) or 1],trace.HitPos+Vector(0,0,10),Angle(0,self:GetDTInt(0),0));
end

SWEP.NextReload = CurTime()
function SWEP:Reload()
	if self.NextReload > CurTime() then return end
	self.NextReload = CurTime()+0.5;

	local c = (self:GetDTInt(1)+1);
	if c < 1 then
		c = #self.Avalable;
	elseif c > #self.Avalable then
		c = 1;
	end

	self:SetDTInt(1,c);
end

function SWEP:OnRemove()
	return true
end

function SWEP:Holster()
	return true
end
