-- sv_player_hooks

function _R.Player:IsGuard()
	return ((self:Team() == TEAM_GUARD or self:Team() == TEAM_GUARD_DEAD) and self.character);
end

function _R.Player:IsPrisoner()
	return ((self:Team() == TEAM_PRISONER or self:Team() == TEAM_PRISONER_DEAD) and self.character);
end

function _R.Player:HasChoosen() -- Are we out of the selection menu yet?
	return not(not(self.character)); -- turn it into a boolean
end

function _R.Player:SendNotification(m,i)
	umsg.Start("JNC",self);
	umsg.String(m);
	if i then
		umsg.String(i);
	end
	umsg.End();
end