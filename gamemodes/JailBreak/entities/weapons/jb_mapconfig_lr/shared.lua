if (SERVER) then

	AddCSLuaFile( "shared.lua" );
	SWEP.Weight				= 5;
	SWEP.AutoSwitchTo			= false;
	SWEP.AutoSwitchFrom		= false;
end


if ( CLIENT ) then
	SWEP.PrintName			= "Mapconfig LRS"	;
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

SWEP.ConfigSelect = nil;
SWEP.PointsDefined = 0;

function SWEP:SetupDataTables()
    self:DTVar( "Int", 0, "AngYaw" );
    self:DTVar( "Int", 1, "Count" );
end

function SWEP:Initialize()
	self:SetWeaponHoldType("normal") ;
end
if SERVER then

--[[function SWEP:SelectConfig(n)
	if not JB:GetLRs()[n] then JB:DebugPrint("Selected LR does not exist.") return end

	local lr = JB:GetLRs()[n];
end]]
concommand.Add("jb_mapcon_lr_slectmode",function(p,c,a)
	local s = p:GetActiveWeapon();
	if not p:IsAdmin() or not a[1] or not s or not s:IsValid() or not s:GetClass() == "jb_mapconfig_lr" then return end

	if not JB:GetLRs()[tonumber(a[1])] then JB:DebugPrint("Selected LR does not exist.") return end

	s.ConfigSelect = tonumber(a[1]);
	s.PointsDefined = 0;
	--s:SelectConfig(a[1]);

end)

elseif CLIENT then

function SWEP:DrawHUD()
	if not self.ConfigSelect then return end
	if not self.PointsDefined then self.PointsDefined = 0; end

	if not JB:GetLRs()[self.ConfigSelect] then return end
	draw.SimpleTextOutlined(self.PointsDefined.."/"..JB:GetLRs()[self.ConfigSelect].numpoints .." points defined.","DefaultBold",ScrW() / 2, ScrH() / 2+50,Color(255,255,255,255),1,0,1,Color(0,0,0,255));
end

usermessage.Hook("JBMCFLRNP",function()
	local p = LocalPlayer();
	local s = p:GetActiveWeapon();
	if not s or not s:IsValid() or not s:GetClass() == "jb_mapconfig_lr" then print("INVALID!!!!!!!!!!") return end

	s.PointsDefined = s.PointsDefined + 1;
end)
usermessage.Hook("JBMCFLR",function()
	local f = vgui.Create("pbFrame");
	f:SetPos(200,200);
	f:SetSize(300,55+(#JB:GetLRs()*30))
	f.Title = "Select LR";

	local cbut=vgui.Create("pbActionButton",f);
	cbut:SetSize(25,25);
	cbut:SetPos(f:GetWide()-40,15);
	cbut.DoClick = function()
		if f and f:IsValid() then
			f:Remove();
			gui.EnableScreenClicker(false);
			return;
		end
	end

	local c = 0;
	for k,v in pairs(JB:GetLRs())do
		if v.numpoints > 0 then
			c = c+1;
			local b  = vgui.Create("pbSelectButton",f);
			b:SetPos(5,25+(c*30));
			b:SetSize(f:GetWide()-10,25)
			b.Name = v.name;
			b.DoClick = function()
				f:Remove();
				RunConsoleCommand("jb_mapcon_lr_slectmode",k)
				LocalPlayer():GetActiveWeapon().ConfigSelect = k;
				gui.EnableScreenClicker(false);
			end
		end
	end

	gui.EnableScreenClicker(true);

	LocalPlayer():GetActiveWeapon().PointsDefined = 0;
	LocalPlayer():GetActiveWeapon().ConfigSelect = 0;
end)

end
function SWEP:Deploy()

	self.Weapon:SetNextPrimaryFire(CurTime() + 1)

	if SERVER then -- doesnt always run on CLient
		umsg.Start("JBMCFLR",self.Owner);
		umsg.End();
	end
	return true
end

function SWEP:Think()
	if CLIENT then
		if not self.CMdl or not ValidEntity(self.CMdl) then
    		self.CMdl = ClientsideModel("models/props_junk/PopCan01a.mdl");
   	 	end

		local trace = self.Owner:GetEyeTrace();
		self.CMdl:SetPos(trace.HitPos);
		self.CMdl:SetAngles(Angle(0,0,0));
	end
end

function SWEP:SecondaryAttack()
	
end

function SWEP:PrimaryAttack()
	if CLIENT then return end
	 
	if not self.ConfigSelect then JB:DebugPrint("No LR selected.") return end

	self.PointsDefined = self.PointsDefined + 1;

	local trace = self.Owner:GetEyeTrace();
	if not JB:GetMapConfigLR() or not JB:GetMapConfigLR()[JB:GetLRs()[self.ConfigSelect].name] then
		JB:GetMapConfigLR()[JB:GetLRs()[self.ConfigSelect].name] = {};
	end

	JB:GetMapConfigLR()[JB:GetLRs()[self.ConfigSelect].name][self.PointsDefined] = trace.HitPos;
	JB:SaveMapConfigLR();

	

	JB:DebugPrint("New LR point defined.")

	if self.PointsDefined+1 > JB:GetLRs()[self.ConfigSelect].numpoints then
		umsg.Start("JBMCFLR",self.Owner);
		umsg.End();
		self.PointsDefined = 0;
		self.ConfigSelect = 0;

		return;
	end

	umsg.Start("JBMCFLRNP",self.Owner);
	umsg.End();
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
