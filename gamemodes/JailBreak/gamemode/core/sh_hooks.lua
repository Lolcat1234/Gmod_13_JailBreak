-- sh_hooks.lua
-- some weird dutch sentence that make half senses.

-- below creates lua driven airacceleration.
function JB:Move( p, md ) -- Place holder until we come up with a better forumla of our own.
	if p:IsOnGround() or !p:Alive() or p:WaterLevel() > 0 then return end
	
	local aim = md:GetMoveAngles()
	local forward, right = aim:Forward(), aim:Right()
	local fmove = md:GetForwardSpeed()
	local smove = md:GetSideSpeed()
	
	forward.z, right.z = 0,0
	forward:Normalize()
	right:Normalize()

	local wishvel = forward * fmove + right * smove
	wishvel.z = 0

	local wishspeed = wishvel:Length()

	if(wishspeed > md:GetMaxSpeed()) then
		wishvel = wishvel * (md:GetMaxSpeed()/wishspeed)
		wishspeed = md:GetMaxSpeed()
	end

	local wishspd = wishspeed
	wishspd = math.Clamp(wishspd, 0, 30)

	local wishdir = wishvel:GetNormal()
	local current = md:GetVelocity():Dot(wishdir)

	local addspeed = wishspd - current

	if(addspeed <= 0) then return end

	local accelspeed = (120) * wishspeed * FrameTime()

	if(accelspeed > addspeed) then
		accelspeed = addspeed
	end

	local vel = md:GetVelocity()
	vel = vel + (wishdir * accelspeed)
	md:SetVelocity(vel)

	return false
end