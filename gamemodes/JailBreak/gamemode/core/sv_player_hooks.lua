-- sv_player_hooks
--Functions
function JB:CanPlayerSuicide(p)	
	if(p:Team()< 3)then 
		return true;
	end 
	return false;
end

cSpawnGuard = 0;
cSpawnPrisoner = 0;
function JB:PlayerSelectSpawn(p)
	if p:Team() == TEAM_PRISONER or p:Team() == TEAM_PRISONER_DEAD then
		cSpawnPrisoner = (cSpawnPrisoner+1)%#ents.FindByClass("info_player_terrorist");
		return ents.FindByClass("info_player_terrorist")[cSpawnPrisoner];
	elseif p:Team() == TEAM_GUARD or p:Team() == TEAM_GUARD_DEAD then
		cSpawnGuard = (cSpawnGuard+1)%#ents.FindByClass("info_player_counterterrorist");
		return ents.FindByClass("info_player_counterterrorist")[cSpawnGuard];
	end
end

--[[ 
-- Commented cause it doesn't work in MP :(
hook.Add("KeyPress" ,"CrouchMovementKeyPRess" ,function(p,k)
	if k== IN_DUCK then
		p:ViewBounce(10)
	elseif k == IN_JUMP then
		p:ViewBounce(-30)
	end

end)]]
function JB:PlayerSpawn(p)
	p:ConCommand("fov_desired 90")
	p:SetFOV(90);
	p.Crouch = false;
	if (p:Team() < 3) then
		p:GodDisable();
		p:SetColor(Color(255,255,255,255));
		p:UnSpectate()
		p:SetMoveType(MOVETYPE_WALK);

		p:SetHealth(100);
		p:SetArmor(0);

		p:SetRunSpeed(250);
		p:SetWalkSpeed(180);

		p:SetNoDraw(false)

		p:SetModel(JB:TranslateModel((p.character or JB.Characters.Prisoner[1]).model));
		(p.character or JB.Characters.Prisoner[1]).OnSpawn(p);

		p:Give("jb_knife");
		p:Give("jb_hands");

		p:StripAmmo();

		p:GiveAmmo(500,"SMG1");
		p:GiveAmmo(500,"Pistol");
	elseif (p:Team() == TEAM_GUARD_DEAD or p:Team() == TEAM_PRISONER_DEAD or p:Team() == TEAM_SPECTATOR) and p.character then
		p:Spectate( OBS_MODE_CHASE );
		p:ConCommand("jb_spectate_switch_plus")
		p:SetMoveType( MOVETYPE_OBSERVER );
		p:SetNoDraw(true)
	elseif not p.character then 
		p:SetFOV(90);
		p:SetTeam(TEAM_SPECTATOR);
		p:SetMoveType(MOVETYPE_OBSERVER);
		p:SetNotSolid(true);
		p:SetPos(MenuPos.pos-(p:EyePos()-p:GetPos()));
		p:SetAngles(Angle(0.403056, 90.340294, 0));
		timer.Simple(0.5,function(p)
			p:SetPos(MenuPos.pos-(p:EyePos()-p:GetPos()));
		end,p);
		p:Freeze(true);
		p:SetNoDraw(true);
		p.character = nil;
	end	
end

local DeathSounds = {
	Sound("player/death1.wav"),
	Sound("player/death2.wav"),
	Sound("player/death3.wav"),
	Sound("player/death4.wav"),
	Sound("player/death5.wav"),
	Sound("player/death6.wav"),
	Sound("vo/npc/male01/pain07.wav"),
	Sound("vo/npc/male01/pain08.wav"),
	Sound("vo/npc/male01/pain09.wav"),
	Sound("vo/npc/male01/pain04.wav"),
	Sound("vo/npc/Barney/ba_pain06.wav"),
	Sound("vo/npc/Barney/ba_pain07.wav"),
	Sound("vo/npc/Barney/ba_pain09.wav"),
	Sound("vo/npc/Barney/ba_ohshit03.wav"),
	Sound("vo/npc/Barney/ba_no01.wav"),
	Sound("vo/npc/male01/no02.wav"),
	Sound("hostage/hpain/hpain1.wav"),
	Sound("hostage/hpain/hpain2.wav"),
	Sound("hostage/hpain/hpain3.wav"),
	Sound("hostage/hpain/hpain4.wav"),
	Sound("hostage/hpain/hpain5.wav"),
	Sound("hostage/hpain/hpain6.wav")
}

function JB:PlayerDeath( p, a, d )
	if p:Team() == TEAM_PRISONER then
		p:SetTeam(TEAM_PRISONER_DEAD);
		local e = ents.Create("prop_ragdoll");
		e:SetModel(p:GetModel());
		e:SetPos(p:GetPos());
		e:GetAngles(p:GetAngles());
		e:SetVelocity(p:GetVelocity());
		e:Spawn();
		e:Activate();
		p:EmitSound(table.Random(DeathSounds),300,100);
		if p:Alive() then
			p:KillSilent()
			p:Spawn();
		end
	elseif p:Team() == TEAM_GUARD then -- or we simply check it.
		p:SetTeam(TEAM_GUARD_DEAD);
		local e = ents.Create("prop_ragdoll");
		e:SetModel(p:GetModel());
		e:SetPos(p:GetPos());
		e:GetAngles(p:GetAngles());
		e:SetVelocity(p:GetVelocity());
		e:Spawn();
		e:Activate();
		p:EmitSound(table.Random(DeathSounds),300,100);
		if p:Alive() then
			p:KillSilent()
			p:Spawn();
		end
	end
	if JB:RoundStatus() ~= ROUND_END then
		JB:CheckRoundEnd();
	end
end

function JB:PlayerShouldTakeDamage( p, a )
	if p:IsPlayer() and a:IsPlayer() and p:Team() == a:Team() then
			return false;
	end
	return true;
end

function JB:GetFallDamage( ply, speed )
	return (speed/8);
end

function JB:ShowHelp(p)
	umsg.Start("JBH",p); umsg.End();
	
	return false;
end

function JB:ShowTeam(p)
	umsg.Start("JBOTCM",p); umsg.End();
	return false;
end

function JB:ShowSpare1(p)
	p:SendNotification("This key is not bound in Jailbreak3","error")
	return false;
end

function JB:ShowSpare2(p)
	if p:Team() == TEAM_GUARD then
		umsg.Start("JOGP",p); umsg.End();
	elseif p:Team() == TEAM_PRISONER then
		if #team.GetPlayers(TEAM_PRISONER) < 2 then
			umsg.Start("JOLR",p); umsg.End();
		else
			umsg.Start("JNC",p); umsg.String("You can not do a last request until you are the last prisoner alive."); umsg.String("boom"); umsg.End();
		end
	end
	return false;
end

function JB:PlayerSwitchFlashlight()
	return false;
end

function JB:CanPlayerSuicide(p)
	if( p:Team() == TEAM_UNASSIGNED or p:Team() == TEAM_SPECTATOR or p:Team() == TEAM_PRISONER_DEAD or p:Team() == TEAM_GUARD_DEAD ) then
		return false;
	end

	return true;
end 

function JB:PlayerUse( p )
	return (p:Team() == TEAM_GUARD or p:Team() == TEAM_PRISONER);
end

function JB:PlayerCanPickupWeapon( p, wep )
	if (p:Team() ~= TEAM_GUARD and p:Team() ~= TEAM_PRISONER) 
	or (p:HasPrimary() and wep:IsPrimary()) 
	or (p:HasSecondary() and wep:IsSecondary()) 
	or table.HasValue(removeWeps,wep:GetClass()) then 
		return false
	end
	return true
end

function JB:AllowPlayerPickup( p, ent )
	if p:Team() == TEAM_GUARD or p:Team() == TEAM_PRISONER then
		return true
	end
	return false
end


function JB:PlayerDisconnected( p )
	if not p:IsPrisoner() or not p:IsGuard() then return end-- don't need to check round status when their spectator.
	
	JB:CheckRoundEnd();
end

function JB:CanExitVehicle()
	return false;
end
