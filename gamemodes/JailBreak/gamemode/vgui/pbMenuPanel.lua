surface.CreateFont( "pbTitleFont", {
	font       = "Chinese Rocks rg",
	size       = 40,
	weight     = 200,
	antialias  = true,
} )
local PNL = { }

function PNL:Init()
	self.OnDone = function() end
	timer.Simple(1, function()
		self.OnDone();
	end)
end
vgui.Register( "pbMenuPanel", PNL, "Panel" );