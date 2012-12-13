AddCSLuaFile"cl_init.lua"

ENT.Type             = "anim"
ENT.Base             = "base_anim"

local SOUNDS = {}
SOUNDS[1] = {
	file = "buttons/blip1.wav",
	pitch = 20,
}
SOUNDS[2] = {
	file = "buttons/blip1.wav",
	pitch = 40,
}
SOUNDS[3] = {
	file = "buttons/blip1.wav",
	pitch = 80,
}
SOUNDS[4] = {
	file = "buttons/blip1.wav",
	pitch = 100,
}
SOUNDS[5] = {
	file = "buttons/blip1.wav",
	pitch = 120,
}
SOUNDS[6] = {
	file = "buttons/blip1.wav",
	pitch = 140,
}
SOUNDS[7] = {
	file = "ambient/levels/canals/drip1.wav",
	pitch = 100,
}
SOUNDS[8] = {
	file = "ambient/levels/canals/drip3.wav",
	pitch = 100,
}
SOUNDS[9] = {
	file = "ambient/alarms/razortrain_horn1.wav",
	pitch =  200,
}
SOUNDS[10] = {
	file = "ambient/alarms/klaxon1.wav",
	pitch = 80,
}
SOUNDS[11] = {
	file = "ambient/alarms/klaxon1.wav",
	pitch = 120,
}
SOUNDS[12] = {
	file = "ambient/alarms/klaxon1.wav",
	pitch = 160,
}
SOUNDS[13] = {
	file = "ambient/alarms/warningbell1.wav",
	pitch = 60,
}
SOUNDS[14] = {
	file = "ambient/alarms/warningbell1.wav",
	pitch = 160,
}
SOUNDS[15] = {
	file = "vo/npc/vortigaunt/caution.wav",
	pitch = 130,
}
SOUNDS[16] = {
	file = "vo/npc/male01/sorrydoc01.wav",
	pitch = 130,
}

function ENT:Initialize()    
    self:SetModel( "models/hunter/plates/plate1x1.mdl" )

    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    self:SetUseType(SIMPLE_USE);

    local phys = self.Entity:GetPhysicsObject()
    if (phys:IsValid()) then
        phys:Wake()
    end
end

function ENT:OnTakeDamage( dmginfo )
    self.Entity:TakePhysicsDamage( dmginfo )  
end

local size =(200-8*4)/4;
local function WorldToScreen(vWorldPos,vPos,vScale,aRot)
    local vWorldPos=vWorldPos-vPos;
    vWorldPos:Rotate(Angle(0,-aRot.y,0));
    vWorldPos:Rotate(Angle(-aRot.p,0,0));
    vWorldPos:Rotate(Angle(0,0,-aRot.r));
    return vWorldPos.x/vScale,(-vWorldPos.y)/vScale;
end
function ENT:Use(e)
	if(e:IsPlayer())then
		local lookAtX,lookAtY = WorldToScreen(e:GetEyeTrace().HitPos or Vector(0,0,0),self:GetPos()+self:GetAngles():Up()*1.55, 0.2375, self:GetAngles());
		local count = 0;

		for y=0,3 do
			for x=0,3 do
				count = count+1;

		        if lookAtX > -96+(x*(size+8)) and lookAtX < -96+(x*(size+8))+size and lookAtY > -96+(y*(size+8)) and lookAtY < -96+(y*(size+8))+size then
		        	if SOUNDS[count] then
		        		self:EmitSound(SOUNDS[count].file, 500, SOUNDS[count].pitch)
		        	end
		        end
		    end
		end

	end
end