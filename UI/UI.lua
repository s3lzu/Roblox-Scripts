local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

-- ==================== GAME CHECK ====================
local AllowedGameID = 77926988392379

local function GetGameId()
    return game.GameId or game.PlaceId or 0
end

if GetGameId() ~= AllowedGameID then
    OrionLib:MakeNotification({
        Name = "Game Check",
        Content = "Wrong game detected.\nBypassing for testing...",
        Image = "rbxassetid://6031302994",
        Time = 4
    })
    wait(2)
end

-- Get Game Name
local success, GameName = pcall(function()
    return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
end)

if not success then
    GameName = "Unknown Game"
end

-- ==================== MAIN UI ====================
local Window = OrionLib:MakeWindow({
    Name = "Ricky UI - " .. GameName,
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "RickyUIConfig",
    IntroEnabled = false
})

-- Main Tab
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

MainTab:AddSection({ Name = "Main Features" })

MainTab:AddButton({
    Name = "Give Madung",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/s3lzu/Roblox-Scripts/main/241521621.lua"))()
    end
})

MainTab:AddButton({
    Name = "Give 67",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/s3lzu/Roblox-Scripts/main/23235.lua"))()
    end
})

-- Upgrades Tab
local UpgradesTab = Window:MakeTab({
    Name = "Upgrades",
    Icon = "rbxassetid://6031094678",
    PremiumOnly = false
})

UpgradesTab:AddSection({ Name = "Upgrades" })

UpgradesTab:AddButton({
    Name = "Buy +10 Speed",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/s3lzu/Roblox-Scripts/main/23854282.lua"))()
    end
})

UpgradesTab:AddButton({
    Name = "Buy Best Lucky Block",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/s3lzu/Roblox-Scripts/main/2352151.lua"))()
    end
})

UpgradesTab:AddButton({
    Name = "Buy Base Upgrade",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/s3lzu/Roblox-Scripts/main/34822458.lua"))()
    end
})


MainTab:AddButton({
    Name = "Destroy UI",
    Callback = function()
        OrionLib:Destroy()
    end
})


local Event = game:GetService("ReplicatedStorage").Events.ShowNotification
firesignal(Event.OnClientEvent, 
    "Ricky UI Loaded",
    "Success"
)
