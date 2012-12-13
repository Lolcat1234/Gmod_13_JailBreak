-- cl_weaponselection
-- the weapon selection menu

local selectedTab = 0;
local midX = ScrW()/2;
local midY = ScrH()/2;
local len = 100;
local hSelect = 70;
local start = midX-((len+5+len+5+len+5+len)/2);
local c = 0;
local slots = {}
local slotPos = 1;
local function ArrangeSlots()
	slots = {};
	c = 0;
	for k,v in pairs(LocalPlayer():GetWeapons())do
		if v.Slot then
			if not slots[v.Slot+1] then
				slots[v.Slot+1] = {}
			end
			slots[v.Slot+1][#slots[v.Slot+1]+1] = v;
			if v.Slot == 3 then
				c = c+1;
			end
		end
	end
	if selectedTab == 4 then
		slotPos = (((slotPos-1)%c)+1);
	else
		slotPos = 1;
	end
end

hook.Add("HUDPaint","JBWeaponSelection",function()
	if selectedTab > 0 and LocalPlayer():Alive() and LocalPlayer():Team() < 3 then
		surface.SetDrawColor(0,0,0,255);
		surface.DrawRect(start,40,len,40)
		surface.DrawRect(start+len+5,40,len,40)
		surface.DrawRect(start+len+5+len+5,40,len,40)
		surface.DrawRect(start+len+5+len+5+len+5,40,len,40)

		surface.SetDrawColor(230,230,230,200);
		surface.DrawRect(start+1,41,len-2,38)
		surface.DrawRect(start+len+6,41,len-2,38)
		surface.DrawRect(start+len+5+len+6,41,len-2,38)
		surface.DrawRect(start+len+5+len+5+len+6,41,len-2,38)

		surface.SetDrawColor(0,0,0,255);
		surface.DrawRect(start+3,43,6,34)
		surface.DrawRect(start+3+len+5,43,6,34)
		surface.DrawRect(start+3+len+5+len+5,43,6,34)
		surface.DrawRect(start+3+len+5+len+5+len+5,43,6,34)

		draw.SimpleText("Primary","Trebuchet19",start+(len/2),60,Color(0,0,0),1,1)
		draw.SimpleText("Secondary","Trebuchet19",start+len+5+(len/2),60,Color(0,0,0),1,1)
		draw.SimpleText("Melee","Trebuchet19",start+len+5+len+5+(len/2),60,Color(0,0,0),1,1)
		draw.SimpleText("Other","Trebuchet19",start+len+5+len+5+len+5+(len/2),60,Color(0,0,0),1,1)

		surface.SetDrawColor(200,145,23,255);
		surface.DrawRect(start+((selectedTab-1)*(len+5))+4,44,4,32);

		if slots[selectedTab] and slots[selectedTab][1] then
			for k,v in pairs(slots[selectedTab]) do
				surface.SetDrawColor(0,0,0,255);
				surface.DrawRect(start+((selectedTab-1)*(len+5)),85+((k-1)*(hSelect+2)),len,hSelect);
				if slotPos == k then
					surface.SetDrawColor(180,180,180,200);
				else
					surface.SetDrawColor(160,160,160,200);
				end
				surface.DrawRect(start+((selectedTab-1)*(len+5))+1,85+((k-1)*(hSelect+2))+1,len-2,hSelect-2);

				draw.SimpleText(slots[selectedTab][k].PrintName or "Invalid","default",start+((selectedTab-1)*(len+5))+(len/2),85+(k*(hSelect+2))-25,Color(0,0,0),1,2)
			end
		else
			surface.SetDrawColor(0,0,0,255);
			surface.DrawRect(start+((selectedTab-1)*(len+5)),85,len,40);
			surface.SetDrawColor(180,180,180,200);
			surface.DrawRect(start+((selectedTab-1)*(len+5))+1,86,len-2,40-2);

			draw.SimpleText("Empty Slot","default",start+((selectedTab-1)*(len+5))+(len/2),85+40+2-25,Color(0,0,0),1,2)
		end

		--[[
		local wep = "Empty slot"
		local h = 40;
		if slots[selectedTab] then
			wep = slots[selectedTab].PrintName;
			h = 90;
		end

		surface.SetDrawColor(200,145,23,255);
		surface.DrawRect((midX-130-135)+(135*(selectedTab-1))+4,44,4,32);
		surface.SetDrawColor(0,0,0,255);
		surface.DrawRect((midX-130-135)+(135*(selectedTab-1)),85,130,h);
		surface.SetDrawColor(180,180,180,200);
		surface.DrawRect((midX-130-135)+(135*(selectedTab-1))+1,86,128,h-2);
		draw.SimpleText(wep,"default",(midX-130-135)+(135*(selectedTab-1))+65,60+h-3,Color(0,0,0),1,2)]]
	end
end)

timer.Create("UpdateSWEPSelectthings",1,0,function()
	if selectedTab > 0 then
		ArrangeSlots();
	end
end)

local nScroll = 1;
hook.Add("PlayerBindPress","JBBindWEapons", function(p, bind, pressed)

	if not pressed then return end

	if string.find(bind, "invnext") then
		if LocalPlayer():Team() > 2 then return true  end
		nScroll = nScroll + 1;
		if nScroll > 4 then
			nScroll = 1;
		end

		if selectedTab ~= nScroll then
			surface.PlaySound("common/wpn_moveselect.wav");
		end
		selectedTab = nScroll;
		ArrangeSlots();

		return true;
	elseif string.find(bind, "invprev") then
		if LocalPlayer():Team() > 2 then return true  end

		nScroll = nScroll-1;
		if nScroll < 1 then
			nScroll = 4;
		end

		if selectedTab ~= nScroll then
			surface.PlaySound("common/wpn_moveselect.wav");
		end
		selectedTab = nScroll;
		ArrangeSlots();

		return true;
	elseif string.find(bind, "slot0") then 
		selectedTab = 0;
		return true 
	elseif string.find(bind, "slot1") then 
		if LocalPlayer():Team() > 2 then return true  end
		if selectedTab ~= 1 then
			surface.PlaySound("common/wpn_moveselect.wav");
		end
		selectedTab = 1;
		ArrangeSlots();
		return true 
	elseif string.find(bind, "slot2") then
		if LocalPlayer():Team() > 2 then return true  end
		if selectedTab ~= 2 then
			surface.PlaySound("common/wpn_moveselect.wav");
		end
		selectedTab = 2;
		ArrangeSlots();
		return true 
	elseif string.find(bind, "slot3") then 
		if LocalPlayer():Team() > 2 then return true  end
		if selectedTab ~= 3 then
			surface.PlaySound("common/wpn_moveselect.wav");
		end
		selectedTab = 3;
		ArrangeSlots();
		return true 
	elseif string.find(bind, "slot4") then 
		if LocalPlayer():Team() > 2 then return true  end
		surface.PlaySound("common/wpn_moveselect.wav");
		if selectedTab == 4 then
			slotPos = slotPos+1;
		end
		selectedTab = 4;
		ArrangeSlots();
		return true
	elseif string.find(bind, "slot5") then 
		selectedTab = 0;
		return true
	elseif string.find(bind, "slot6") then 
		selectedTab = 0;
		return true
	elseif string.find(bind, "slot7") then 
		selectedTab = 0;
		return true
	elseif string.find(bind, "slot8") then 
		selectedTab = 0;
		return true
	elseif string.find(bind, "slot9") then 
		selectedTab = 0;
		return true
	elseif string.find(bind, "+attack") then 
		if LocalPlayer():Team() > 2 then return true end
		if selectedTab > 0 and slots[selectedTab] then
			if not slots[selectedTab][slotPos] then return true end
			RunConsoleCommand("use",slots[selectedTab][slotPos]:GetClass())

			nScroll = selectedTab;
			selectedTab = 0;

			return true;
		end
	end
end)
