

if ( SERVER ) then
	AddCSLuaFile( "shared.lua" );
end

if ( CLIENT ) then
	SWEP.PrintName			= "Five Seven";
	SWEP.Slot				= 1;
	SWEP.SlotPos			= 0;
end

SWEP.Base				= "jb_base";
SWEP.Spawnable			= true;
SWEP.AdminSpawnable		= true;

SWEP.HoldType = "pistol";
SWEP.ViewModel = "models/weapons/v_pist_fiveseven.mdl";
SWEP.WorldModel = "models/weapons/w_pist_fiveseven.mdl";

SWEP.Primary.Automatic		= false;

SWEP.Sound			= Sound( "Weapon_FiveSeven.Single" );
SWEP.Recoil			= 1.1;
SWEP.Damage			= 12;
SWEP.NumShots		= 1;
SWEP.Cone			= 0.026;
SWEP.IronCone		= 0.0067;
SWEP.MaxCone		= 0.03;
SWEP.ShootConeAdd	= 0.005;
SWEP.CrouchConeMul 	= 0.7;
SWEP.Primary.ClipSize		= 20;
SWEP.Delay			= 0.18;
SWEP.DefaultClip	= 20;
SWEP.Ammo			= "pistol";
SWEP.ReloadSequenceTime = 1.85;

SWEP.OriginsPos = Vector (2.4749, -3.7368, 2.0996)
SWEP.OriginsAng = Vector (0.8884, -1.4566, 0.9477)

SWEP.AimPos = Vector (4.7606, -3.2882, 2.8652)
SWEP.AimAng = Vector (-0.3408, 0.0723, 0)

SWEP.RunPos = Vector (3.1112, -8.789, -4.3851)
SWEP.RunAng = Vector (66.805, 5.9639, 7.7062)
