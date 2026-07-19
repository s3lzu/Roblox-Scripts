
-- Main UI Libary --

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("s3lzu | Troll A Brainrot", "Ocean")

-- Tabs --

local MainTab = Window:NewTab("Brain Rots")
local UpgradeTab = Window:NewTab("Upgrades")

-- Sections --

local MainSection = MainTab:NewSection("Give Brainrots")
local UpgradeSection = UpgradeTab:NewSection("Upgrades")

-- Functions --

MainSection:NewButton("Give Madung", "Gives Best Brainrot", function()
    local Event = game:GetService("ReplicatedStorage").Events.RewardEscape
Event:FireServer(
    "Madung",
    "Neon",
    "Celestial"
)
end)

MainSection:NewButton("Give 67", "Gives Best Brainrot", function()
    local Event = game:GetService("ReplicatedStorage").Events.RewardEscape
Event:FireServer(
    "67",
    "Neon",
    "Celestial"
)
end)

UpgradeSection:NewButton("Rebirth", "Rebirths", function()
    local Event = game:GetService("ReplicatedStorage").Events.RequestRebirth
Event:FireServer()
end)

UpgradeSection:NewButton("Buy Speed", "Buys +10 speed", function()
    local Event = game:GetService("ReplicatedStorage").Events.RequestUpgradeAction
Event:FireServer(
    "Speed",
    "10"
)
end)

UpgradeSection:NewButton("Buy Best Lucky Block", "Buys Best Lucky Block", function()
    local Event = game:GetService("ReplicatedStorage").Events.RequestLuckyBlockPurchase
Event:FireServer(
    "Rainbow"
)
end)

UpgradeSection:NewButton("Upgrade Base", "Upgrades Base", function()
    local Event = game:GetService("ReplicatedStorage").Events.RequestBaseUpgrade
Event:FireServer()
end)

MainSection:NewKeybind("Toggle UI Deafult Key F", "Toggles The Ui", Enum.KeyCode.F, function()
	Library:ToggleUI()
end)

wait(3)

local Event = game:GetService("ReplicatedStorage").Events.NewDiscovery
firesignal(Event.OnClientEvent, 
    "@dsgheahe on roblox",
    "s3lzu made this script",
    1
)
