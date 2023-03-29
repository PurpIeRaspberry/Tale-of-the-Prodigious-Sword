local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()
local Window = library:MakeWindow({Name = "Tale of the Prodigious Swords", HidePremium = false, SaveConfig = false, ConfigFolder = "personwhogottermed"})
local plr = game.Players.LocalPlayer

local function getbosses()
	if game.PlaceId == 4624681571 then
		return {"Agony", "Alien", "Earth Orbiter", "Fallen Angel", "Undefeated Knight", "Waxy Willy", "Bandit lord", "Barbarian", "Troll Commander", "Skeleton overlord", "Reaper God", "Pharaoh", "God Pharaoh", "King Beast", "Frigid Beast God", "Lato", "Ethel", "Angel God", "Zamza", "Soul taker", "The executioner", "Fallen lord", "Hades", "Zelroth", "Enigma", "Dei terrae", "Caligari", "Serpent", "Drakkar", "Korblox General", "The Keeper", "Ancalagon", "Sewage Soldier", "Shrek", "Stubborn troll", "Arachne", "Magma", "Crystal creature", "Risen rock", "Pumpking", "Triumph&Tragedy", "Frostcide", "Chaac", "Blood Seeker", "Eternal Flame", "Crimsonwrath"}
	elseif game.PlaceId == 4624707946 then
		return {"Divine's Guardian", "Undying Virdescent", "God Slayer", "Winter Apocalypse", "Moonlight", "Angry Bovich", "Colossal Viking", "Overseer Guardian", "Flame Guard General", "Shuten", "Insectaur", "Druid emperor", "Crimsonal Claw", "Famine", "Pestilence", "Death", "War", "Thanatos", "The Apocalyptic Machine", "The Orinthian Machine", "The Pulverizer", "Frozen Guardian", "The Frozen Marauder", "Ancalagon", "Az-Dul the Treant", "Strange Monstrosity", "Abyssal relent", "Carnage Bringer", "Crop Defender", "Jungle God", "Spirit Shaman", "Flame Shaman", "Krozkan", "Overseer Marauder", "Forest Berserker", "Venin", "Tal'Vex", "Ziggy Stardust", "Pulsar", "Ignis", "Comet", "Galaxy Orbiter", "Jupiter", "Gumdrop", "Jelly Abomination", "Gelatinous Demon", "Gingerbread", "Dokanaga, Fujiwara Champion", "Fujiwara Shinobi", "Tsurugi Serpent Tamer", "The Great Devourer"}
	end
end

local AutofarmTab = Window:MakeTab({
	Name = "Autofarm",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

AutofarmTab:AddDropdown({
	Name = "Bosses",
	Default = getbosses()[1],
	Options = getbosses(),
	Callback = function(value)
		_G.CurrentBoss = value
	end
})

AutofarmTab:AddToggle({
	Name = "Autofarm Bosses",
	Default = false,
	Callback = function(value)
		_G.AutoFarmEnabled = value
		while _G.AutoFarmEnabled do
			for i,v in pairs(game.Workspace:GetChildren()) do
				if v.Name:find(_G.CurrentBoss) and v:FindFirstChild("Humanoid") then
					if v.Humanoid.Health > 0 then
						local tool = plr.Character:FindFirstChildOfClass("Tool")
						tool:Activate()
						firetouchinterest(tool.Handle,v.HumanoidRootPart,0)
						firetouchinterest(tool.Handle,v.HumanoidRootPart,1)
						task.wait(0.1)
					end
				end
			end
			task.wait(0.3)
		end
	end
})

AutofarmTab:AddToggle({
	Name = "Autofarm All Bosses",
	Default = false,
	Callback = function(value)
		_G.AutoFarmBossesEnabled = value
		local bosses = getbosses()
			while _G.AutoFarmBossesEnabled do
			for i,v in pairs(game.Workspace:GetChildren()) do
				for k,g in next, bosses do
					if not _G.AutoFarmBossesEnabled then
						break
					end
					if v.Name:find(g) and v:FindFirstChild("Humanoid") then
						if v.Humanoid.Health > 0 then
							local tool = plr.Character:FindFirstChildOfClass("Tool")
							tool:Activate()
							firetouchinterest(tool.Handle,v.HumanoidRootPart,0)
							firetouchinterest(tool.Handle,v.HumanoidRootPart,1)
							task.wait(0.1)
						end
					end
				end
			end
			task.wait(0.3)
		end
	end
})

AutofarmTab:AddToggle({
	Name = "Auto Rebirth",
	Default = false,
	Callback = function(value)
		_G.AutoRebirth = value
		while _G.AutoRebirth and task.wait() do
			game:GetService("ReplicatedStorage").Events.PlayerData.Revival:FireServer()
		end
	end
})


local MovementTab = Window:MakeTab({
	Name = "Movement",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

MovementTab:AddSlider({
	Name = "WalkSpeed",
	Min = 20,
	Max = 100,
	Default = 20,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "speed",
	Callback = function(value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
	end
})

MovementTab:AddSlider({
	Name = "JumpPower",
	Min = 50,
	Max = 200,
	Default = 50,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "power",
	Callback = function(value)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
	end
})

local TeleportsTab = Window:MakeTab({
	Name = "Teleports",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

TeleportsTab:AddButton({
	Name = "Teleport to Main Land",
	Callback = function()
		game:GetService("TeleportService"):Teleport(4624681571)
	end
})

TeleportsTab:AddButton({
	Name = "Teleport to Southern Gate",
	Callback = function()
		game:GetService("TeleportService"):Teleport(4624707946)
	end
})

local StatsTab = Window:MakeTab({
	Name = "Stats",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

StatsTab:AddLabel("You need at least 1 stat point!")
StatsTab:AddLabel("MAKE SURE TO RESET GOLD")

StatsTab:AddButton({
	Name = "Add all stats",
	Callback = function()
		game:GetService("ReplicatedStorage").Events.PlayerData.AddSkillPoints:FireServer("GoldGained", -math.huge)
		game:GetService("ReplicatedStorage").Events.PlayerData.AddSkillPoints:FireServer("ExtraDmg", 9000000000)
		game:GetService("ReplicatedStorage").Events.PlayerData.AddSkillPoints:FireServer("GoldGained", -math.huge)
		game:GetService("ReplicatedStorage").Events.PlayerData.AddSkillPoints:FireServer("ExtraHealth", 9000000000)
		if game:GetService("Players").LocalPlayer.PlayerGui.Gui.SettingsMenu.SkillGui.Defense.Text ~= "Defense: 50%" then
			game:GetService("ReplicatedStorage").Events.PlayerData.AddSkillPoints:FireServer("GoldGained", -500)
			game:GetService("ReplicatedStorage").Events.PlayerData.AddSkillPoints:FireServer("Defense", 500)
		end
  	end    
})

StatsTab:AddButton({
	Name = "ExtraDmg",
	Callback = function()
		game:GetService("ReplicatedStorage").Events.PlayerData.AddSkillPoints:FireServer("GoldGained", -math.huge)
		game:GetService("ReplicatedStorage").Events.PlayerData.AddSkillPoints:FireServer("ExtraDmg", 9000000000)
  	end
})

StatsTab:AddButton({
	Name = "ExtraHealth",
	Callback = function()
		game:GetService("ReplicatedStorage").Events.PlayerData.AddSkillPoints:FireServer("GoldGained", -math.huge)
		game:GetService("ReplicatedStorage").Events.PlayerData.AddSkillPoints:FireServer("ExtraHealth", 9000000000)
  	end
})

StatsTab:AddButton({
	Name = "Defense",
	Callback = function()
		if plr.PlayerGui.Gui.SettingsMenu.SkillGui.Defense.Text ~= "Defense: 50%" then
			game:GetService("ReplicatedStorage").Events.PlayerData.AddSkillPoints:FireServer("GoldGained", -500)
			game:GetService("ReplicatedStorage").Events.PlayerData.AddSkillPoints:FireServer("Defense", 500)
		end
  	end
})

StatsTab:AddButton({
	Name = "Reset Gold Stats",
	Callback = function()
		game:GetService("ReplicatedStorage").Events.PlayerData.AddSkillPoints:FireServer("GoldGained", -math.huge)
		task.wait(0.3)
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
	end
})

local CreditsTab = Window:MakeTab({
	Name = "Credits",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

CreditsTab:AddLabel("Scripted by Rasp#0742")

if not _G.AlreadyToggleHooked then
	local UserInputService = game:GetService("UserInputService")
	UserInputService.InputBegan:Connect(function(key)
	    if key.KeyCode == Enum.KeyCode.RightShift then
	        for i,v in pairs(game.CoreGui:GetChildren()) do
	            if v.Name == "Orion" then
	                v.Enabled = not v.Enabled
	            end
	        end
	    end
	end)
end

_G.AlreadyToggleHooked = true