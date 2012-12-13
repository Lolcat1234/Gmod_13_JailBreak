-- Code is ripped from PrisonBreak2, a gamemode by NewBee

JB = GM; -- rather than calling gmod.GetGamemode() 100 times;

JB.Name = "JailBreak";
JB.Author = "_NewBee (Excl), Clark (Aide)";
JB.Version = "ALPHA 1";
JB.util = {}
JB.debug = true;

--Debugprinting
function JB:DebugPrint(...)
	if not JB.debug then return end
	
	Msg("["..JB.Name.." debug] "); print(...);
end
JB:DebugPrint("Initializing "..JB.Name..", a _NewBee gamemode.")
JB:DebugPrint("Created by "..JB.Author.."; version "..JB.Version);

--Including files
local function JBInclude(file, folder, run)
	local p = run or "sh";
	if string.Left(file, 2) and (not run) then p = string.Left(file, 2) end	
	if p == "sh" then
		JB:DebugPrint("Including file: "..folder..file);
		include(folder..file);
		if SERVER then
			AddCSLuaFile(folder..file);
		end
	elseif p == "sv" and SERVER then
		JB:DebugPrint("Including file: "..folder..file);
		include(folder..file);
	elseif p == "cl" then
		if CLIENT then
			JB:DebugPrint("Including file: "..folder..file);
			include(folder..file);
		elseif SERVER then
			AddCSLuaFile(folder..file);
		end
	end
end

--Automate including
local function JBInitVGUI()
	for k,v in pairs(file.FindInLua("JailBreak/gamemode/vgui/*.lua")) do
		JBInclude(v, "vgui/", "cl");
	end
end

local function JBInitCore()
	for k,v in pairs(file.FindInLua("JailBreak/gamemode/core/*.lua")) do
		JBInclude(v, "core/");
	end
end

local function JBInitUtil()
	for k,v in pairs(file.FindInLua("JailBreak/gamemode/util/*.lua")) do
		JBInclude(v, "util/");
	end
end

--In strict order :3
JBInitUtil();
JBInitVGUI();
JBInitCore();