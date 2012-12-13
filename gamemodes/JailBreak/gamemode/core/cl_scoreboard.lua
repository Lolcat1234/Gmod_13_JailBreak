local scorePanel;

local w=516;
local rows = {}

local function MakeScoreboard()
	scorePanel = vgui.Create("jbScoreboardPanel");
	scorePanel:SetSize(w,100)
	scorePanel:SetPos(ScrW()/2-w/2,100);
end
function JB:UpdateScoreboard()
	for k,v in pairs(team.GetPlayers(TEAM_GUARD))do
		if not rows[v:UniqueID()] or not rows[v:UniqueID()]:IsValid() then
			rows[v:UniqueID()] = vgui.Create("jbScoreboardRow",scorePanel);
			rows[v:UniqueID()]:SetSize((w/2)-3,40)
			--rows[v:UniqueID()]:SetPos(2,50)
			rows[v:UniqueID()]:SetUp(v);
			rows[v:UniqueID()]:SetVisible(false);
		end
	end
	for k,v in pairs(team.GetPlayers(TEAM_PRISONER))do
		if not rows[v:UniqueID()] or not rows[v:UniqueID()]:IsValid() then
			rows[v:UniqueID()] = vgui.Create("jbScoreboardRow",scorePanel);
			rows[v:UniqueID()]:SetSize((w/2)-3,40)
			--rows[v:UniqueID()]:SetPos(2,50)
			rows[v:UniqueID()]:SetUp(v);
			rows[v:UniqueID()]:SetVisible(false);
		end
	end
	for k,v in pairs(team.GetPlayers(TEAM_GUARD_DEAD))do
		if not rows[v:UniqueID()] or not rows[v:UniqueID()]:IsValid() then
			rows[v:UniqueID()] = vgui.Create("jbScoreboardRow",scorePanel);
			rows[v:UniqueID()]:SetSize((w/2)-3,40)
			--rows[v:UniqueID()]:SetPos(2,50)
			rows[v:UniqueID()]:SetUp(v);
			rows[v:UniqueID()]:SetVisible(false);
		end
	end
	for k,v in pairs(team.GetPlayers(TEAM_PRISONER_DEAD))do
		if not rows[v:UniqueID()] or not rows[v:UniqueID()]:IsValid() then
			rows[v:UniqueID()] = vgui.Create("jbScoreboardRow",scorePanel);
			rows[v:UniqueID()]:SetSize((w/2)-3,40)
			--rows[v:UniqueID()]:SetPos(2,50)
			rows[v:UniqueID()]:SetUp(v);
			rows[v:UniqueID()]:SetVisible(false);
		end
	end
	for k,v in pairs(rows)do
		if (not player.GetByUniqueID(k) or not player.GetByUniqueID(k):IsValid() or player.GetByUniqueID(k):Team() > 4)  and v then
			v:Remove();
			v=nil;
			k=nil;
		end
	end
	local h=153;
	local cLeft=0;
	local cRight=0;
	for k,v in pairs(rows)do
		if v and v:IsValid() and v.Player and v.Player:IsValid() then

			if v.Player:Team() == TEAM_PRISONER or v.Player:Team() == TEAM_PRISONER_DEAD then
				v:SetPos(2,152+(41*cLeft))
				cLeft = cLeft+1;
			elseif v.Player:Team() == TEAM_GUARD or v.Player:Team() == TEAM_GUARD_DEAD then
				v:SetPos((w/2)+1,152+(41*cRight))
				cRight = cRight+1;
			end
			v:SetVisible(true);
		end
	end
	
	local c = cLeft;
	if cLeft < cRight then
		c=cRight;
	end

	h=h+(41*c)+22;
	scorePanel:SetSize(w,h)
	scorePanel:SetPos(ScrW()/2-w/2,ScrH()/2-h/2-50);
end

function JB:ScoreboardShow()
	if not scorePanel or not scorePanel:IsValid() then
		MakeScoreboard()
	end
	JB:UpdateScoreboard();
end

function JB:ScoreboardHide()
	if scorePanel and scorePanel:IsValid() then
   		scorePanel:Remove();
   end
end

timer.Create("UpdateScoreboardTimer",1,0,function() if not scorePanel or not scorePanel:IsValid() then return; end JB:UpdateScoreboard(); end);
