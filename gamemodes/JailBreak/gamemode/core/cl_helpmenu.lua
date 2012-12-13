local helpTbl = {}
local helpFrame = false;

local curtab = 1;

function addHelp(n,h) --name, text
	if(not n)or(not h)then return end
	local k=(#helpTbl+1);
	helpTbl[k] = {}
	helpTbl[k].name= n;
	helpTbl[k].help= JB.util.FormatLine(h,"Default",465);
end

function toggleHelp() --create the help frame
	if helpFrame and helpFrame:IsValid() then
		helpFrame:Remove();
		gui.EnableScreenClicker(false);
		return;
	end

	helpFrame=vgui.Create("pbFrame");
	helpFrame:SetSize(650, 500)
	helpFrame:SetPos((ScrW()/2)-250,(ScrH()/2)-250);
	helpFrame.Title="Jailbreak help";
	local cbut=vgui.Create("pbActionButton",helpFrame);
	cbut:SetSize(25,25);
	cbut:SetPos(helpFrame:GetWide()-35,12.5);
	cbut.DoClick = function()
		if helpFrame and helpFrame:IsValid() then
			helpFrame:Remove();
			gui.EnableScreenClicker(false);
			return;
		end
	end
	local pnl=vgui.Create("pbPanel",helpFrame);
	pnl:SetSize(485,440);
	pnl:SetPos(160,55)
	pnl.PaintHook = function()
		draw.DrawText(helpTbl[curtab].help,"Default",10,10,Color(60,60,60),0,0)
	end
	for k,v in pairs(helpTbl)do
		local but=vgui.Create("pbSelectButton",helpFrame)
		but:SetPos(5,-28+53+(k*30))
		but:SetSize(150,25)
		but.Name = v.name;
		but.DoClick = function()
			curtab = k;
		end
	end	
	
	gui.EnableScreenClicker(true);
end
concommand.Add("jb_togglehelp", toggleHelp);
usermessage.Hook("JBH", toggleHelp);

addHelp("Rules","These are the rules that apply in PrisonBreak2. \nThese might be diffirent from this server's rules, server rules always go first. \nIf you break one of these rules you will be muted, teambanned or blocked from joining this server. \n \nRules: \n#1 Report possible exploits, don't use them. \n#2 Read these rules. \n#3 Do not abuse guns in any way. \n#4 Punishments are the server admin's decision, the developer can not help you. \n \n#6 Guards only, do not shoot prisoners at random. \n#7 Guards only, do not allow -day commands, like a 'freeday' or a 'poolday'. \n#8 Guards only, do not accept last request not giving through the system. \n#9 Guards only, only the warden (game mechanic) may give orders, if the warden is down the prisoners may not be commanded anymore. \n#10 Guards only, listen to the warden, he also leaders the guard team. \n\n#11 Prisoners only, do not spam messages about you being randomly shot, it happens sometimes, if one guard does it over and over again you can report them. \n \n \n \n \n \n");
addHelp("Credits", [[Gamemode credits.

Excl (_NewBee) - Coding, mapping, textures, models;
Clark (Aide) - Additional coding.;

The facepunch and havocgamers community - Writing prisoner and guard stories.]])
addHelp("Starters", "This is a basic introduction to the game of PrisonBreak. \nIn prisonbreak there are basicly 2 teams, guards and prisoners, prisoners have been in prison for way too long and want to escape, to do this they must first disable all guards. Everey round (also know as day) the prisoners must follow the orders of the guards in order to survive the prison life, the guards will not kill you of you obey their orders. While the prisoners are following the guards' strict orders they can try to rebel by simply assaulting them, or utilising one of the perks some prisoners get each round, these perks are obtained at random and you can not affect the way they are given to players, do not belive and rumors saying that you can. Guards must command the prisoners to do basic commands and games, see the Guard section of this Prisonbreak Encyclopedia for informaton on these games. \n\nIf no prisoner succeded to rebel then the last prisoner alive has a last chance to kill the guards, utilising the Last Request system (see commands section). In a last request the prisoner picks a game, sutch as Shot4Shot, Knife fights, Western shootout or Jump contest. If the prisoner wins one of these games then the guard will die. The prisoner keeps doing these games until he dies, or all guards are dead. Guards killed in the LR system will be added to the Prisoner's killcount and you will recieve coins for it.");
addHelp("Prisoners", "The prisoner team has to escape from prison, to do this they must disable all guards. \n\nPrisoners can attempt to disable the guards during the orders the guards give or during a Last Request. You can rebel by simply breaking one of the guards' rules, running away or simply by assaulting a guard \nIf none of the Prisoners achieved to kill all guards then when the last prisoner can use the Last Request system [F4]. \n\nLast Request \nUnlike Prisonbreak1 and Prisonbreak/Hosties in css there is a scripted last request system. The last prisoner can press [F4] to open a menu in which they can choose their last request. The guards may not accept any last requests not given though the system. \n\n\nBEWARE:\nThe last request MUST be done. If the prisoner does not do it the guards may not kill them, but wait for them to do it. The only exception is that the last prisoner was part of multiple prisoners that were going to die because of a game.");
addHelp("Controls", [[These are all keys and commands in prisonbreak

Keyboard:
[W/A/S/D] - Run.
[Mouse axis] - Looking.
[Left mouse] -  Weapon primary.
[Right mouse] - Weapon secondary.
[1/2/3/4] - Weapon selection.
[Q] - Drop weapon.
[C] - Quick command.
[F1] - Help menu
[F2] - Change team
[F3] - Action menu
[F4] - Special (LastRequest for prisoners, event key for guards)
[SHIFT]+[W/A/S/D] - Sprint
[ALT]+[W/A/S/D] - Walk
[ESCAPE] - Access game/de menu (server configuration based)
[Y] - Send chat message
[U] - Send team chat message
[X] - Use microphone (if avalable)

Chatcommands: (Prefixed with '/')
'welcome' - Welcomes you to PrisonBreak2
'lr' - Last Request
'lastrequest' - Last Request
'help' - Opens the F1 menu
'stuck' - Unstucks you (only useable 30 seconds after round start)]] );

