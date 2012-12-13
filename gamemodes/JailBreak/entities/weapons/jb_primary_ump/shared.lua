
if ( SERVER ) then
	AddCSLuaFile( "shared.lua" );
end

if ( CLIENT ) then
	SWEP.PrintName			= "UMP";
	SWEP.Slot				= 0;
	SWEP.SlotPos			= 0;
end

SWEP.Base				= "jb_base";
SWEP.Spawnable			= true;
SWEP.AdminSpawnable		= true;

SWEP.HoldType = "smg"
SWEP.ViewModel = "models/weapons/v_smg_ump45.mdl";
SWEP.WorldModel = "models/weapons/w_smg_ump45.mdl";

SWEP.Sound			= Sound( "Weapon_UMP45.Single" );
SWEP.Recoil			= 2;
SWEP.Damage			= 28;
SWEP.NumShots		= 1;
SWEP.Cone			= 0.07;
SWEP.IronCone		= 0.05;
SWEP.MaxCone		= 0.075;
SWEP.ShootConeAdd	= 0.01;
SWEP.CrouchConeMul 	= 0.8;
SWEP.Primary.ClipSize		= 32;
SWEP.Delay			= 0.1;
SWEP.DefaultClip	= 32;
SWEP.Ammo			= "SMG1";
SWEP.ReloadSequenceTime = 1.85;

SWEP.OriginsPos = Vector (4.3856, -6.1344, 1.9522)
SWEP.OriginsAng = Vector (0.1243, -0.7811, 0)

SWEP.AimPos = Vector (7.3157, -7.2025, 3.0531)
SWEP.AimAng = Vector (-1.3316, 0.2416, 1.4082)

SWEP.RunPos = Vector (-1.3115, -5.7587, -1.4968)
SWEP.RunAng = Vector (0.3722, -57.813, 0)
