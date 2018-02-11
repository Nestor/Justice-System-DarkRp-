timer.Simple(1, function() -- Need this here otherwise it doesn't inlcude.
	include("config/config.lua")
end)

surface.CreateFont( "PoliceFont", {
	font = "Trebuchet24",
	extended = false,
	size = 50,
	weight = 550,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "PoliceFontCredit", {
	font = "Trebuchet24",
	extended = false,
	size = 24,
	weight = 700,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = true,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "JailButtonFont", {
	font = "Trebuchet24",
	extended = false,
	size = 35,
	weight = 700,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "SeizeFont", {
	font = "Trebuchet24",
	extended = false,
	size = 33,
	weight = 700,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "RestrainFont", {
	font = "Trebuchet24",
	extended = false,
	size = 29,
	weight = 700,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

-- Precache the sounds needed
util.PrecacheSound("garrysmod/ui_hover.wav") -- Hover over menu button
util.PrecacheSound("ui/buttonclickrelease.wav") -- Clicked menu button
-- Net Receive Ticket
net.Receive("JSTicketCL3", function()

	local ply = LocalPlayer()
	local amount = net.ReadInt(32)
	local cop = net.ReadEntity()
	-- This is here for button sounds, so it's also called in the ticket for the perp.
	local function JSButtonS(num) -- Sounds for the menu buttons
		if num == 1 then -- Play the hover over button sound
			ply:EmitSound("garrysmod/ui_hover.wav")
		elseif num == 2 then --Play the button clicked sound
			ply:EmitSound("ui/buttonclickrelease.wav")
		end
	end

	for k,v in pairs(player.GetAll()) do
		if v == LocalPlayer() then

			local confirm = vgui.Create("DFrame")
				timer.Simple(10, function()
					gui.EnableScreenClicker(false) -- Disable Mouse
					confirm:Remove()
				end)
					confirm:SetSize(320, 200)
					confirm:SetPos((ScrW()/2) - 160,(ScrH()/2) - 100)
					confirm:SetTitle("")
					confirm:ShowCloseButton(false)
					confirm.Paint = function()
						surface.SetDrawColor(220, 220, 220, 235)
						surface.DrawRect(0, 0, 320, 200)
						surface.SetDrawColor(120, 190, 210, 235)
						surface.DrawRect(10, 10, 300, 180)
					end

					gui.EnableScreenClicker(true) -- Enable Mouse

					local line1 = vgui.Create("DLabel", confirm)
					line1:SetSize(300, 100)
					local titlennw, titlennh = surface.GetTextSize("Pay ticket for")
					line1:SetPos(130 - (titlennw/2), 0)
					line1:SetFont("RestrainFont")
					line1:SetText("Pay ticket for")

					local line2 = vgui.Create("DLabel", confirm)
					line2:SetSize(300, 100)
					local titlennw, titlennh = surface.GetTextSize(DarkRP.formatMoney(amount) .. " ?")
					line2:SetPos(140 - (titlennw/2), 40)
					line2:SetFont("RestrainFont")
					line2:SetText(DarkRP.formatMoney(amount).."?")

					local yes = vgui.Create("DButton", confirm)
					yes:SetSize(110, 60)
					yes:SetPos(37, 125)
					yes:SetText("")
					yes.Paint = function()
						surface.SetDrawColor(100, 100, 100, 235)
						surface.DrawRect(5, 5, 100, 50)
					end
					yes.OnCursorEntered = function()
						JSButtonS(1) -- Play button hover sound
						yes.Paint = function()
							surface.SetDrawColor(230, 230, 230, 235)
							surface.DrawRect(0, 0, 110, 60)
							surface.SetDrawColor(100, 100, 100, 235)
							surface.DrawRect(5, 5, 100, 50)
						end
					end
					yes.OnCursorExited = function()
						yes.Paint = function()
							surface.SetDrawColor(100, 100, 100, 235)
							surface.DrawRect(5, 5, 100, 50)
						end
					end
					yes.OnMousePressed = function()
						JSButtonS(2) -- Play button click sound
						yes.Paint = function()
							surface.SetDrawColor(230, 230, 230, 235)
							surface.DrawRect(0, 0, 110, 60)
							surface.SetDrawColor(235, 130, 130, 235)
							surface.DrawRect(5, 5, 100, 50)
						end
					end
					yes.OnMouseReleased = function()
						yes.Paint = function()
							surface.SetDrawColor(230, 230, 230, 235)
							surface.DrawRect(0, 0, 110, 60)
							surface.SetDrawColor(100, 100, 100, 235)
							surface.DrawRect(5, 5, 100, 50)
						end

						if ply:canAfford(amount) then
							net.Start("JSTicketSV4")
								net.WriteEntity(cop)
								net.WriteInt(1, 32)
							net.SendToServer()
							gui.EnableScreenClicker(false) -- Disable Mouse
							confirm:Remove()
						else
							ply:ChatPrint("You cannot afford to pay the ticket!")
							net.Start("JSTicketSV4")
								net.WriteEntity(cop)
								net.WriteInt(2, 32)
							net.SendToServer()
							gui.EnableScreenClicker(false) -- Disable Mouse
							confirm:Remove()
						end
					end

					local yesbtxt = vgui.Create("DLabel", yes)
					yesbtxt:SetPos(27, 0)
					yesbtxt:SetSize(110, 60)
					yesbtxt:SetFont("JailButtonFont")
					yesbtxt:SetText("Yes")

					local no = vgui.Create("DButton", confirm)
					no:SetSize(110, 60)
					no:SetPos(174,125)
					no:SetText("")
					no.Paint = function()
						surface.SetDrawColor(100, 100, 100, 235)
						surface.DrawRect(5, 5, 100, 50)
					end
					no.OnCursorEntered = function()
						JSButtonS(1) -- Play button hover sound
						no.Paint = function()
							surface.SetDrawColor(230, 230, 230, 235)
							surface.DrawRect(0, 0, 110, 60)
							surface.SetDrawColor(100, 100, 100, 235)
							surface.DrawRect(5, 5, 100, 50)
						end
					end
					no.OnCursorExited = function()
						no.Paint = function()
							surface.SetDrawColor(100, 100, 100, 235)
							surface.DrawRect(5, 5, 100, 50)
						end
					end
					no.OnMousePressed = function()
						JSButtonS(2) -- Play button click sound
						no.Paint = function()
							surface.SetDrawColor(230, 230, 230, 235)
							surface.DrawRect(0, 0, 110, 60)
							surface.SetDrawColor(235, 130, 130, 235)
							surface.DrawRect(5, 5, 100, 50)
						end
					end
					no.OnMouseReleased = function()
						no.Paint = function()
							surface.SetDrawColor(230, 230, 230, 235)
							surface.DrawRect(0, 0, 110, 60)
							surface.SetDrawColor(100, 100, 100, 235)
							surface.DrawRect(5, 5, 100, 50)
						end
						net.Start("JSTicketSV4")
							net.WriteEntity(cop)
							net.WriteInt(2, 32)
						net.SendToServer()
						gui.EnableScreenClicker(false) -- Disable Mouse
						confirm:Remove()

					end
					local nobtxt = vgui.Create("DLabel", no)
					nobtxt:SetPos(32, 0)
					nobtxt:SetSize(110, 60)
					nobtxt:SetFont("JailButtonFont")
					nobtxt:SetText("No")

		end
	end
end)

local function JSOpenInputKeyMenuCheck()

	if PoliceSystem.MButton2 == KEY_NONE then
		return true
	elseif input.IsKeyDown(PoliceSystem.MButton2) then
		return true
	else
		return false
	end
end

hook.Add("Think", "JSOpenMenuBind", function()

ply = LocalPlayer()

if ply.JScanOpenMenu == nil then -- A quick check for making sure this isn't nil. (First time spawn)
	ply.JScanOpenMenu = true
end

if not(ply.JScanOpenMenu) then return end -- If ply cannot open menu then stop it.
if not(input.IsKeyDown(PoliceSystem.MButton1)) then return end -- If the ply is pressing down the Button 1 defined (IN_USE by default)
if not(JSOpenInputKeyMenuCheck()) then return end


-- Pre-Init
	ply.JScanOpenMenu = false
	local curnotify
	local pnotify
	local ply = LocalPlayer()	
	local eye = ply:GetEyeTraceNoCursor()
	local entperp
	local disdis -- Just a placeholder for something uneeded
	if ply:GetNWBool("JSEscorting", false) then
		entperp = ply:GetNWEntity("JSEscortPerp")
	else
		entperp, disdis = ply:getEyeSightHitEntity(nil, nil, function(p) return p ~= ply and p:IsPlayer() and p:Alive() and p:IsSolid() end)
	end
	if not(IsValid(entperp)) then
		ply.JScanOpenMenu = true
		return
	end
	local entdeaths -- Had to call local before to keep it out of "if" scope
	local playerdeaths -- Had to call local before to keep it out of "if" scope
	if entperp:IsPlayer() then -- To avoid confusion with world ent
		entdeaths = entperp:Deaths() -- Number to check if perp dies
		playerdeaths = ply:Deaths() -- Number to check if ply dies
	end

-- Checks for opening menu
if ply:Alive() and entperp:IsPlayer() and ((ply:GetPos():Distance(entperp:GetPos())) < 150) and table.HasValue(PoliceSystem.AllowedJobsPoliceMenu, ply:Team()) then -- If the person is a cop and ent is player and close enough and ply is alive then

-- Init

	local mainwindow = vgui.Create("DFrame") -- Called before so that the think hook works.

	local function removeJSHooks() -- A single function to just remove the hooks when the menu is closed (also closes the menu :-) ).
		if not(not(pnotify)) then -- Removes the notification if it is up while the menu is closing
			pnotify:Remove()
		end
		hook.Remove("Think", "JSCloseMenuChecks")
		hook.Remove("Think", "ChangeRestrainText")
		hook.Remove("Think", "ChangeEscortText")
		concommand.Remove("JSPoliceMenuDermaClose")
		ply.JScanOpenMenu = true
		mainwindow:Close()
	end

	local function JSButtonS(num) -- Sounds for the menu buttons
		if num == 1 then -- Play the hover over button sound
			ply:EmitSound("garrysmod/ui_hover.wav")
		elseif num == 2 then --Play the button clicked sound
			ply:EmitSound("ui/buttonclickrelease.wav")
		end
	end

	-- This hook checks the distance on every frame, closes the panel if the distance exceeds the distance (150 units) bewteen the ply and ent(perp).
	-- Current Checks so far: Distance, Disconnection(perp), Deaths of either party. 
	hook.Add("Think", "JSCloseMenuChecks", function()

		if not(entperp:IsWorld()) then -- Make sure the ply isn't just looking at the world
			if not(IsValid(entperp)) then -- There isn't a clientside disconnect, this will have to do.
				removeJSHooks()
			end
		end

		if IsValid(entperp) && entperp:IsPlayer() then -- For some reason, it skips the check above until the second time it runs
			local dis = ply:GetPos():Distance(entperp:GetPos())
			-- Distance Check
			if dis >= 150 then
				removeJSHooks()
			end

			-- Basically close the menu if the jobs turns into a job that shouldn't be able to open the menu.
			if not(table.HasValue(PoliceSystem.AllowedJobsPoliceMenu, ply:Team())) then
				removeJSHooks()
			end

			-- Death Check (If perp dies, no client hook for this shit.)
			if entperp:Deaths() > entdeaths then
				removeJSHooks()
			end

			-- Death Check (If player dies.....no client hook for this.....again..)
			if ply:Deaths() > playerdeaths then
				removeJSHooks()
			end
		end
	end)
	
	-- Weapon names from C++ to Lua
	    HL2Wep = {

	    ["weapon_357"] = ".357 Magnum",
	    ["weapon_ar2"] = "AR-2 Pulse Rifle",
	    ["weapon_bugbait"] = "Bugbait",
	    ["weapon_crossbow"] = "Crossbow",
	    ["weapon_crowbar"] = "Crowbar",
	    ["weapon_frag"] = "Frag Grenade",
	    ["weapon_physcannon"] = "Gravity Gun",
	    ["weapon_pistol"] = "9MM Pistol",
	    ["weapon_rpg"] = "RPG Launcher",
	    ["weapon_shotgun"] = "Shotgun",
	    ["weapon_slam"] = "S.L.A.M",
	    ["weapon_smg1"] = "SMG/Grenade Launcher",
	    ["weapon_stunstick"] = "Stun Stick"
	    }

-- Notification / Deny Msg
	local function notifyply(message)

		if not(not(pnotify)) then -- Checks if a previous notification exists, deletes it and sets it so another one can be made
			curnotify = false
			pnotify:Remove()
		end

		if curnotify == false or curnotify == nil then
			curnotify = true
			timer.Simple(6, function()
				if curnotify == true then
					curnotify = false
				end
			end)
			pnotify = vgui.Create("DNotify")
			pnotify:SetPos(ScrW()/2 - 150, ScrH()/2 + 195)
			pnotify:SetSize(300, 75)

			local mainbar = vgui.Create("DPanel", pnotify)
			mainbar:SetSize(300, 75)
			mainbar:SetBackgroundColor(Color(120, 190, 210, 235))
			mainbar:SetPos(0, 0)

			local titlebar = vgui.Create("DPanel", mainbar)
			titlebar:SetSize(300, 25)
			titlebar:SetBackgroundColor(Color(100, 100, 100, 235))
			titlebar:SetPos(0,0)

			local ntitle = vgui.Create("DLabel", titlebar)
			ntitle:SetSize(300, 25)
			ntitle:SetText("Notification:")
			ntitle:SetFont("Trebuchet24")
			ntitle:SetPos(4, 1)

			local nmess = vgui.Create("DLabel", mainbar)
			nmess:SetSize(300, 50)
			nmess:SetPos(5, 25)
			nmess:SetFont("CloseCaption_Normal")
			nmess:SetText(message)

			pnotify:AddItem(mainbar)
		end
	end

	-- Universal deny msg function
	net.Receive("JSDenyMsgCL", function()

		local jhuman = net.ReadBool()
		local jmsg = net.ReadInt(32)

		if not(jhuman) then
			if jmsg == 1 then
				notifyply("You're not allowed to do that!")
			elseif jmsg == 2 then
				notifyply("The perp isn't near you!")
			elseif jmsg == 3 then
				notifyply("This person isn't wanted!")
			end
		else
			if jmsg == 1 then
				notifyply("Perp is being escorted!")
			elseif jmsg == 2 then
				notifyply("Restrain the perp first!")
			elseif jmsg == 3 then
				notifyply("This person is goverment!")
			elseif jmsg == 4 then
				notifyply("Perp can't afford ticket!")
			elseif jmsg == 5 then
				notifyply("Perp already has a ticket!")
			end
		end
	end)

-- Main Window

	mainwindow:SetSize(320,400)
	mainwindow:SetPos((ScrW()/2) - 160,(ScrH()/2) - 195)
	mainwindow:SetVisible(true)
	mainwindow:MakePopup()
	mainwindow:ShowCloseButton(true)
	mainwindow:SetTitle("")
	mainwindow:ShowCloseButton(false)
	mainwindow:SetDraggable(false)
	mainwindow.Paint = function()
		surface.SetDrawColor(120, 190, 210, 235)
		surface.DrawRect( 10, 50, 300, 340)
	end

-- Crimes Window - Function
	local function viewcrimes()

		net.Start("JSViewCrimesSV")
			net.WriteEntity(entperp)
		net.SendToServer()

		net.Receive("JSViewCrimesCL", function()

			local plybool = net.ReadBool()
			local plyint = net.ReadInt(32)
			local crimetable = net.ReadTable()

			if plybool == true then

				-- Actual Crime View Window

				local crimewindow = vgui.Create("DPanel", mainwindow)
					crimewindow:SetSize(320, 340)
					crimewindow:SetPos(0, 30)
					crimewindow.Paint = function()
						surface.SetDrawColor(220, 220, 220, 235)
						surface.DrawRect(0, 0, 320, 340)
						surface.SetDrawColor(120, 190, 210, 235)
						surface.DrawRect(10, 10, 300, 320)
					end

				local crimesbacklogo = vgui.Create("DLabel", crimewindow)
					crimesbacklogo:SetSize(300, 50)
					crimesbacklogo:SetPos(10, 10)
					crimesbacklogo:SetText("")
					crimesbacklogo.Paint = function()
						surface.SetDrawColor(125,125,125,255)
						surface.DrawRect(0,0,322,85)
					end

				local crimeslogo = vgui.Create("DLabel", crimesbacklogo)
					crimeslogo:SetSize(300, 40)
					crimeslogo:SetFont("JailButtonFont")
					crimeslogo:SetText("Crimes")
					crimeslogo:SetPos(105, 5)

				local crimelistbg = vgui.Create("DPanel", crimewindow)
					crimelistbg:SetPos(20, 70)
					crimelistbg:SetSize(280, 190)
					crimelistbg.Paint = function()
						surface.SetDrawColor(225,225,225,235)
						surface.DrawRect(0, 0, 280, 190)
					end

				local crimelist = vgui.Create("DListView", crimelistbg)
					crimelist:SetSize(280, 190)
					crimelist:SetMultiSelect(false)
					local Col1 = crimelist:AddColumn("Crime")
					local Col2 = crimelist:AddColumn("Times Committed")
					crimelist:AddLine("Manslaughter", "x" .. tostring(crimetable.Mur))
					crimelist:AddLine("Mugging", "x" .. tostring(crimetable.Mug))
					crimelist:AddLine("Burglary", "x" .. tostring(crimetable.Bur))
					crimelist:AddLine("Car-Jacking", "x" .. tostring(crimetable.Car))
					crimelist:AddLine("Illegal Weapons", "x" .. tostring(crimetable.IWep))
					crimelist:AddLine("Contraband", "x" .. tostring(crimetable.Con))
					crimelist:AddLine("Hit n' Run", "x" .. tostring(crimetable.Hnr))
					crimelist:AddLine("Terrorism", "x" .. tostring(crimetable.Ter))

				local crimeclose = vgui.Create("DButton", crimewindow)
					crimeclose:SetSize(150, 50)
					crimeclose:SetPos(85, 270)
					crimeclose:SetFont("JailButtonFont")
					crimeclose:SetText("Close")
					crimeclose.Paint = function()
						surface.SetDrawColor(220, 125, 125, 235)
						surface.DrawRect(5, 5, 140, 40)
					end
					crimeclose.OnCursorEntered = function()
						JSButtonS(1) -- Play button hover sound
						crimeclose.Paint = function()
							surface.SetDrawColor(240, 145, 145, 235)
							surface.DrawRect(0, 0, 150, 50)
						end
					end
					crimeclose.OnCursorExited = function()

						crimeclose.Paint = function()
							surface.SetDrawColor(220, 125, 125, 235)
							surface.DrawRect(5, 5, 140, 40)
						end
					end
					crimeclose.OnMousePressed = function()
						ply:EmitSound("ui/buttonclickrelease.wav")
					end
					crimeclose.OnMouseReleased = function()
						crimewindow:Remove()
					end
			end
		end)
	end

-- Restrain/Unrestrain - Function
	local function restrain()

		net.Start("JSRestrainPlySV")
			net.WriteEntity(entperp)
		net.SendToServer()

		net.Receive("JSRestrainPlyCL", function()

			local plybool = net.ReadBool()
			local plyint = net.ReadInt(32)

			if plybool then
				if plyint == 101 then
					notifyply("The perp was restrained!")
				elseif plyint == 102 then
					notifyply("The perp was unrestrained!")
				end
			end
		end)
	end

-- Escort - Function

	local function escort()

		net.Start("JSEscortPlySV")
			net.WriteEntity(entperp)
		net.SendToServer()

		net.Receive("JSEscortPlyCL", function()

			local plybool = net.ReadBool()
			local plyint = net.ReadInt(32)

			if plybool then
				if plyint == 101 then
					notifyply("Restrain the perp first!") -- In case perp isn't restrained (not in deny function because I wrote that function 2 late and screw rewriting all the code)
				elseif plyint == 102 then
					notifyply(3, "You're now escorting the perp!")
					removeJSHooks()
				elseif plyint == 103 then
					notifyply("Stopped escorting!")
				elseif plyint == 104 then
					notifyply("Escort N/A")
				elseif plyint == 105 then
					notifyply("You can't stop escorting here!")
				end
			end		
		end)
	end

-- Search Window - Function

	local function searchperson()

		net.Start("JSSearchPersonSV")
			net.WriteEntity(entperp)
		net.SendToServer()

		net.Receive("JSSearchPersonCL", function()

			local plybool = net.ReadBool()
			local plyint = net.ReadInt(32)
			local searchtable = net.ReadTable()

			if plybool then

				-- Actual Search View Window

				local searchwindow = vgui.Create("DPanel", mainwindow)
					searchwindow:SetSize(320, 340)
					searchwindow:SetPos(0, 30)
					searchwindow.Paint = function()
						surface.SetDrawColor(220, 220, 220, 235)
						surface.DrawRect(0, 0, 320, 340)
						surface.SetDrawColor(120, 190, 210, 235)
						surface.DrawRect(10, 10, 300, 320)
					end

				local searchsbacklogo = vgui.Create("DLabel", searchwindow)
					searchsbacklogo:SetSize(300, 50)
					searchsbacklogo:SetPos(10, 10)
					searchsbacklogo:SetText("")
					searchsbacklogo.Paint = function()
						surface.SetDrawColor(125,125,125,255)
						surface.DrawRect(0,0,322,85)
					end

				local searchslogo = vgui.Create("DLabel", searchsbacklogo)
					searchslogo:SetSize(300, 40)
					searchslogo:SetFont("JailButtonFont")
					searchslogo:SetText("Items Discovered")
					searchslogo:SetPos(23, 5)

				local searchlistbg = vgui.Create("DPanel", searchwindow)
					searchlistbg:SetPos(20, 70)
					searchlistbg:SetSize(280, 190)
					searchlistbg.Paint = function()
						surface.SetDrawColor(225,225,225,235)
						surface.DrawRect(0, 0, 280, 190)
					end

				local searchlist = vgui.Create("DListView", searchlistbg)
					searchlist:SetSize(140, 190)
					searchlist:SetMultiSelect(false)
					local Col1 = searchlist:AddColumn("On Perp")

					for k,v in pairs(searchtable.wep) do
						if (weapons.Get(k) ~= nil) then
							local wname = weapons.Get(k).PrintName
							searchlist:AddLine(wname)
						else
							searchlist:AddLine(HL2Wep[k])
						end
					end

				local searchlist2 = vgui.Create("DListView", searchlistbg)
					searchlist2:SetSize(140, 190)
					searchlist2:SetPos(140, 0)
					searchlist2:SetMultiSelect(false)
					local Col2 = searchlist2:AddColumn("Perps Pocket")

					for k,v in pairs(searchtable.pock.wep) do
						if (weapons.Get(k) ~= nil) then
							local wname = weapons.Get(k).PrintName
							searchlist2:AddLine(wname)
						else
							searchlist2:AddLine(HL2Wep[k])
						end
					end
					for k,v in pairs(searchtable.pock.ship) do
						searchlist2:AddLine(k)
					end
					for k,v in pairs(searchtable.pock.misc) do
						searchlist2:AddLine(k)
					end

				local searchclose = vgui.Create("DButton", searchwindow)
					searchclose:SetSize(150, 50)
					searchclose:SetPos(85, 270)
					searchclose:SetFont("JailButtonFont")
					searchclose:SetText("Close")
					searchclose.Paint = function()
						surface.SetDrawColor(220, 125, 125, 235)
						surface.DrawRect(5, 5, 140, 40)
					end
					searchclose.OnCursorEntered = function()
						JSButtonS(1) -- Play button hover sound
						searchclose.Paint = function()
							surface.SetDrawColor(240, 145, 145, 235)
							surface.DrawRect(0, 0, 150, 50)
						end
					end
					searchclose.OnCursorExited = function()

						searchclose.Paint = function()
							surface.SetDrawColor(220, 125, 125, 235)
							surface.DrawRect(5, 5, 140, 40)
						end
					end
					searchclose.OnMousePressed = function()
						ply:EmitSound("ui/buttonclickrelease.wav")
					end
					searchclose.OnMouseReleased = function()
						searchwindow:Remove()
					end
			end
		end)
	end

-- Confirm Button

	local function confirmbutton(type)

		net.Start("JSConfirmCheckSV")
			net.WriteEntity(entperp)
		net.SendToServer()
		net.Receive("JSConfirmCheckCL", function()

			local personcheck = net.ReadBool()
			local irrint = net.ReadInt(32)
			local crimecheck = net.ReadBool()
			local name = net.ReadString()

			if personcheck then
				if crimecheck then

					local function check(arg) -- not sure why I have this here, but I must have needed it for something
						if type == arg then
							return true
						else
							return false
						end
					end

		    		-- Confirm Panel
						local mainconfirm = vgui.Create("DPanel", mainwindow) -- Transparent Back
						mainconfirm:SetSize(320, 400)
						mainconfirm.Paint = function()
							surface.SetDrawColor(200, 200, 200, 0)
							surface.DrawRect(0, 0, 320, 400)
						end

						local confirm = vgui.Create("DPanel", mainconfirm)
						confirm:SetSize(320, 170)
						confirm:SetPos(0, 135)
						confirm.Paint = function()
							surface.SetDrawColor(100, 100, 100, 235)
							surface.DrawRect(0, 0, 320, 170)
							surface.SetDrawColor(120, 190, 210, 235)
							surface.DrawRect(10, 10, 300, 150)
						end

						local yes = vgui.Create("DButton", confirm)
						yes:SetSize(110, 60)
						yes:SetPos(37, 90)
						yes:SetText("")
						yes.Paint = function()
							surface.SetDrawColor(100, 100, 100, 235)
							surface.DrawRect(5, 5, 100, 50)
						end
						yes.OnCursorEntered = function()
							JSButtonS(1) -- Play button hover sound
							yes.Paint = function()
								surface.SetDrawColor(230, 230, 230, 235)
								surface.DrawRect(0, 0, 110, 60)
								surface.SetDrawColor(100, 100, 100, 235)
								surface.DrawRect(5, 5, 100, 50)
							end
						end
						yes.OnCursorExited = function()
							yes.Paint = function()
								surface.SetDrawColor(100, 100, 100, 235)
								surface.DrawRect(5, 5, 100, 50)
							end
						end
						yes.OnMousePressed = function()
							JSButtonS(2) -- Play button click sound
							yes.Paint = function()
								surface.SetDrawColor(230, 230, 230, 235)
								surface.DrawRect(0, 0, 110, 60)
								surface.SetDrawColor(235, 130, 130, 235)
								surface.DrawRect(5, 5, 100, 50)
							end
						end
						local yesbtxt = vgui.Create("DLabel", yes)
						yesbtxt:SetPos(27, 0)
						yesbtxt:SetSize(110, 60)
						yesbtxt:SetFont("JailButtonFont")
						yesbtxt:SetText("Yes")

						local no = vgui.Create("DButton", confirm)
						no:SetSize(110, 60)
						no:SetPos(174, 90)
						no:SetText("")
						no.Paint = function()
							surface.SetDrawColor(100, 100, 100, 235)
							surface.DrawRect(5, 5, 100, 50)
						end
						no.OnCursorEntered = function()
							JSButtonS(1) -- Play button hover sound
							no.Paint = function()
								surface.SetDrawColor(230, 230, 230, 235)
								surface.DrawRect(0, 0, 110, 60)
								surface.SetDrawColor(100, 100, 100, 235)
								surface.DrawRect(5, 5, 100, 50)
							end
						end
						no.OnCursorExited = function()
							no.Paint = function()
								surface.SetDrawColor(100, 100, 100, 235)
								surface.DrawRect(5, 5, 100, 50)
							end
						end
						no.OnMousePressed = function()
							JSButtonS(2) -- Play button click sound
							no.Paint = function()
								surface.SetDrawColor(230, 230, 230, 235)
								surface.DrawRect(0, 0, 110, 60)
								surface.SetDrawColor(235, 130, 130, 235)
								surface.DrawRect(5, 5, 100, 50)
							end
						end
						local nobtxt = vgui.Create("DLabel", no)
						nobtxt:SetPos(32, 0)
						nobtxt:SetSize(110, 60)
						nobtxt:SetFont("JailButtonFont")
						nobtxt:SetText("No")

					-- Switch Statement

					if check("Jail") then

						local title = vgui.Create("DLabel", confirm)				
						title:SetPos(95, -20)
						title:SetSize(300, 100)
						title:SetFont("RestrainFont")
						title:SetText("Incarcerate")

						local titlenn = vgui.Create("DLabel", confirm)
						titlenn:SetFont("RestrainFont")
						titlenn:SetText(name .. "?")
						local titlennw, titlennh = surface.GetTextSize(name .. "?")
						titlenn:SetSize(270, 100)
						titlenn:SetPos(130 - (titlennw/2), 15)

						no.OnMouseReleased = function()
							no.Paint = function()
								surface.SetDrawColor(230, 230, 230, 235)
								surface.DrawRect(0, 0, 110, 60)
								surface.SetDrawColor(100, 100, 100, 235)
								surface.DrawRect(5, 5, 100, 50)
							end
							mainconfirm:Remove()
						end

						yes.OnMouseReleased = function()
							yes.Paint = function()
								surface.SetDrawColor(230, 230, 230, 235)
								surface.DrawRect(0, 0, 110, 60)
								surface.SetDrawColor(100, 100, 100, 235)
								surface.DrawRect(5, 5, 100, 50)
							end
							net.Start("JSSendJailSV")
								net.WriteEntity(entperp)
							net.SendToServer()
							net.Receive("JSSendJailCL", function() -- don't even need this here but it is for future devlopment
							end)
							mainconfirm:Remove()
						end

					elseif check("Seize") then

						local title = vgui.Create("DLabel", confirm)				
						title:SetPos(50, -20)
						title:SetSize(300, 100)
						title:SetFont("RestrainFont")
						title:SetText("Seize all items from")

						local titlenn = vgui.Create("DLabel", confirm)
						titlenn:SetFont("RestrainFont")
						titlenn:SetText(name .. "?")
						local titlennw, titlennh = surface.GetTextSize(name .. "?")
						titlenn:SetSize(270, 100)
						titlenn:SetPos(130 - (titlennw/2), 15)

						no.OnMouseReleased = function()
							no.Paint = function()
								surface.SetDrawColor(230, 230, 230, 235)
								surface.DrawRect(0, 0, 110, 60)
								surface.SetDrawColor(100, 100, 100, 235)
								surface.DrawRect(5, 5, 100, 50)
							end
							mainconfirm:Remove()
						end

						yes.OnMouseReleased = function()
							yes.Paint = function()
								surface.SetDrawColor(230, 230, 230, 235)
								surface.DrawRect(0, 0, 110, 60)
								surface.SetDrawColor(100, 100, 100, 235)
								surface.DrawRect(5, 5, 100, 50)
							end
							net.Start("JSSeizeItemsSV")
								net.WriteEntity(entperp)
							net.SendToServer()
							net.Receive("JSSeizeItemsCL", function()

								local personcheck = net.ReadBool()
								local numreason = net.ReadInt(32)

								if personcheck then
									if numreason == 101 then
										notifyply("The items are being seized!")
									elseif numreason == 102 then
										notifyply("The items have been seized!")
									elseif numreason == 103 then
										notifyply("The perp is clean!")
									end
								end
							end)
							mainconfirm:Remove()
						end

					elseif check("Ticket") then

							net.Start("JSTicketSV1")
								net.WriteEntity(entperp)
							net.SendToServer()
							net.Receive("JSTicketCL1", function()

								local bcheck = net.ReadBool()
								local fineamount = net.ReadInt(32) -- Also the deny int

								if bcheck == true then
									local title = vgui.Create("DLabel", confirm)
									title:SetSize(250, 100)
									title:SetFont("RestrainFont")
									title:SetText("Ticket " .. name)
									local titlew, titleh = surface.GetTextSize("Ticket " .. name)
									title:SetPos(125 - (titlew/2), -20)

									local titlenn = vgui.Create("DLabel", confirm)
									titlenn:SetFont("RestrainFont")
									titlenn:SetText("$" .. string.Comma(fineamount) .. "?")
									local titlennw, titlennh = surface.GetTextSize("$" .. string.Comma(fineamount) .. "?")
									titlenn:SetSize(270, 100)
									titlenn:SetPos(140 - (titlennw/2), 20)

									no.OnMouseReleased = function()
										no.Paint = function()
										surface.SetDrawColor(230, 230, 230, 235)
										surface.DrawRect(0, 0, 110, 60)
										surface.SetDrawColor(100, 100, 100, 235)
										surface.DrawRect(5, 5, 100, 50)
										end
										mainconfirm:Remove()
									end

									yes.OnMouseReleased = function()
										yes.Paint = function()
											surface.SetDrawColor(230, 230, 230, 235)
											surface.DrawRect(0, 0, 110, 60)
											surface.SetDrawColor(100, 100, 100, 235)
											surface.DrawRect(5, 5, 100, 50)
										end
										net.Start("JSTicketSV2")
											net.WriteEntity(entperp)
										net.SendToServer()
										net.Receive("JSTicketCL2", function()

											local ifply = net.ReadBool()
											local ticketcheck = net.ReadInt(32)
											local ifwnted = net.ReadBool()

											if ifply == true then
												if ticketcheck == 0 then
													if ifwnted == true then
														net.Start("JSTicketSV3")
															net.WriteEntity(entperp)
														net.SendToServer()
													end
												elseif ticketcheck == 1 then
													notifyply("The ticket was paid!")
												elseif ticketcheck == 2 then
													notifyply("The ticket wasn't paid!")
												end
											end
										end)
										mainconfirm:Remove()
									end
								end
							end)

					elseif check("Pardon") then

						local title = vgui.Create("DLabel", confirm)				
						title:SetPos(115, -20)
						title:SetSize(300, 100)
						title:SetFont("RestrainFont")
						title:SetText("Pardon")

						local titlenn = vgui.Create("DLabel", confirm)
						titlenn:SetFont("RestrainFont")
						titlenn:SetText(name .. "?")
						local titlennw, titlennh = surface.GetTextSize(name .. "?")
						titlenn:SetSize(270, 100)
						titlenn:SetPos(131 - (titlennw/2), 15)

						no.OnMouseReleased = function()
							no.Paint = function()
								surface.SetDrawColor(230, 230, 230, 235)
								surface.DrawRect(0, 0, 110, 60)
								surface.SetDrawColor(100, 100, 100, 235)
								surface.DrawRect(5, 5, 100, 50)
							end
							mainconfirm:Remove()
						end

						yes.OnMouseReleased = function()
							yes.Paint = function()
								surface.SetDrawColor(230, 230, 230, 235)
								surface.DrawRect(0, 0, 110, 60)
								surface.SetDrawColor(100, 100, 100, 235)
								surface.DrawRect(5, 5, 100, 50)
							end
							mainconfirm:Remove()
							net.Start("JSPardonSV")
								net.WriteEntity(entperp)
							net.SendToServer()
							net.Receive("JSPardonCL", function() -- don't need this here, just have it for future development
							end)
						end
					end
				end
			end
		end)
	end

-- Top Gray Background

	local edittitle = {}
	local titlebar = vgui.Create("DPanel", mainwindow)
	titlebar:SetPos(10,10)
	titlebar:SetSize(300, 40)
	titlebar.Paint = function()
		surface.SetDrawColor(100, 100, 100, 235)
		surface.DrawRect(0,0,260,40)
	end
	-- Switches Police Menu to Credits
	titlebar.OnCursorEntered = function()
		JSButtonS(1) -- Play button hover sound
		edittitle:SetFont("PoliceFontCredit")
		edittitle:SetPos(15,10)
		edittitle:SetText("Created by NoOriginality")
	end
	titlebar.OnCursorExited = function()
		edittitle:SetPos(33, 10)
		edittitle:SetFont("PoliceFont")
		edittitle:SetText("Police Menu")
	end

-- Exit Button

	local exitb = vgui.Create("DButton", mainwindow)
	exitb:SetPos(270, 10)

	exitb:SetFont("CloseCaption_Bold")
	exitb:SetText("X")
	exitb:SetSize(40, 40)
	exitb.DoClick = function()
		JSButtonS(2) -- Play button click sound
		removeJSHooks()
	end
	exitb.Paint = function()
		surface.SetDrawColor(220, 125, 125, 235)
		surface.DrawRect(0, 0,40,40)
	end
	exitb.OnCursorEntered = function()
		JSButtonS(1) -- Play button hover sound
		exitb:SetPos(265, 5)
		exitb:SetSize(50,50)
		exitb.Paint = function()
			surface.SetDrawColor(220,125,125,245)
			surface.DrawRect(0,0,50,50)
		end
	end
	exitb.OnCursorExited = function()
	exitb:SetPos(270, 10)
	exitb:SetSize(40,40)
		exitb.Paint = function()
			surface.SetDrawColor(220, 125, 125, 235)
			surface.DrawRect(0, 0,40,40)
		end
	end

-- Police Menu Title

	local mwt = vgui.Create("DLabel", mainwindow)
	edittitle = mwt
	mwt:SetFont("PoliceFont")
	mwt:SetSize(300,40)
	mwt:SetPos(33, 10)
	mwt:SetText("Police Menu")

-- Send to Jail

	local jailbutton = vgui.Create("DButton", mainwindow)
	jailbutton:SetPos(50, 326)
	jailbutton:SetText("")
	jailbutton:SetSize(220, 60)
	jailbutton.Paint = function()
		surface.SetDrawColor(100, 100, 100, 235)
		surface.DrawRect(5, 5, 210, 50)
	end
	jailbutton.OnCursorEntered = function()
		JSButtonS(1) -- Play button hover sound
		jailbutton.Paint = function()
			surface.SetDrawColor(230, 230, 230, 235)
			surface.DrawRect(0, 0, 220, 60)
			surface.SetDrawColor(100, 100, 100, 235)
			surface.DrawRect(5, 5, 210, 50)
		end
	end
	jailbutton.OnCursorExited = function()
		jailbutton.Paint = function()
			surface.SetDrawColor(100, 100, 100, 235)
			surface.DrawRect(5, 5, 210, 50)
		end
	end
	-- The thinking part
	jailbutton.OnMousePressed = function()
		JSButtonS(2) -- Play button click sound
		jailbutton.Paint = function()
			surface.SetDrawColor(230, 230, 230, 235)
			surface.DrawRect(0, 0, 220, 60)
			surface.SetDrawColor(235, 130, 130, 235)
			surface.DrawRect(5, 5, 210, 50)
		end
	end
	jailbutton.OnMouseReleased = function()
		jailbutton.Paint = function()
			surface.SetDrawColor(230, 230, 230, 235)
			surface.DrawRect(0, 0, 220, 60)
			surface.SetDrawColor(100, 100, 100, 235)
			surface.DrawRect(5, 5, 210, 50)
		end
		confirmbutton("Jail")
	end
	local jailbtxt = vgui.Create("DLabel", jailbutton)
	jailbtxt:SetPos(20, 5)
	jailbtxt:SetSize(210, 50)
	jailbtxt:SetFont("JailButtonFont")
	jailbtxt:SetText("Send To Jail")

-- Seize Illegal Items

	local seizebutton = vgui.Create("DButton", mainwindow)
	seizebutton:SetPos(25, 258)
	seizebutton:SetText("")
	seizebutton:SetSize(270, 60)
	seizebutton.Paint = function()
		surface.SetDrawColor(100, 100, 100, 235)
		surface.DrawRect(5, 5, 260, 50)
	end
	seizebutton.OnCursorEntered = function()
		JSButtonS(1) -- Play button hover sound
		seizebutton.Paint = function()
			surface.SetDrawColor(230, 230, 230, 235)
			surface.DrawRect(0, 0, 270, 60)
			surface.SetDrawColor(100, 100, 100, 235)
			surface.DrawRect(5, 5, 260, 50)
		end
	end
	seizebutton.OnCursorExited = function()
		seizebutton.Paint = function()
			surface.SetDrawColor(100, 100, 100, 235)
			surface.DrawRect(5, 5, 260, 50)
		end
	end
	-- The thinking part
	seizebutton.OnMousePressed = function()
		JSButtonS(2) -- Play button click sound
		seizebutton.Paint = function()
			surface.SetDrawColor(230, 230, 230, 235)
			surface.DrawRect(0, 0, 270, 60)
			surface.SetDrawColor(235, 130, 130, 235)
			surface.DrawRect(5, 5, 260, 50)
		end
	end
	seizebutton.OnMouseReleased = function()
		seizebutton.Paint = function()
			surface.SetDrawColor(230, 230, 230, 235)
			surface.DrawRect(0, 0, 270, 60)
			surface.SetDrawColor(100, 100, 100, 235)
			surface.DrawRect(5, 5, 260, 50)
		end
		confirmbutton("Seize")
	end
	local seizebtxt = vgui.Create("DLabel", seizebutton)
	seizebtxt:SetPos(8, 5)
	seizebtxt:SetSize(270, 50)
	seizebtxt:SetFont("SeizeFont")
	seizebtxt:SetText("Seize Illegal Items")

-- Search

	local searchbutton = vgui.Create("DButton", mainwindow)
	searchbutton:SetPos(15, 190)
	searchbutton:SetText("")
	searchbutton:SetSize(140, 60)
	searchbutton.Paint = function()
		surface.SetDrawColor(100, 100, 100, 235)
		surface.DrawRect(5, 5, 130, 50)
	end
	searchbutton.OnCursorEntered = function()
		JSButtonS(1) -- Play button hover sound
		searchbutton.Paint = function()
			surface.SetDrawColor(230, 230, 230, 235)
			surface.DrawRect(0, 0, 140, 60)
			surface.SetDrawColor(100, 100, 100, 235)
			surface.DrawRect(5, 5, 130, 50)
		end
	end
	searchbutton.OnCursorExited = function()
		searchbutton.Paint = function()
			surface.SetDrawColor(100, 100, 100, 235)
			surface.DrawRect(5, 5, 130, 50)
		end
	end
	-- The thinking part
	searchbutton.OnMousePressed = function()
		JSButtonS(2) -- Play button click sound
		searchbutton.Paint = function()
			surface.SetDrawColor(230, 230, 230, 235)
			surface.DrawRect(0, 0, 140, 60)
			surface.SetDrawColor(235, 130, 130, 235)
			surface.DrawRect(5, 5, 130, 50)
		end
	end
	searchbutton.OnMouseReleased = function()
		searchbutton.Paint = function()
			surface.SetDrawColor(230, 230, 230, 235)
			surface.DrawRect(0, 0, 140, 60)
			surface.SetDrawColor(100, 100, 100, 235)
			surface.DrawRect(5, 5, 130, 50)
		end
		searchperson()
	end
	local searchbtxt = vgui.Create("DLabel", searchbutton)
	searchbtxt:SetPos(20, 5)
	searchbtxt:SetSize(130, 50)
	searchbtxt:SetFont("JailButtonFont")
	searchbtxt:SetText("Search")

-- Crimes

	local crimesbutton = vgui.Create("DButton", mainwindow)
	crimesbutton:SetPos(165, 190)
	crimesbutton:SetText("")
	crimesbutton:SetSize(140, 60)
	crimesbutton.Paint = function()
		surface.SetDrawColor(100, 100, 100, 235)
		surface.DrawRect(5, 5, 130, 50)
	end
	crimesbutton.OnCursorEntered = function()
		JSButtonS(1) -- Play button hover sound
		crimesbutton.Paint = function()
			surface.SetDrawColor(230, 230, 230, 235)
			surface.DrawRect(0, 0, 140, 60)
			surface.SetDrawColor(100, 100, 100, 235)
			surface.DrawRect(5, 5, 130, 50)
		end
	end
	crimesbutton.OnCursorExited = function()
		crimesbutton.Paint = function()
			surface.SetDrawColor(100, 100, 100, 235)
			surface.DrawRect(5, 5, 130, 50)
		end
	end
	-- The thinking part
	crimesbutton.OnMousePressed = function()
		JSButtonS(2) -- Play button click sound
		crimesbutton.Paint = function()
			surface.SetDrawColor(230, 230, 230, 235)
			surface.DrawRect(0, 0, 140, 60)
			surface.SetDrawColor(235, 130, 130, 235)
			surface.DrawRect(5, 5, 130, 50)
		end
	end
	crimesbutton.OnMouseReleased = function()
		crimesbutton.Paint = function()
			surface.SetDrawColor(230, 230, 230, 235)
			surface.DrawRect(0, 0, 140, 60)
			surface.SetDrawColor(100, 100, 100, 235)
			surface.DrawRect(5, 5, 130, 50)
		end
		viewcrimes()
	end
	local crimesbtxt = vgui.Create("DLabel", crimesbutton)
	crimesbtxt:SetPos(19, 5)
	crimesbtxt:SetSize(130, 50)
	crimesbtxt:SetFont("JailButtonFont")
	crimesbtxt:SetText("Crimes")

-- Escort

	local escortbutton = vgui.Create("DButton", mainwindow)
	escortbutton:SetPos(15, 122)
	escortbutton:SetText("")
	escortbutton:SetSize(140, 60)
	escortbutton.Paint = function()
		surface.SetDrawColor(100, 100, 100, 235)
		surface.DrawRect(5, 5, 130, 50)
	end
	escortbutton.OnCursorEntered = function()
		JSButtonS(1) -- Play button hover sound
		escortbutton.Paint = function()
			surface.SetDrawColor(230, 230, 230, 235)
			surface.DrawRect(0, 0, 140, 60)
			surface.SetDrawColor(100, 100, 100, 235)
			surface.DrawRect(5, 5, 130, 50)
		end
	end
	escortbutton.OnCursorExited = function()
		escortbutton.Paint = function()
			surface.SetDrawColor(100, 100, 100, 235)
			surface.DrawRect(5, 5, 130, 50)
		end
	end
	-- The thinking part
	escortbutton.OnMousePressed = function()
		JSButtonS(2) -- Play button click sound
		escortbutton.Paint = function()
			surface.SetDrawColor(230, 230, 230, 235)
			surface.DrawRect(0, 0, 140, 60)
			surface.SetDrawColor(235, 130, 130, 235)
			surface.DrawRect(5, 5, 130, 50)
		end
	end
	escortbutton.OnMouseReleased = function()
		escortbutton.Paint = function()
			surface.SetDrawColor(230, 230, 230, 235)
			surface.DrawRect(0, 0, 140, 60)
			surface.SetDrawColor(100, 100, 100, 235)
			surface.DrawRect(5, 5, 130, 50)
		end
		escort()-- Button function
	end
	local escortbtxt = vgui.Create("DLabel", escortbutton)
	local curtxt

	-- Text thinking hook
	hook.Add("Think", "ChangeEscortText", function()
		if not(entperp:GetNWBool("JSEscorted")) && not(ply:GetNWBool("JSEscorting")) then -- If ply isn't escorting and perp isn't being escorted
			curtext = "Escort"
		elseif ply:GetNWBool("JSEscorting") then
			curtext = "Unescort"
		else
			curtext = "NoEscort"
		end
		if curtext == "Escort" then
			escortbtxt:SetPos(23, 5)
			escortbtxt:SetSize(130, 50)
			escortbtxt:SetFont("JailButtonFont")
		elseif curtext == "Unescort" then
			escortbtxt:SetPos(15, 5)
			escortbtxt:SetSize(130, 50)
			escortbtxt:SetFont("RestrainFont")
		end
		escortbtxt:SetText(curtext)
	end)

-- Ticket

	local ticketbutton = vgui.Create("DButton", mainwindow)
	ticketbutton:SetPos(15, 54)
	ticketbutton:SetText("")
	ticketbutton:SetSize(140, 60)
	ticketbutton.Paint = function()
		surface.SetDrawColor(100, 100, 100, 235)
		surface.DrawRect(5, 5, 130, 50)
	end
	ticketbutton.OnCursorEntered = function()
		JSButtonS(1) -- Play button hover sound
		ticketbutton.Paint = function()
			surface.SetDrawColor(230, 230, 230, 235)
			surface.DrawRect(0, 0, 140, 60)
			surface.SetDrawColor(100, 100, 100, 235)
			surface.DrawRect(5, 5, 130, 50)
		end
	end
	ticketbutton.OnCursorExited = function()
		ticketbutton.Paint = function()
			surface.SetDrawColor(100, 100, 100, 235)
			surface.DrawRect(5, 5, 130, 50)
		end
	end
	-- The thinking part
	ticketbutton.OnMousePressed = function()
		JSButtonS(2) -- Play button click sound
		ticketbutton.Paint = function()
			surface.SetDrawColor(230, 230, 230, 235)
			surface.DrawRect(0, 0, 140, 60)
			surface.SetDrawColor(235, 130, 130, 235)
			surface.DrawRect(5, 5, 130, 50)
		end
	end
	ticketbutton.OnMouseReleased = function()
		ticketbutton.Paint = function()
			surface.SetDrawColor(230, 230, 230, 235)
			surface.DrawRect(0, 0, 140, 60)
			surface.SetDrawColor(100, 100, 100, 235)
			surface.DrawRect(5, 5, 130, 50)
		end
		confirmbutton("Ticket")
	end
	local ticketbtxt = vgui.Create("DLabel", ticketbutton)
	ticketbtxt:SetPos(25, 5)
	ticketbtxt:SetSize(130, 50)
	ticketbtxt:SetFont("JailButtonFont")
	ticketbtxt:SetText("Ticket")

-- Restrain/Unrestrain

	local restrainbutton = vgui.Create("DButton", mainwindow)
	restrainbutton:SetPos(165, 122)
	restrainbutton:SetText("")
	restrainbutton:SetSize(140, 60)
	restrainbutton.Paint = function()
		surface.SetDrawColor(100, 100, 100, 235)
		surface.DrawRect(5, 5, 130, 50)
	end
	restrainbutton.OnCursorEntered = function()
		JSButtonS(1) -- Play button hover sound
		restrainbutton.Paint = function()
			surface.SetDrawColor(230, 230, 230, 235)
			surface.DrawRect(0, 0, 140, 60)
			surface.SetDrawColor(100, 100, 100, 235)
			surface.DrawRect(5, 5, 130, 50)
		end
	end
	restrainbutton.OnCursorExited = function()
		restrainbutton.Paint = function()
			surface.SetDrawColor(100, 100, 100, 235)
			surface.DrawRect(5, 5, 130, 50)
		end
	end
	-- The thinking part
	restrainbutton.OnMousePressed = function()
		JSButtonS(2) -- Play button click sound
		restrainbutton.Paint = function()
			surface.SetDrawColor(230, 230, 230, 235)
			surface.DrawRect(0, 0, 140, 60)
			surface.SetDrawColor(235, 130, 130, 235)
			surface.DrawRect(5, 5, 130, 50)
		end
	end
	restrainbutton.OnMouseReleased = function()
		restrainbutton.Paint = function()
			surface.SetDrawColor(230, 230, 230, 235)
			surface.DrawRect(0, 0, 140, 60)
			surface.SetDrawColor(100, 100, 100, 235)
			surface.DrawRect(5, 5, 130, 50)
		end
		restrain()
	end
	-- Text Thinking restrain
	local restrainbtxt = vgui.Create("DLabel", restrainbutton)
	local curtext
	hook.Add("Think", "ChangeRestrainText", function()
		if not(entperp:GetNWBool("JSRestrained")) then
			curtext = "Restrain"
		elseif entperp:GetNWBool("JSRestrained") then
			curtext = "Unrestrain"
		end
		if curtext == "Restrain" then
			restrainbtxt:SetPos(9, 5)
			restrainbtxt:SetSize(130, 50)
			restrainbtxt:SetFont("JailButtonFont")
		elseif curtext == "Unrestrain" then
			restrainbtxt:SetPos(7, 5)
			restrainbtxt:SetSize(130, 50)
			restrainbtxt:SetFont("RestrainFont")
		end
		restrainbtxt:SetText(curtext)
	end)

-- Pardon

	local pardonbutton = vgui.Create("DButton", mainwindow)
		pardonbutton:SetPos(165, 54)
		pardonbutton:SetText("")
		pardonbutton:SetSize(140, 60)
		pardonbutton.Paint = function()
			surface.SetDrawColor(100, 100, 100, 235)
			surface.DrawRect(5, 5, 130, 50)
		end
		pardonbutton.OnCursorEntered = function()
			JSButtonS(1) -- Play button hover sound
			pardonbutton.Paint = function()
				surface.SetDrawColor(230, 230, 230, 235)
				surface.DrawRect(0, 0, 140, 60)
				surface.SetDrawColor(100, 100, 100, 235)
				surface.DrawRect(5, 5, 130, 50)
			end
		end
		pardonbutton.OnCursorExited = function()
			pardonbutton.Paint = function()
				surface.SetDrawColor(100, 100, 100, 235)
				surface.DrawRect(5, 5, 130, 50)
			end
		end
		-- The thinking part
		pardonbutton.OnMousePressed = function()
			JSButtonS(2) -- Play button click sound
			pardonbutton.Paint = function()
				surface.SetDrawColor(230, 230, 230, 235)
				surface.DrawRect(0, 0, 140, 60)
				surface.SetDrawColor(235, 130, 130, 235)
				surface.DrawRect(5, 5, 130, 50)
			end
		end
		pardonbutton.OnMouseReleased = function()
			pardonbutton.Paint = function()
				surface.SetDrawColor(230, 230, 230, 235)
				surface.DrawRect(0, 0, 140, 60)
				surface.SetDrawColor(100, 100, 100, 235)
				surface.DrawRect(5, 5, 130, 50)
			end
			confirmbutton("Pardon")
		end
		local pardonbtxt = vgui.Create("DLabel", pardonbutton)
		pardonbtxt:SetPos(19, 5)
		pardonbtxt:SetSize(130, 50)
		pardonbtxt:SetFont("JailButtonFont")
		pardonbtxt:SetText("Pardon")

else
	ply.JScanOpenMenu = true -- This resets the canOpenMenu incase the player fails the check (by looking at the world or some shit)
end -- Check for menu

end) -- Think hook End
