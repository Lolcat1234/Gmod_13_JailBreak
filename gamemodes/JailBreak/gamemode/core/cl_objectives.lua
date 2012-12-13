-- cl_objectives
-- for making objectives appear 

local objActive = {};

function JB:KillObjective()
	objActive = {};
end
function JB:SetObjective(pos,o,t)
	objActive.pos = pos or Vector(0,0,0);
	objActive.o = o or "";
	objActive.s = t or "";

	JB:DebugPrint("New objective set");
end

tri = surface.GetTextureID("prisonbreak/notices/error");
hook.Add("HUDPaint", "DrawObjectives", function()
	if not objActive or not objActive.pos then return end
	

	local pos=objActive.pos:ToScreen();

	local s=objActive.s;
	local o=objActive.o;
	
	if LocalPlayer():GetPos():Distance(objActive.pos) < 1000 then
		surface.SetFont("TargetID");
		local w = surface.GetTextSize( s or "" )
		w = w + 40;
		
		local x = pos.x-(w/2);
		
		local col
		local col2
		if pos.visible then
			col = Color(220,220,220,250)
			col2al = 100
		else
			col = Color(220,220,220,230)
			col2al = 50
		end
		
		surface.SetDrawColor( 255, 255, 255, col2al );
		surface.SetTexture(tri);
		surface.DrawTexturedRect(x,pos.y-22,35,35);
		draw.SimpleText(o, "Default", x+40,pos.y-15, col, 0,1);	
		draw.SimpleTextOutlined(s, "TargetID", x+40,pos.y, col, 0,1,1, Color(0,0,0,col2al));
	else
		surface.SetDrawColor( 255, 255, 255, 100 );
		surface.SetTexture(tri);
		surface.DrawTexturedRect(pos.x-(35/2),pos.y-22,35,35);
		draw.SimpleText(o, "Default", pos.x,pos.y+17, col, 1,1);	
	end
end)
