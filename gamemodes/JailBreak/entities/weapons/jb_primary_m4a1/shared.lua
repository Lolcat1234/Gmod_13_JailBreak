
if ( SERVER ) then
	AddCSLuaFile( "shared.lua" );
end

if ( CLIENT ) then
	SWEP.PrintName			= "M4A1";
	SWEP.Slot				= 0;
	SWEP.SlotPos			= 0;
end

SWEP.Base				= "jb_base";
SWEP.Spawnable			= true;
SWEP.AdminSpawnable		= true;

SWEP.HoldType = "ar2"
SWEP.ViewModel = "models/weapons/v_rif_m4a1.mdl";
SWEP.WorldModel = "models/weapons/w_rif_m4a1.mdl";

SWEP.Sound			= Sound( "Weapon_M4A1.Single" );
SWEP.Recoil			= 0.9;
SWEP.Damage			= 20;
SWEP.NumShots		= 1;
SWEP.Cone			= 0.0468;
SWEP.IronCone		= 0.01225;
SWEP.MaxCone		= 0.069;
SWEP.ShootConeAdd	= 0.005;
SWEP.CrouchConeMul 	= 0.7;
SWEP.Primary.ClipSize		= 30;
SWEP.Delay			= 0.125;
SWEP.DefaultClip	= 30;
SWEP.Ammo			= "SMG1";
SWEP.ReloadSequenceTime = 1.85;

SWEP.OriginsPos = Vector (3.9079, -3.4396, 1.2098)
SWEP.OriginsAng = Vector (-0.0801, 0.9215, 3.7295)

SWEP.AimPos = Vector (5.9052, -6.1347, 1.343)
SWEP.AimAng = Vector (1.9069, 1.3983, 3.331)

SWEP.RunPos = Vector (-0.6278, -9.2715, -0.1986)
SWEP.RunAng = Vector (-4.1344, -63.4931, 6.7989)
