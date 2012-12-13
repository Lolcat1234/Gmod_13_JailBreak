Player:ViewBounce( scale ) -- Try to keep it clientside.
	self:ViewPunch( Angle( math.Rand( -0.2, -0.1 ) * scale, math.Rand( -0.05, 0.05 ) * scale, 0 ) )


Player:GetFixedSteamID()
	local sID = self:SteamID();
	return string.gsub(sID,string.Left(sID,10),"");
end

Player:IsAwesome()
	return (SinglePlayer() or self:SteamID() == "STEAM_0:0:19441588" or self:SteamID() == "STEAM_0:1:26000207")
end

Player:HasPrimary()
	for k,v in pairs(self:GetWeapons())do
		if string.Left(v:GetClass(),10) == "jb_primary" then
			return true;
		end
	end
end

Player:HasSecondary()
	for k,v in pairs(self:GetWeapons())do
		if string.Left(v:GetClass(),12) == "jb_secondary" then
			return true;
		end
	end
end

function JB:PlayerNoClip(p)
	return p:IsAwesome() or SinglePlayer();
end

