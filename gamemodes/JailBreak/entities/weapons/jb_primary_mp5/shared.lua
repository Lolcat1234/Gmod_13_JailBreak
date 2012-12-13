
if ( SERVER ) then
	AddCSLuaFile( "shared.lua" );
end

if ( CLIENT ) then
	SWEP.PrintName			= "MP5";
	SWEP.Slot				= 0;
	SWEP.SlotPos			= 0;
end

SWEP.Base				= "jb_base";
SWEP.Spawnable			= true;
SWEP.AdminSpawnable		= true;

SWEP.HoldType = "smg"
SWEP.ViewModel = "models/weapons/v_smg_mp5.mdl";
SWEP.WorldModel = "models/weapons/w_smg_mp5.mdl";

SWEP.Sound			= Sound( "Weapon_MP5Navy.Single" );
SWEP.Recoil			= 0.8;
SWEP.Damage			= 18;
SWEP.NumShots		= 1;
SWEP.Cone			= 0.05;
SWEP.IronCone		= 0.015;
SWEP.MaxCone		= 0.09;
SWEP.ShootConeAdd	= 0.005;
SWEP.CrouchConeMul 	= 0.7;
SWEP.Primary.ClipSize		= 32;
SWEP.Delay			= 0.125;
SWEP.DefaultClip	= 32;
SWEP.Ammo			= "SMG1";
SWEP.ReloadSequenceTime = 1.85;

SWEP.OriginsPos = Vector (2.8575, -2.6834, 1.9967)
SWEP.OriginsAng = Vector (0, 0, 0)

SWEP.AimPos = Vector (4.7814, -5.7517, 1.9694)
SWEP.AimAng = Vector (0.0219, 0.0126, -0.3534)

SWEP.RunPos = Vector (-2.8351, -9.2462, 0.7045)
SWEP.RunAng = Vector (-1.9389, -72.4359, -2.6032)
