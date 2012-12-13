-- sh_lastrequests
-- last request system

local meta = {}
activeLR = false;
function JB:LastRequest()
	local obj = {};
       
    setmetatable( obj, meta );
   	meta.__index =  meta;

   	obj.prisoner = NULL;
   	obj.guard = NULL;

   	obj.id = math.random(0,999);

   	obj.Name = "Undefined";
   	obj.OnStart = false;
   	obj.OnPrisonerDamaged = false;
   	obj.OnGuardDamaged = false;
   	obj.OnPrisonerDied = false;
   	obj.OnGuardDied = false;
   	obj.OnComplete = false;

   	obj.Time = 240;
   	obj.Start = 0;

   	return obj;
end

function meta:AddPlayers(p,g)
	if not ValidEntity(p) or not ValidEntity(g) then return end

	self.prisoner = p;
	self.guard = g;
end

function meta.__call(self)
	if not ValidEntity(self.prisoner) or not ValidEntity(self.guard) then JB:DebugPrint("LR could not start: No players.") return end

	JB:DebugPrint("LR Started")

	self.Start = CurTime(); 

	umsg.Start("JNC",self.guard);
	umsg.String("You have been chosen to play a "..self.Name.." against "..self.prisoner:Nick());
	umsg.String("boom");
	umsg.End();
	umsg.Start("JNC",self.prisoner);
	umsg.String("You have chosen to play a "..self.Name.." against "..self.prisoner:Nick());
	umsg.String("boom");
	umsg.End();

	timer.Simple(self.Time,function(self)
		if not self then return end

		self:End();
		self.prisoner:Kill();
	end,self)
	self.prisoner:SetHealth(100);
	self.guard:SetHealth(100);
	local efunc = function() end
	self.OnGuardDied = self.OnGuardDied or efunc;
	self.OnPrisonerDied = self.OnPrisonerDied or efunc;
	self.OnGuardDamaged = self.OnGuardDamaged or efunc;
	self.OnPrisonerDamaged = self.OnPrisonerDamaged or efunc;

	activeLR = self;

	self.OnStart(self.prisoner,self.guard);
end
function meta:LoadTemplate(t)
	self.Name = t.name;

	if not t.lrhooks or type(t.lrhooks) ~= "table"  then return end
	for k,v in pairs(t.lrhooks)do
		self[k] = v;
	end
end
function meta:TimeLeft()
	return self.Time-(CurTime()-self.Start);
end

function meta:End()
	if activeLR and activeLR.id == self.id then
		if self.OnComplete then
			self.OnComplete();
		end
		activeLR = nil; -- flush
	end

	self = nil;
end

hook.Add( "PlayerDeath", "JBPlayerDeathLR", function(p,i,k)
	if p:IsPlayer() and k and k:IsPlayer() and activeLR and (activeLR.prisoner == k or activeLR.guard == k) and (activeLR.guard == p or activeLR.prisoner == p) then
		if activeLR.prisoner == p then
			activeLR.OnPrisonerDied(k);
		elseif activeLR.guard == p then
			activeLR.OnGuardDied(k);
		end

		if activeLR and activeLR.End then
		activeLR:End();
		end
	end
end)
hook.Add( "EntityTakeDamage", "JBPlayerDeathLR", function(p,i,k,a,info)
	if activeLR and activeLR.Name then

		if p:IsPlayer() and k and k:IsPlayer() and activeLR and ( (activeLR.prisoner == p and activeLR.guard ~= k) or (activeLR.guard == p or activeLR.prisoner ~= k) ) then
			info:ScaleDamage(0);
		elseif p:IsPlayer() and k and k:IsPlayer() and activeLR and (activeLR.prisoner == k or activeLR.guard == k) and (activeLR.guard == p or activeLR.prisoner == p) then
			if activeLR.prisoner == p then
				activeLR.OnPrisonerDamaged(k,a);
			elseif activeLR.guard == p then
				activeLR.OnGuardDamaged(k,a);
			end
		end

	end
end)

