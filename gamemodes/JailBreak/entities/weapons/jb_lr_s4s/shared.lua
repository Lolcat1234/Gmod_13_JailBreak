if (SERVER) then

	AddCSLuaFile( "shared.lua" );
	SWEP.Weight				= 5;
	SWEP.AutoSwitchTo			= false;
	SWEP.AutoSwitchFrom		= false;
end


if ( CLIENT ) then
	SWEP.PrintName			= "Shot 4 Shot"	;
	SWEP.Author				= "NewBee";
	SWEP.DrawAmmo 			= false;
	SWEP.DrawCrosshair 		= false;
	SWEP.ViewModelFOV			= 65;
	SWEP.ViewModelFlip		= false;
	SWEP.CSMuzzleFlashes		= false;
	
	SWEP.Slot				= 1;
	SWEP.SlotPos			= 0;
end


Sound( "Weapon_Deagle.Single" ) -- precache

SWEP.Category				= "newbee";

SWEP.Spawnable				= false;

SWEP.ViewModelFlip = true;
SWEP.AdminSpawnable			= false;

SWEP.ViewModel 				= "models/weapons/v_pist_deagle.mdl";
SWEP.WorldModel 			= "models/weapons/w_pist_deagle.mdl" ;

SWEP.Weight					= 5;
SWEP.AutoSwitchTo			= false;
SWEP.AutoSwitchFrom			= false;

SWEP.Primary.ClipSize			= -1;
SWEP.Primary.DefaultClip		= -1;
SWEP.Primary.Automatic			= false;
SWEP.Primary.Ammo				= "";

SWEP.Secondary.ClipSize			= -1;
SWEP.Secondary.DefaultClip		= -1;
SWEP.Secondary.Damage			= -1;
SWEP.Secondary.Automatic		= false;
SWEP.Secondary.Ammo			= "";

SWEP.Guard = NULL;
SWEP.Prisoner = NULL;

SWEP.GuardTurn = false;

function SWEP:Initialize()
	self:SetWeaponHoldType("pistol")
	self:SetDTBool(0,false)

	if activeLR then
		self.Guard = activeLR.guard;
		self.Prisoner = activeLR.prisoner;
	end
end

function SWEP:CheckPlayers()
	if self.Guard and self.Prisoner and self.Guard:IsValid() and self.Prisoner:IsValid() then
		return true;
	end
	return false;
end

function SWEP:SecondaryAttack()
end

local function GUARDFIRE(b)
	if not timer.IsTimer("Times4sLRGun") then
		timer.Create("Times4sLRGun",29,1,GUARDFIRE, not b);
	else
		timer.Adjust("Times4sLRGun",29,1,GUARDFIRE, not b);
	end
	for k,v in pairs(ents.FindByClass("jb_lr_s4s"))do
		if v and v:IsValid() then
			v.GuardTurn = b;
			v:SetDTBool(0,b)
		end
	end
end

local bullet = {}
bullet.Num=1
bullet.Spread=Vector(0.01,0.01,0)
bullet.Tracer=1	
bullet.Force=100
bullet.Damage=75
function SWEP:PrimaryAttack()
	if not self:CheckPlayers() or ((self.Owner:Team() == TEAM_GUARD and not self.GuardTurn) or (self.Owner:Team() == TEAM_PRISONER and self.GuardTurn)) then return end

	bullet.Src 		= self.Owner:GetShootPos();
	bullet.Dir 		= ( self.Owner:EyeAngles() + self.Owner:GetPunchAngle() ):Forward();
	GUARDFIRE(not self.GuardTurn);
	 
	self:FireBullets(bullet)
	
	self.Owner:EmitSound("Weapon_Deagle.Single", 100, 100)

	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK);
	self.Owner:SetAnimation(PLAYER_ATTACK1);
	self.Owner:MuzzleFlash();
end

SWEP.t = CurTime();
SWEP.f = true;
SWEP.memf = false;
function SWEP:DrawHUD()
	surface.SetDrawColor(0,0,0,255);
	surface.DrawRect(ScrW()/2-2,ScrH()/2-2,4,4)
	surface.SetDrawColor(255,255,255,255);
	surface.DrawRect(ScrW()/2-1,ScrH()/2-1,2,2)
	local s = "Wait for the other person to shoot."
	if ( self:GetDTBool(0,false) == true and self.Owner:Team() == TEAM_GUARD ) or ( self:GetDTBool(0,false) == false and self.Owner:Team() == TEAM_PRISONER ) then
		if self.f then
			self.t = CurTime();
		end
		s = "You have "..math.Round(30 - (CurTime() - self.t)).." seconds left to shoot.";
	end 
	draw.SimpleTextOutlined(s,"DefaultBold",ScrW() / 2, (ScrH() / 2) + 20,Color(255,255,255,255),1,1,1,Color(0,0,0,255))

	self.f = (self:GetDTBool(0,false) ~= self.memf);
	self.memf = self:GetDTBool(0,false); 
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

function SWEP:FireAnimationEvent(pos, ang, ev)
		if ev == 5001 then
			if not self.Owner:ShouldDrawLocalPlayer() then
				local vm = self.Owner:GetViewModel();
				local muz = vm:GetAttachment("1");
				
				if not self.Weapon.Em then
					self.Weapon.Em = ParticleEmitter(muz.Pos);
				end
				
				local par = self.Weapon.Em:Add("sprites/frostbreath", muz.Pos);
				par:SetStartSize(math.random(1, 5));
				par:SetStartAlpha(140);
				par:SetEndAlpha(0);
				par:SetEndSize(math.random(5, 5.5));
				par:SetDieTime(1.5 + math.Rand(0, 1));
				par:SetRoll(math.Rand(0.2, 1));
				par:SetRollDelta(0.8 + math.Rand(-0.3, 0.3));
				par:SetColor(120,120,120,255);
				par:SetGravity(Vector(0, 0, 5));
				local mup = (muz.Ang:Up()*-20);
				par:SetVelocity(Vector(0, 0,7)+Vector(mup.x,mup.y,0));
				
				local par = self.Weapon.Em:Add("sprites/heatwave", muz.Pos);
				par:SetStartSize(8);
				par:SetEndSize(0);
				par:SetDieTime(0.3);
				par:SetGravity(Vector(0, 0, 2));
				par:SetVelocity(Vector(0, 0, 20));				
			end
		end
end