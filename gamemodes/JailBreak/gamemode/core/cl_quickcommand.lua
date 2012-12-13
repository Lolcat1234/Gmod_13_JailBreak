-- cl_quickcommand.lua
-- Dlaor helped me to make this :)
-- BTW this code is from prisonbreak2

local soundconvar = CreateClientConVar( "crysishud_enablesounds", 1, false, false )
local smoothconvar = CreateClientConVar( "crysishud_enabletransitions", 1, false, false )

local crytx = surface.GetTextureID( "crysis_button" )
local crycircletx = surface.GetTextureID( "crysis_circle" )
local cryarrowtx = surface.GetTextureID( "crysis_arrow" )
local global_mul, global_mul_goal = 0, 0 //The global multiplier, if this is 0 the menu is hidden, 1 and it's fully visible, between 0 and 1 for transition
local cryx, cryy = ScrW() / 2, ScrH() / 2 //Changing this makes the menu appear in a different place
local selected, oldselected = 0, 0 //Which slot is selected?

local snd_o, snd_c, snd_s, snd_h, snd_e = Sound( "cry_open.wav" ), Sound( "cry_close.wav" ), Sound( "cry_select.wav" ), Sound( "cry_hover.wav" ), Sound( "cry_error.wav" )

local crydist = {} //Distance to center for every slot
for i = 1, 5 do
	crydist[i] = 0
end

local function MouseInCircle( x, y ) //Checks if the mouse is in the circle
	
	local centerdist = math.Dist( gui.MouseX(), gui.MouseY(), x, y )
	return ( centerdist > 32 and centerdist < 150 )
	
end

hook.Add( "HUDPaint", "JBDrawQCMDMenu", function() //Good luck figuring all this shit out
	
	if ( global_mul_goal != global_mul ) then
		global_mul = global_mul + ( global_mul_goal - global_mul ) * math.Clamp( FrameTime() * 10, 0, 1 ) //I love mah math
	end 
	
	if ( global_mul == 0 ) then return end //Don't run if the menu ain't visible
	
	
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetTextColor( 255, 255, 255, global_mul * 255 )

	local cryadd = 360/5
	local numb = 1
	local cursorang = math.fmod( math.atan2( gui.MouseY() - cryy, gui.MouseX() - cryx ), math.pi * 2 ) //This angle shit makes my head implode
	local cursorangd = math.deg( cursorang ) + 180
	
	if ( cursorangd >= 0 and cursorangd < cryadd ) then selected = 4
	elseif ( cursorangd >= cryadd and cursorangd < cryadd * 2 ) then selected = 3
	elseif ( cursorangd >= cryadd * 2 and cursorangd < cryadd * 3 ) then selected = 2
	elseif ( cursorangd >= cryadd * 3 and cursorangd < cryadd * 4 ) then selected = 1
	elseif ( cursorangd >= cryadd * 4 and cursorangd < cryadd * 5 ) then selected = 5
	end
	
	if ( !MouseInCircle( cryx, cryy ) ) then selected = 0 end
	
	for i = 0 + cryadd / 2, 360 - cryadd / 2, cryadd do
		
		surface.SetTexture( crytx )
		
		local crydistadd = 96
		local crygray = 200
		if ( numb == selected ) then
			crydistadd = crydistadd * 1.3
			crygray = 255
		end
		
		crydist[numb] = crydist[numb] + ( crydistadd - crydist[numb] ) * math.Clamp( FrameTime() * 20, 0, 1 )
		
		local cryaddx, cryaddy = math.sin( math.rad( i ) ) * crydist[numb] * global_mul, math.cos( math.rad( i ) ) * crydist[numb] * global_mul
		surface.SetDrawColor( crygray, crygray, crygray, global_mul * 200 )
		surface.DrawTexturedRectRotated( cryx + cryaddx, cryy + cryaddy, 100 * global_mul, 100 * global_mul,0)
		
		draw.SimpleTextOutlined(JB.qcmds[numb].Text, "DefaultBold",  cryx + cryaddx, cryy + cryaddy+10, Color(255,255,255,global_mul * 200), 1,1, 1, Color(0,0,0,global_mul * 100));
		
		surface.SetTexture(JB.qcmds[numb].Icon);
		surface.DrawTexturedRect(cryx + cryaddx - 12.5, cryy + cryaddy - 20,25,25);
		numb = numb + 1
		
	end

	surface.SetTexture( cryarrowtx )
	local arrowang = math.pi * 2 - cursorang + math.pi / 2
	local arrowdist = 35 * global_mul
	local arrowx, arrowy = math.sin( arrowang ) * arrowdist, math.cos( arrowang ) * arrowdist
	surface.DrawTexturedRectRotated( cryx + arrowx, cryy + arrowy, 256 / 4, 68 / 4, math.deg( arrowang ) + 180 )
	
	if ( selected != oldselected and selected != 0 ) then surface.PlaySound( snd_h ) oldselected = selected end
	

end)

local function EnableMenu( b )

	if ( ( b and global_mul_goal == 0 ) ) then surface.PlaySound( snd_o ) end
	if ( b ) then global_mul_goal = 1 else global_mul_goal = 0 end
	
end

local enabled = false;
function JB:ToggleQCMD(b)
	

	if LocalPlayer():Team() == TEAM_GUARD and JB.wardenPlayer and JB.wardenPlayer == LocalPlayer() then

	print(b)

	if (b == false) then
		print("lol")
		if ( MouseInCircle( cryx, cryy ) ) then
			print("teehee")
			surface.PlaySound( snd_s )
			RunConsoleCommand( "jb_doqcmd", selected )
		elseif ( global_mul_goal == 1 ) then 
			surface.PlaySound( snd_c ) 
			RunConsoleCommand( "jb_doqcmd", 0)
		end
	end	
	
	EnableMenu(b)

	end
	gui.EnableScreenClicker( b )
end
