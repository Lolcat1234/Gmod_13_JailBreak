
if ( SERVER ) then
	AddCSLuaFile( "shared.lua" );
end

if ( CLIENT ) then
	SWEP.PrintName			= "M249";
	SWEP.Slot				= 0;
	SWEP.SlotPos			= 0;
end

SWEP.Base				= "jb_base";
SWEP.Spawnable			= true;
SWEP.AdminSpawnable		= true;

SWEP.HoldType = "smg";
SWEP.ViewModel = "models/weapons/v_mach_m249para.mdl";
SWEP.WorldModel = "models/weapons/w_mach_m249para.mdl";
SWEP.ViewModelFlip = false;

SWEP.Sound			= Sound( "Weapon_M249.Single" );
SWEP.Recoil			= 1.98;
SWEP.Damage			= 25;
SWEP.NumShots		= 1;
SWEP.Cone			= 0.08;
SWEP.IronCone		= 0.008;
SWEP.MaxCone		= 0.04;
SWEP.ShootConeAdd	= 0.007;
SWEP.CrouchConeMul 	= 0.9;
SWEP.Primary.ClipSize		= 100;
SWEP.Delay			= 0.098;
SWEP.DefaultClip	= 101;
SWEP.Ammo			= "smg";
SWEP.ReloadSequenceTime = 2.4;

SWEP.OriginPos = Vector (-2.0928, -2.8005, 0.8712)
SWEP.OriginAng = Vector (0, 0, -0.664)

SWEP.AimPos = Vector (-4.4929, -3.6283, 1.8342)
SWEP.AimAng = Vector (0, 0, 0.4467)

SWEP.RunPos = Vector (-0.3732, -5.8461, 0.8306)
SWEP.RunAng = Vector (0.6643, 48.4253, 0)
