
-- sh_characters

JB.Characters = {Guard = {}, Prisoner = {}};

local translationTbl = {};
translationTbl["models/Humans/Group01/Male_08.mdl"] = "models/player/Group01/Male_08.mdl";
translationTbl["models/Humans/Group01/Male_01.mdl"] = "models/player/Group01/Male_01.mdl";
translationTbl["models/Humans/Group01/Male_05.mdl"] = "models/player/Group01/Male_05.mdl";
translationTbl["models/Humans/Group01/Male_04.mdl"] = "models/player/Group01/Male_04.mdl";
--translationTbl["models/Kleiner.mdl"] = "models/player/Kleiner.mdl";
translationTbl["models/barney.mdl"] = "models/player/barney.mdl";
translationTbl["models/police.mdl"] = "models/player/police.mdl";

function JB:TranslateModel(m)
	return (translationTbl[m] or "models/player/Group01/Male_08.mdl");
end

local GUARD = 1;
local PRISONER = 2;
local function CreateCharacter(side, name, nick, surname, img1, img2, img3, model, background, OnSpawn)
	if CLIENT then
		img1 = surface.GetTextureID(img1);
		img2 = surface.GetTextureID(img2);
		img3 = surface.GetTextureID(img3);
	end

	util.PrecacheModel(model);
	
	if side == GUARD then
		JB.Characters.Guard[#JB.Characters.Guard+1] = {name=name, nick=nick, surname=surname, img1=img1, img2=img2, img3=img3, model=model, background=background, OnSpawn=OnSpawn}
	elseif side == PRISONER then
		JB.Characters.Prisoner[#JB.Characters.Prisoner+1] = {name=name, nick=nick, surname=surname, img1=img1, img2=img2, img3=img3, model=model, background=background, OnSpawn=OnSpawn}
	end
end

CreateCharacter(PRISONER, "Clark", "Aide", "Manlov", "excljailbreak/clark1", "excljailbreak/clark2", "excljailbreak/clark3","models/Humans/Group01/Male_08.mdl", 
[[Clark Manlov, of the Manlov family has always been a curious boy.
On the age of 19 Clark felt strong urges to molest children, he has been able to control his urges, but recently the true Clark has come out. 

Spawns with:
	1x knife

Clark has the ability to regenerate his health much faster than normal people, and is therefore excellent for melee fighting.]], function(p)
	p.regen = true;
end);

CreateCharacter(PRISONER, "Kevin", "Liquid", "White", "excljailbreak/placeholder", "excljailbreak/placeholder", "excljailbreak/placeholder","models/Humans/Group01/Male_01.mdl", 
[[Kevin White has been raised by a ritch family in the united states. When Kevin was 10 he found out that his parents were white and he was black, so he just had to stab them over and over again. 
To his suprise, this appeared to be illegal. He escaped to Canada before he could be caught where he blew up a hospital and stabbed 4 random white people.

Spawns with:
  1x Knife
  2x Lockpick

Kevin can try to pickpicket guards sometimes. ]],function(p)

end);

CreateCharacter(PRISONER, "Bob", "Pennies", "Anusorn", "excljailbreak/bob1", "excljailbreak/bob2", "excljailbreak/bob3","models/Humans/Group01/Male_05.mdl", 
[[Bob has been arrested for robbing a local grocery store. He has been sentenced to 10 years in jail, and has been trying to escape ever since.
Bob can be useful for getting away or making a distraction.

Spawns with:
  1 x Knife
  2 x Smoke grenade

  Bob has no special abilities.]], function(p)
	p:Give("jb_grenade_smoke");
	p:GiveAmmo(1,"grenade");
end);

CreateCharacter(PRISONER, "Xavier", "Neko",  "Mirabelle", "excljailbreak/placeholder", "excljailbreak/placeholder", "excljailbreak/placeholder","models/Humans/Group01/Male_04.mdl", 
[[Xavier Mirabelle, A strong young fellow who would horde cats into his house and live with them untill suddenly he snapped and went into a rampage and destoryed his own house and killed serval cats in the process landing him a Ticket in jail, He really misses his cats.

Spawns with:
  1x Knife

  Xavier can walk faster than other people and is good for quick escapes, or creating havoc.
]], function(p)
	p:SetRunSpeed(280);
	p:SetWalkSpeed(210);
end);


local randomPrim = {"jb_primary_ak74","jb_primary_mp5","jb_primary_ump"}
local randomSeco = {"jb_secondary_p228","jb_secondary_glock18","jb_secondary_fivenseven"};


CreateCharacter(GUARD, "Some", "Random",  "Guard", "excljailbreak/clark3", "excljailbreak/clark3", "excljailbreak/clark3","models/police.mdl", "Guards don't get to have characters :3", function(p)
	local r = table.Random(randomPrim);

	p:Give(r);
	p:Give(table.Random(randomSeco));
	p:SelectWeapon(r);
end);

if SERVER then
	debug.getregistry()
		umsg.Start("JBSYC",self);

		local c;
		if self:Team() == TEAM_PRISONER or self:Team() == TEAM_PRISONER_DEAD then
			for k,v in pairs(JB.Characters.Prisoner)do
				if v == self.character then
					c = k;
					break;
				end
			end
			umsg.Bool(false);
		else
			JB:DebugPrint("Tried to set guard character: Defaultifying");
			umsg.Bool(true);
			c = 1;
		end
		umsg.Short(c);
		umsg.End();
	end
elseif CLIENT then
	usermessage.Hook("JBSYC",function(um)
		local p = LocalPlayer();
		if um:ReadBool() then
			JB:DebugPrint("Tried to set guard character: Defaultifying");
			p.character = JB.Characters.Guard[1];
			return;
		end
		p.character = JB.Characters.Prisoner[um:ReadShort()];
	end)
end