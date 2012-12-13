-- sh_entity_meta
-- entity metafunctions.

function _R.Weapon:IsPrimary()
	return (string.Left(self:GetClass(), 10) == "jb_primary");
end

function _R.Weapon:IsSecondary()
	return (string.Left(self:GetClass(), 12) == "jb_secondary");
end