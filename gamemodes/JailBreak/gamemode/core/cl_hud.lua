-- Ill work on it later.

local nodrawWeps = {"CHudDeathNotice", "CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo", "CHudCrosshair", "CHudDamageIndicator"}
function JB:HUDShouldDraw(name)
	if table.HasValue(nodrawWeps, name) then
		return false;
	end
	return true;
end

-- Stolen from EXCLCentre -- by JB

surface.CreateFont ("Steelfish Rg", 28, 400, true, false, "NicknameFont")

local clamp,sin,cos,rad =math.Clamp,math.sin,math.cos,math.rad;
local deg2rad = math.pi / 180;
local screenpos = Vector( 90, 90, 0 );
local portraitpos = screenpos;
local displayportrait = false;
local pos;
local target;
local ang;
local newpos;
local fov = 85;
local CharacterPortrait;
local h_old = 0;
local h_color = Color(200,0,0);
local x_id = 135;
local y_id = 40;
local x_info = x_id+15;
local y_info = y_id+24;
local x_team,y_team = x_info,y_info + 2;
-- Poly stuff...
local circle = {}
for i=1,15 do
	circle[i] = {x = portraitpos.x + cos(rad(i*360)/15)*60,y = portraitpos.y + sin(rad(i*360)/15)*60};
end

local idpanel = {{x=x_id,y=y_id},{x=x_id+170,y=y_id},{x=x_id+180,y=y_id+10},{x=x_id+180,y=y_id+23},{x=x_id+15,y=y_id+23}}
local idpanel_outline = {{x=x_id-1,y=y_id-1},{x=x_id+170.5,y=y_id-1},{x=x_id+181,y=y_id+9.5},{x=x_id+181,y=y_id+24},{x=x_id+15-2,y=y_id+24}}
local teampanel_outline = {{x=x_team-1,y=y_team-1},{x=x_team+140,y=y_team},{x=x_team+140,y=y_team+10.5},{x=x_team+130,y=y_team+21},{x=x_team,y=y_team+21}}

local ammopanel = {{x=ScrW()-160,y=y_id},{x=ScrW()-40,y=y_id},{x=ScrW()-40,y=y_id+23},{x=ScrW()-170,y=y_id+23},{x=ScrW()-170,y=y_id+10}}
local ammopanel_outline = {{x=ScrW()-160,y=y_id-1},{x=ScrW()-39,y=y_id-1},{x=ScrW()-39,y=y_id+24},{x=ScrW()-171,y=y_id+24},{x=ScrW()-171,y=y_id+10}}

local av = {{x=169,y=89},{x=x_id+180,y=89},{x=x_id+180,y=106},{x=x_id+163,y=123},{x=169,y=123}}
local av_outline = {{x=168,y=88},{x=x_id+181,y=88},{x=x_id+181,y=106},{x=x_id+163,y=124},{x=168,y=124}}

local tri = {{x=ScrW()/2,y=ScrH()/2},{x=ScrW()/2+18,y=ScrH()/2-9},{x=ScrW()/2+18,y=ScrH()/2+9}}
local tri_outline = {{x=ScrW()/2-1,y=ScrH()/2},{x=ScrW()/2+19,y=ScrH()/2-10},{x=ScrW()/2+19,y=ScrH()/2+10}}
local function CreateCharPortrait()
	local m;
	if LocalPlayer() and LocalPlayer():IsValid() then
		m = LocalPlayer():GetModel() or "models/Humans/Group02/Male_04.mdl";
	else
		m = "models/Humans/Group02/Male_04.mdl"
	end
	
	if CharacterPortrait and CharacterPortrait:IsValid() then
		CharacterPortrait:Remove();
	end
	
	CharacterPortrait = ClientsideModel(m, RENDERGROUP_OPAQUE);
	CharacterPortrait:SetNoDraw( true )
	local bone = CharacterPortrait:LookupBone("ValveBiped.Bip01_Head1");

	if bone then
		pos, ang = CharacterPortrait:GetBonePosition( bone )
		local target = CharacterPortrait:GetPos()+Vector(0,0,66)
		local newpos = ang:Forward() * 2 + ang:Right() * 10 + ang:Up() * 13
		pos = target + newpos
		ang = (target-pos):Angle()
		fov = 85
	else
		CharacterPortrait:SetAngles( Angle( 0, 180, 0 ) )
		local mn, mx = CharacterPortrait:GetRenderBounds()
		local size = 0
		size = math.max( size, math.abs(mn.x) + math.abs(mx.x) )
		size = math.max( size, math.abs(mn.y) + math.abs(mx.y) )
		size = math.max( size, math.abs(mn.z) + math.abs(mx.z) )
		size = size * (1 - ( size / 900 ))
		ang = Angle( 25, 40, 0 )
		pos = CharacterPortrait:GetPos() + ang:Forward() * size * -15 + (mn + mx) * 0.5
		fov = 10
	end
end
CreateCharPortrait()
timer.Create( "RefreshPortrait", 5, 0, function()
	CreateCharPortrait()
end)

local function DisplayCharPortrait( bool )
	if bool then
		portraitpos = Vector( Lerp( 0.2, portraitpos.x, screenpos.x ), screenpos.y, screenpos.z )
		for i=1,15 do
			circle[i] = {x = portraitpos.x + cos(rad(i*360)/15)*60,y = portraitpos.y + sin(rad(i*360)/15)*60}
		end
		displayportrait = true
	else
		portraitpos = Vector( Lerp( 0.2, portraitpos.x, -500 ), screenpos.y, screenpos.z )
		if portraitpos.x < 0 then
			displayportrait = false
		end
	end
end


function DrawPartialCircle( x, y, radius, linewidth, startangle, endangle, aa )
	-- Thanks for getting me started on how to do this python1320 <3
    aa = aa or 1;
    startangle = clamp( startangle or 0, 0, 360 );
    endangle = clamp( endangle or 360, 0, 360 );
     
    if endangle < startangle then
        local temp = endangle;
        endangle = startangle;
        startangle = temp;
    end

    for i=startangle, endangle, aa do
        local _i = i * deg2rad;         
        surface.DrawTexturedRectRotated(cos( _i ) * (radius - linewidth) + x,sin( _i ) * (radius - linewidth) + y, linewidth, aa*2, -i );
    end
end

hook.Add( "Think", "JBDisplayPortrait",function()
	local localplayer = LocalPlayer()
	if (localplayer:Team() ~= TEAM_PRISONER and localplayer:Team() ~= TEAM_GUARD) then return end

	DisplayCharPortrait( true );
end)

local wAv;
local awP;

local count = 0;
local count_start = CurTime();
local count_g = 200;
local color_r = 0
local count_cir = 360
local count_title = "No title set."
function JB:HUDStartTimer(t,n)
	count = t;
	count_start = CurTime();
	count_g = 200;
	color_r = 0
	count_cir = 360
	count_title = n;
end
hook.Add("HUDPaint","JBCircleHealthDisplay", function()
	local localplayer = LocalPlayer();
	local w = JB.wardenPlayer;
	if not localplayer or not localplayer:IsValid() or (localplayer:Team() ~= TEAM_PRISONER and localplayer:Team() ~= TEAM_GUARD) then
		if wAv and wAv:IsValid() then
			wAv:Remove();
		end
		 return 
	end
	
	if (not wAv or not wAv:IsValid()) and w and w:IsValid() then
		wAv = vgui.Create("AvatarImage", frame)
		wAv:SetPos(170,90)
		wAv:SetSize(32, 32)
		wAv:SetPlayer(w, 32 )
		awP = w;
	elseif wAv and wAv:IsValid() and (not w or not w:IsValid()) then
		wAv:Remove();
	end

	if awP ~= w and wAv and wAv:IsValid() and w and w:IsValid() then
		wAv:SetPlayer(w,32)
		awP = w;
	end


	surface.SetTexture();
    surface.SetDrawColor(0,0,0,255);
    if w and w:IsValid() then
    surface.DrawPoly(av_outline);
	end
	surface.DrawPoly(idpanel_outline);
	surface.DrawPoly(ammopanel_outline);
	surface.DrawRect(ScrW()-171,y_id+23,132,18)
	surface.DrawRect(x_info, y_info, 166,17);
	surface.DrawRect(x_id+183, y_id+10, 4,31);
	surface.DrawRect(x_id+189, y_id+10, 4,31);
	surface.DrawRect(ScrW()-170-6, y_id+10, 4,31);
	surface.DrawRect(ScrW()-170-6-6, y_id+10, 4,31);
	
	--surfavce.DrawPoly(teampanel_outline);
	
	surface.SetDrawColor(200,200,200,200);
	if w and w:IsValid() then
	surface.DrawPoly(av)
	local t = "Warden"
	if not w:Alive() then
		t = t.." (dead)"
	end
	draw.SimpleText(t, "DefaultBold", 205,90,Color(0,0,0),0,0);

	draw.SimpleText(JB.wardenPlayer:Nick(), "Default", 205,105,Color(0,0,0),0,0);
	end
    surface.DrawPoly(idpanel);
    draw.SimpleText(localplayer:Nick(), "TargetID", 160,41,Color(0,0,0),0,0);
	surface.DrawPoly(ammopanel);

	

	surface.SetDrawColor( 230,230,230,200 );

	surface.DrawRect(ScrW()-170,y_id+24,130,16)

	surface.DrawRect(x_info, y_info, 165,16);
	if localplayer:Team() == TEAM_GUARD then
		local s= "Guard";
		if JB.wardenPlayer and JB.wardenPlayer == localplayer then
			s= "Warden";
		end
		draw.SimpleText(s, "Default", x_info+12, y_info+1,Color(0,0,0));
	elseif localplayer:Team() == TEAM_PRISONER then
		local c = "Loading..."; 
		if localplayer.character then
			c = localplayer.character.name.." \""..localplayer.character.nick.."\" "..localplayer.character.surname;
		end
		draw.SimpleText(c, "Default", x_info+12, y_info+1,Color(0,0,0));
	end

	local ammo = "none";
	if LocalPlayer():GetActiveWeapon() and LocalPlayer():GetActiveWeapon().Primary and LocalPlayer():GetActiveWeapon().Primary.ClipSize and LocalPlayer():GetActiveWeapon():Clip1() >= 0 then
		ammo = LocalPlayer():GetActiveWeapon():Clip1().."/"..LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon().Ammo);
	end
	draw.SimpleText(ammo, "Default", ScrW()-50, y_info+1,Color(0,0,0),2);

	draw.SimpleText("Ammo:", "DefaultBold", ScrW()-160, y_info+1,Color(0,0,0));

	draw.SimpleText(JB:RoundTimeToString(), "TargetID", ScrW()-50, 41,Color(0,0,0),2);

	surface.SetDrawColor( 100,100,100, 150 );
	
	
	render.ClearStencil();
	render.SetStencilEnable( true );
	render.SetStencilFailOperation( STENCILOPERATION_KEEP );
	render.SetStencilZFailOperation( STENCILOPERATION_REPLACE );
	render.SetStencilPassOperation( STENCILOPERATION_REPLACE );
	render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_ALWAYS );
	render.SetStencilReferenceValue( 1 );
	if displayportrait then
		surface.SetDrawColor( 0,0,0, 155 );
		surface.DrawPoly( circle );
	end
	render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_EQUAL );
	render.SetStencilPassOperation( STENCILOPERATION_REPLACE );
	cam.Start3D( pos, ang, fov, portraitpos.x-80,portraitpos.y-80 , 150 , 150 );
		cam.IgnoreZ( true );
		render.SuppressEngineLighting( true );
		render.SetLightingOrigin( CharacterPortrait:GetPos() );
		render.ResetModelLighting( 1,1,1 );
		render.SetColorModulation( 1,1,1 );
		render.SetBlend( 1 );
		render.SetLightingOrigin( CharacterPortrait:GetPos() );
			CharacterPortrait:DrawModel();
		render.SuppressEngineLighting( false );
		cam.IgnoreZ( false );
	cam.End3D();
	render.SetStencilEnable( false );
	
	if h_old > localplayer:Health() then
		h_old = h_old-1;
	elseif h_old < localplayer:Health() then
		h_old = h_old+1;
	end
	
	local add = 0
	if h_old < 30 then
		add = 50*math.sin(CurTime()*4);
	end
	
	surface.SetTexture()	
	surface.SetDrawColor( 10,10,10,255 );
	DrawPartialCircle( portraitpos.x, portraitpos.y, 76, 12, 0, 360, 6 );
	surface.SetDrawColor( h_color.r+add,h_color.g+add,h_color.b+add,h_color.a ); -- health-color translations, yay!
	DrawPartialCircle( portraitpos.x, portraitpos.y, 74, 10, 0, h_old/100*360, 6 );


	-- Timers.
	local n = (count_start+count) - CurTime();

	if n < 0 then return end

	count_g = (n/count)*200;
	count_r = (1-(n/count))*200

	count_cir = (n/count)*360

	surface.SetDrawColor(10,10,10,255);
	DrawPartialCircle( ScrW()/2-37, ScrH()/2, 60 ,12, 0, 360, 2 );
	surface.SetDrawColor(count_r,count_g,0,255);
	DrawPartialCircle( ScrW()/2-37, ScrH()/2, 59 ,11, 0, count_cir, 2 );

	surface.SetDrawColor(0,0,0,255);
	surface.DrawPoly(tri_outline);
	surface.SetDrawColor(200,200,200,255);
	surface.DrawPoly(tri);

	draw.SimpleTextOutlined(math.Round(n), "HUDNumber5", ScrW()/2-37, ScrH()/2,Color(255,255,255),1,1,1,Color(0,0,0));
	draw.SimpleTextOutlined(count_title, "TargetID", ScrW()/2+25, ScrH()/2,Color(255,255,255),0,1,1,Color(0,0,0));
end);
