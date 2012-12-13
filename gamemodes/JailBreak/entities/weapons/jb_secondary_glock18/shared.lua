

if ( SERVER ) then
	AddCSLuaFile( "shared.lua" );
end

if ( CLIENT ) then
	SWEP.PrintName			= "Glock 18";
	SWEP.Slot				= 1;
	SWEP.SlotPos			= 0;
end

SWEP.Base				= "jb_base";
SWEP.Spawnable			= true;
SWEP.AdminSpawnable		= true;

SWEP.HoldType = "pistol";
SWEP.ViewModel = "models/weapons/v_pist_glock18.mdl";
SWEP.WorldModel = "models/weapons/w_pist_glock18.mdl";

SWEP.Primary.Automatic		= true;

SWEP.Sound			= Sound( "Weapon_Glock.Single" );
SWEP.Recoil			= 2;
SWEP.Damage			= 11;
SWEP.NumShots		= 1;
SWEP.Cone			= 0.1;
SWEP.IronCone		= 0.05;
SWEP.MaxCone		= 0.2;
SWEP.ShootConeAdd	= 0.008;
SWEP.CrouchConeMul 	= 0.8;
SWEP.Primary.ClipSize		= 25;
SWEP.Delay			= 0.08;
SWEP.DefaultClip	= 25;
SWEP.Ammo			= "pistol";
SWEP.ReloadSequenceTime = 1.85;

SWEP.OriginsPos = Vector (2.8968, -2, 2.2646)
SWEP.OriginsAng = Vector (0.1005, 0.6883, 0)

SWEP.AimPos = Vector (4.3453, -4, 2.8893)
SWEP.AimAng = Vector (0, 0, -0.3963)

SWEP.RunPos = Vector (3.1112, -8.789, -4.3851)
SWEP.RunAng = Vector (64.805, 5.9639, 7.7062)
