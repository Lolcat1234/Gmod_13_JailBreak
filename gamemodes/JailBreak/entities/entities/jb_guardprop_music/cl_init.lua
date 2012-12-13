ENT.Type             = "anim"
ENT.Base             = "base_anim"
ENT.PrintName            = "Bouncy Ball"

local size =(200-8*4)/4;
local function WorldToScreen(vWorldPos,vPos,vScale,aRot)
    local vWorldPos=vWorldPos-vPos;
    vWorldPos:Rotate(Angle(0,-aRot.y,0));
    vWorldPos:Rotate(Angle(-aRot.p,0,0));
    vWorldPos:Rotate(Angle(0,0,-aRot.r));
    return vWorldPos.x/vScale,(-vWorldPos.y)/vScale;
end

function ENT:Draw()
    self:DrawModel();

    cam.Start3D2D( self:GetPos()+self:GetAngles():Up()*1.55, self:GetAngles(), 0.2375 )
		surface.SetDrawColor(213,213,213,200);

		local count = 0;
        local lookAtX,lookAtY = WorldToScreen(LocalPlayer():GetEyeTrace().HitPos or Vector(0,0,0),self:GetPos()+self:GetAngles():Up()*1.55, 0.2375, self:GetAngles());

		for y=0,3 do
			for x=0,3 do
                if lookAtX > -96+(x*(size+8)) and lookAtX < -96+(x*(size+8))+size and lookAtY > -96+(y*(size+8)) and lookAtY < -96+(y*(size+8))+size then
                    surface.SetDrawColor(200,145,23,255);
                end

    			surface.DrawRect(-96+(x*(size+8)),-96+(y*(size+8)),size,size);
    			count = count+1;
    			draw.SimpleText(count,"default",-96+(x*(size+8))+1,-96+(y*(size+8)),Color(0,0,0,100))

                surface.SetDrawColor(213,213,213,200);
    		end
    	end
    cam.End3D2D()
end
