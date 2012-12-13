surface.CreateFont ("Chinese Rocks rg", 40, 200, true, false, "pbTitleFont") --unscaled
local PNL = { }

function PNL:Init()
	self.OnDone = function() end
	timer.Simple(1, function()
		self.OnDone();
	end)
end
vgui.Register( "pbMenuPanel", PNL, "Panel" );