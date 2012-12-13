-- sh_entity_meta
-- entity metafunctions.

Player.Weapon:IsPrimary()
	return (string.Left(self:GetClass(), 10) == "jb_primary");
end

Player.Weapon:IsSecondary()
	return (string.Left(self:GetClass(), 12) == "jb_secondary");
end