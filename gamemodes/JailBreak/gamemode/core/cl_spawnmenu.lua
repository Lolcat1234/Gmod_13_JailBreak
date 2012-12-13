local x,y = -1000,-1200
local tblFonts = { }
tblFonts["DebugFixed"] = {
    font = "Courier New",
    size = 10,
    weight = 500,
    antialias = true,
}
 
tblFonts["DebugFixedSmall"] = {
    font = "Courier New",
    size = 7,
    weight = 500,
    antialias = true,
}
 
tblFonts["DefaultFixedOutline"] = {
    font = "Lucida Console",
    size = 10,
    weight = 0,
    outline = true,
}
 
tblFonts["MenuItem"] = {
    font = "Tahoma",
    size = 12,
    weight = 500,
}
 
tblFonts["Default"] = {
    font = "Tahoma",
    size = 13,
    weight = 500,
}
 
tblFonts["TabLarge"] = {
    font = "Tahoma",
    size = 13,
    weight = 700,
    shadow = true,
}
 
tblFonts["DefaultBold"] = {
    font = "Tahoma",
    size = 13,
    weight = 1000,
}
 
tblFonts["DefaultUnderline"] = {
    font = "Tahoma",
    size = 13,
    weight = 500,
    underline = true,
}
 
tblFonts["DefaultSmall"] = {
    font = "Tahoma",
    size = 1,
    weight = 0,
}
 
tblFonts["DefaultSmallDropShadow"] = {
    font = "Tahoma",
    size = 11,
    weight = 0,
    shadow = true,
}
 
tblFonts["DefaultVerySmall"] = {
    font = "Tahoma",
    size = 10,
    weight = 0,
}
 
tblFonts["DefaultLarge"] = {
    font = "Tahoma",
    size = 16,
    weight = 0,
}
 
tblFonts["UiBold"] = {
    font = "Tahoma",
    size = 12,
    weight = 1000,
}
 
tblFonts["MenuLarge"] = {
    font = "Verdana",
    size = 15,
    weight = 600,
    antialias = true,
}
 
tblFonts["ConsoleText"] = {
    font = "Lucida Console",
    size = 10,
    weight = 500,
}
 
tblFonts["Marlett"] = {
    font = "Marlett",
    size = 13,
    weight = 0,
    symbol = true,
}
 
tblFonts["Trebuchet24"] = {
    font = "Trebuchet MS",
    size = 24,
    weight = 900,
}
 
tblFonts["Trebuchet22"] = {
    font = "Trebuchet MS",
    size = 22,
    weight = 900,
}
 
tblFonts["Trebuchet20"] = {
    font = "Trebuchet MS",
    size = 20,
    weight = 900,
}
 
tblFonts["Trebuchet19"] = {
    font = "Trebuchet MS",
    size = 19,
    weight = 900,
}
 
tblFonts["Trebuchet18"] = {
    font = "Trebuchet MS",
    size = 18,
    weight = 900,
}
 
tblFonts["HUDNumber"] = {
    font = "Trebuchet MS",
    size = 40,
    weight = 900,
}
 
tblFonts["HUDNumber1"] = {
    font = "Trebuchet MS",
    size = 41,
    weight = 900,
}
 
tblFonts["HUDNumber2"] = {
    font = "Trebuchet MS",
    size = 42,
    weight = 900,
}
 
tblFonts["HUDNumber3"] = {
    font = "Trebuchet MS",
    size = 43,
    weight = 900,
}
 
tblFonts["HUDNumber4"] = {
    font = "Trebuchet MS",
    size = 44,
    weight = 900,
}
 
tblFonts["HUDNumber5"] = {
    font = "Trebuchet MS",
    size = 45,
    weight = 900,
}
 
tblFonts["HudHintTextLarge"] = {
    font = "Verdana",
    size = 14,
    weight = 1000,
    antialias = true,
    additive = true,
}
 
tblFonts["HudHintTextSmall"] = {
    font = "Verdana",
    size = 11,
    weight = 0,
    antialias = true,
    additive = true,
}
 
tblFonts["CenterPrintText"] = {
    font = "Trebuchet MS",
    size = 18,
    weight = 900,
    antialias = true,
    additive = true,
}
 
tblFonts["DefaultFixed"] = {
    font = "Lucida Console",
    size = 10,
    weight = 0,
}
 
tblFonts["DefaultFixedDropShadow"] = {
    font = "Lucida Console",
    size = 10,
    weight = 0,
    shadow = true,
}
 
tblFonts["CloseCaption_Normal"] = {
    font = "Tahoma",
    size = 16,
    weight = 500,
}
 
tblFonts["CloseCaption_Italic"] = {
    font = "Tahoma",
    size = 16,
    weight = 500,
    italic = true,
}
 
tblFonts["CloseCaption_Bold"] = {
    font = "Tahoma",
    size = 16,
    weight = 900,
}
 
tblFonts["CloseCaption_BoldItalic"] = {
    font = "Tahoma",
    size = 16,
    weight = 900,
    italic = true,
}
 
tblFonts["TargetID"] = {
    font = "Trebuchet MS",
    size = 22,
    weight = 900,
    antialias = true,
}
 
tblFonts["TargetIDSmall"] = {
    font = "Trebuchet MS",
    size = 18,
    weight = 900,
    antialias = true,
}
 
tblFonts["BudgetLabel"] = {
    font = "Courier New",
    size = 14,
    weight = 400,
    outline = true,
}
 
 
for k,v in SortedPairs( tblFonts ) do
    surface.CreateFont( k, tblFonts[k] );
 
    --print( "Added font '"..k.."'" );
end
surface.CreateFont( "JailBreakTitleFont", {
	font        = "Chinese Rocks rg",
	size        = 128,
	weight      = 400,
	antialias   = true,
} ) 
surface.CreateFont( "JailBreakTitleFontLevel2", {
	font        = "Chinese Rocks rg",
	size        = 60,
	weight      = 400,
	antialias   = true,
} ) 
surface.CreateFont( "JailBreakTitleFontSmall", {
	font        = "Chinese Rocks rg",
	size        = 100,
	weight      = 400,
	antialias   = true,
} ) 
surface.CreateFont( "JailBreakTitleFontSmallest", {
	font        = "Chinese Rocks rg",
	size        = 40,
	weight      = 400,
	antialias   = true,
} ) 
surface.CreateFont( "JailbreakMenuThingMainButton", {
	font        = "Sports Jersey",
	size        = 100,
	weight      = 400,
	antialias   = true,
} ) 

-- entity -1585.3541 -359.9099 165.6040
-- cam -1581.458496 -396.353424 222.742065;setang 0.340060 89.003883 0.000000

JB.MainMenuEnabled = false;
JB.MainMenuCharacterScreen = false;

local function WorldToScreen(vWorldPos,vPos,aRot)
	local vWorldPos=vWorldPos-vPos;
	vWorldPos:Rotate(Angle(0,-aRot.y,0));
	vWorldPos:Rotate(Angle(-aRot.p,0,0));
	vWorldPos:Rotate(Angle(0,0,-aRot.r));
	return vWorldPos.x/0.1,(-vWorldPos.y)/0.1;
end
local selectedTeam = "prisoner";
local preview
local selection = 0;
local prisoner = 1;
local bg = surface.GetTextureID("vgui/background_texture")
local lenOne = 36;
local lenTwo = 36;
local full = surface.GetTextureID("excljailbreak/full");
hook.Add("PostDrawTranslucentRenderables","123PostDrawLolMeowRgrg", function()
	if not JB.MainMenuEnabled then return end

	local mmp = MenuMain.pos+Vector(-113.3646, 45.0206, -93.8978);

	if not preview or not preview:IsValid() then
		preview = ents.FindByClass("jb_previewmodel")[1]
	end
	
	selection = 0;
	
	local pos = LocalPlayer():GetEyeTrace().HitPos;			
	local xMouse, yMouse = WorldToScreen(Vector(pos.x,mmp.y,pos.z),mmp,Angle(0,0,90));
	
	render.SetToneMappingScaleLinear(Vector(0.8,1,3));
	cam.Start3D2D(mmp,Angle(0,0,90), .1);
		surface.SetDrawColor(200,200,200)
		surface.DrawRect(x-500,y-500,512*7,512*4);
		
		surface.SetDrawColor(255,255,255,200);
		surface.SetTexture(bg);
		for i=0,7 do
			for j=0,4 do
				surface.DrawTexturedRect(x-500+(i*512),y-500+(j*512),512,512);
			end
		end
		--####################
		--##   MAINMENU    ##
		--####################
		
		local MouseIsGood = (xMouse > x+1725 and xMouse < x+2275)
		draw.SimpleText("Welcome to Jailbreak3,", "HUDNumber5",x+2000,y,Color(0,0,0,255),1,0);
		draw.SimpleText(LocalPlayer():Nick(), "JailBreakTitleFont",x+2000,y+48,Color(0,0,0,255),1,0);
		
		draw.SimpleText("Select a team below", "HUDNumber5",x+2000,y+180,Color(0,0,0,255),1,0);
		
		local cA , cB , cC = Color(255,255,255,255),Color(255,255,255,255),Color(255,255,255,255);
		
		if not JB:CanBeGuard() then
			cB = Color(100,100,100,255);
		end
		
		if MouseIsGood and yMouse > y+230 and yMouse < y+330 then
			cA = Color(200,145,23,255);
			selection = 5;
		elseif MouseIsGood and yMouse > y+340 and yMouse < y+440 then
			if JB:CanBeGuard() then
				cB = Color(200,145,23,255);
				selection = 6;
			end
		elseif MouseIsGood and yMouse > y+450 and yMouse < y+550 then
			cC = Color(200,145,23,255);
			selection = 7;
		end	
		
		surface.SetDrawColor(0,0,0)
		surface.DrawRect(x+1725,y+230,550,100);
		draw.SimpleText("Prisoners", "JailbreakMenuThingMainButton",x+2000,y+223,cA,1,0);
		
		surface.DrawRect(x+1725,y+340,550,100);
		draw.SimpleText("Guards", "JailbreakMenuThingMainButton",x+2000,y+333,cB,1,0);
		
		surface.DrawRect(x+1725,y+450,550,100);
		draw.SimpleText("Spectators", "JailbreakMenuThingMainButton",x+2000,y+443,cC,1,0);
		
		if not JB:CanBeGuard() then
		surface.SetDrawColor(255,255,255,255);
		surface.SetTexture(full)
		surface.DrawTexturedRectRotated(x+2000,y+398,230,230,8)
		end
		--####################
		--##   CHARACTER    ##
		--####################

		for i=0,18 do
			local s = tostring(2.30-(i*0.10));
			
			while string.len(s) < 4 do
				if string.len(s) == 1 then
					s = s..".00";
					break
				else
					s = s.."0";
				end
			end
			draw.SimpleText(s.." m", "TargetID",x+100,y+82+(i*50),Color(0,0,0,255),0,0);
			surface.DrawRect(x+100,y+100+(i*50),760,3);
		end
		
		local t;
		if selectedTeam == "guard" then
			t = JB.Characters.Guard[prisoner];
			if preview and preview:IsValid() then
				preview.Prisoner = false;
			end
		else
			t = JB.Characters.Prisoner[prisoner];
			if preview and preview:IsValid() then
				preview.Prisoner = true;
			end
		end	
		local MouseIsGood = (yMouse > y+252 and yMouse < y+252+120)
		if xMouse > x+435 and xMouse < x+435+(410/2) and MouseIsGood  then
			draw.SimpleText("< Previous", "HUDNumber5",x+435,y+252,Color(0,0,150,255),0,0);
			selection = 1;
		else
			draw.SimpleText("< Previous", "HUDNumber5",x+435,y+252,Color(0,0,0,255),0,0);
		end
		
		if xMouse > x+435+(410/2) and xMouse < x+435+410 and MouseIsGood then
			draw.SimpleText("Next >", "HUDNumber5",x+845,y+252,Color(0,0,150,255),2,0);
			selection = 2;
		else
			draw.SimpleText("Next >", "HUDNumber5",x+845,y+252,Color(0,0,0,255),2,0);
		end
		
		surface.DrawRect(x+435,y+490,410,305);
		surface.DrawRect(x+435,y+445,410,40);
		draw.DrawText(t.name.." \""..t.nick.."\" "..t.surname, "JailBreakTitleFontSmallest",x+445,y+446,Color(255,255,255),0,0);
		
		draw.DrawText(JB.util.FormatLine(t.background,"TargetID",390), "TargetID",x+445,y+495,Color(255,255,255),0,0);
		
		if xMouse > x+435 and xMouse < x+435+410 and yMouse > y+805 and yMouse < y+805+40 then
			lenOne = Lerp(0.20,lenOne,406);
			selection = 3;
		else
			lenOne = Lerp(0.20,lenOne,36);
		end
		if xMouse > x+435 and xMouse < x+435+410 and yMouse > y+856 and yMouse < y+896 then
			lenTwo = Lerp(0.20,lenTwo,406);
			selection = 4;
		else
			lenTwo = Lerp(0.20,lenTwo,36);
		end
		
		surface.DrawRect(x+435,y+806,410,40);
		surface.DrawRect(x+435,y+856,410,40);
		
		surface.SetDrawColor(200,145,23,255);
		
		surface.DrawRect(x+437,y+808,lenOne,36);
		surface.DrawRect(x+437,y+858,lenTwo,36);
		
		draw.DrawText(">", "HUDNumber3",x+441,y+803,Color(0,0,0),0,0);
		draw.DrawText("SELECT CHARACTER", "HUDNumber3",x+480,y+805,Color(255,255,255),0,0);
				
		draw.DrawText(">", "HUDNumber3",x+441,y+853,Color(0,0,0),0,0);
		draw.DrawText("BACK TO MAIN", "HUDNumber3",x+480,y+855,Color(255,255,255),0,0);
				
		surface.SetDrawColor(0,0,0);
		if preview and preview:IsValid() then
			preview.TargetModel = t.model;
		end
		surface.DrawRect(x+435,y+315,120,120);
		surface.DrawRect(x+580,y+315,120,120);
		surface.DrawRect(x+725,y+315,120,120);
		
		surface.SetDrawColor(255,255,255,255);
		surface.SetTexture(t.img1);
		surface.DrawTexturedRect(x+437,y+317,116,116);
		surface.SetTexture(t.img2);
		surface.DrawTexturedRect(x+582,y+317,116,116);
		surface.SetTexture(t.img3);
		surface.DrawTexturedRect(x+727,y+317,116,116);

	cam.End3D2D();
	render.TurnOnToneMapping();
end);

local nextPress = CurTime();
hook.Add( "GUIMouseReleased", "JB1232412fKeyPressedHook", function(mc)
	if mc~=MOUSE_LEFT or (not selection) or nextPress > CurTime() then return end
	nextPress = CurTime()+0.2;
	
	if selection == 1 then
		prisoner = prisoner-1;
		if prisoner < 1 then
			prisoner = #JB.Characters.Prisoner;	
		end
	elseif selection == 2 then
		prisoner = prisoner+1;
		if prisoner > #JB.Characters.Prisoner then
			prisoner = 1;
		end
	elseif selection == 4 then
		RunConsoleCommand("jb_menu_backtomain")		
		JB.MainMenuCharacterScreen = false;
		JB:ResetSkipMenuMoves()
	elseif selection == 3 then
		RunConsoleCommand("jb_menu_selectcharacter",selectedTeam,prisoner);
	elseif selection == 5 then
		JB.MainMenuCharacterScreen = true;
		RunConsoleCommand("jb_menu_gocharacterpos");
		JB:ResetSkipMenuMoves()
		selectedTeam = "prisoner"
	elseif selection == 6 then
		RunConsoleCommand("jb_menu_selectcharacter","guard");
	end
end);

usermessage.Hook("JOMM", function()
	JB.MainMenuEnabled = true;
	gui.EnableScreenClicker(true);
end);

-- enabled by default.
JB.MainMenuEnabled = true;
gui.EnableScreenClicker(true);

usermessage.Hook("JCMM", function()
	JB.MainMenuEnabled = false;
	gui.EnableScreenClicker(false);
end);

