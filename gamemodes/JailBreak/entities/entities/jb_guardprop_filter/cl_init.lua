ENT.Type             = "anim"
ENT.Base             = "base_anim"
ENT.PrintName            = "Bouncy Ball"
ENT.RenderGroup         = RENDERGROUP_TRANSLUCENT

function ENT:Draw()
    self:DrawModel();
end
