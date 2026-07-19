-- Main UI Library --
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("s3lzu | Ninja Legends", "Ocean")

-- Tabs & Sections (unchanged)
local MainTab = Window:NewTab("Main")
local AutoTab = Window:NewTab("Auto Farming")
local UpgradeTab = Window:NewTab("Upgrades")
local MiscTab = Window:NewTab("Misc")

local MainSection = MainTab:NewSection("Main")
local AutoSection = AutoTab:NewSection("Auto Farm")
local UpgradeSection = UpgradeTab:NewSection("Upgrades")
local MiscSection = MiscTab:NewSection("Misc")

-- Variables --
local autoswing = false
local autobuyDagger = false
local selectedDagger = "Frost Dagger"

-- Dagger order (add more if you want)
local daggerOrder = {
    "Earth Dagger",
    "Frost Dagger",
    "Lightning Dagger",
    "Unstable Dagger",
    "Darkmatter Dagger"
}

-- Helper: Get current coins
local function getCoins()
    local player = game:GetService("Players").LocalPlayer
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local coins = leaderstats:FindFirstChild("Coins") or leaderstats:FindFirstChild("coin") or leaderstats:FindFirstChild("Ninjitsu")
        if coins then return coins.Value end
    end
    -- Backup paths
    return player:FindFirstChild("Coins") and player.Coins.Value or 0
end

-- Auto Swing (unchanged)
AutoSection:NewToggle("Auto Swing", "Auto swings your blade", function(state)
    autoswing = state
    if autoswing then
        spawn(function()
            while autoswing and task.wait() do
                local Event = game:GetService("Players").LocalPlayer:FindFirstChild("saberEvent")
                if Event then Event:FireServer("swingBlade") end
            end
        end)
    end
end)

-- Auto Buy Next Dagger (Now with coin check)
AutoSection:NewToggle("Auto Buy Next Dagger", "Buys next dagger only if you have enough coins", function(state)
    autobuyDagger = state
    if autobuyDagger then
        spawn(function()
            while autobuyDagger and task.wait(1.5) do  -- slightly slower to reduce spam
                local player = game:GetService("Players").LocalPlayer
                local Event = player:FindFirstChild("saberEvent")
                if not Event then continue end
                
                local ownedFolder = player:FindFirstChild("ownedSwords") or player:FindFirstChild("OwnedSwords")
                local groundFolder = game:GetService("ReplicatedStorage").Weapons.Ground
                
                if not ownedFolder then continue end
                
                local currentCoins = getCoins()
                
                for _, daggerName in ipairs(daggerOrder) do
                    local owned = ownedFolder:FindFirstChild(daggerName) 
                               or ownedFolder:FindFirstChild(daggerName:gsub(" ", ""))
                    
                    if not owned then
                        local weapon = groundFolder:FindFirstChild(daggerName)
                        if weapon then
                            -- Try to get cost (some games store it in the weapon object)
                            local cost = weapon:FindFirstChild("Cost") and weapon.Cost.Value 
                                      or weapon:FindFirstChild("Price") and weapon.Price.Value 
                                      or 999999999  -- fallback
                            
                            if currentCoins >= cost then
                                Event:FireServer("buyBlade", weapon)
                                print("✅ Auto Bought: " .. daggerName .. " | Cost: " .. cost)
                                task.wait(2) -- small delay after successful buy
                            else
                                print("Not enough coins for " .. daggerName .. " (" .. cost .. ")")
                            end
                            break
                        end
                    end
                end
            end
        end)
    end
end)

-- Manual controls (unchanged)
MainSection:NewDropdown("Dagger Selection", "Select Dagger To Buy", 
    {"Earth Dagger", "Frost Dagger", "Lightning Dagger", "Unstable Dagger", "Darkmatter Dagger"}, 
function(currentOption)
    selectedDagger = currentOption
end)

MainSection:NewButton("Buy Selected Dagger", "Buys the currently selected dagger", function()
    local player = game:GetService("Players").LocalPlayer
    local Event = player:FindFirstChild("saberEvent")
    local groundFolder = game:GetService("ReplicatedStorage").Weapons.Ground
    
    if Event then
        local weapon = groundFolder:FindFirstChild(selectedDagger)
        if weapon then
            Event:FireServer("buyBlade", weapon)
            print("Bought: " .. selectedDagger)
        end
    end
end)

MiscSection:NewKeybind("Toggle UI", "Default Key: F", Enum.KeyCode.F, function()
    Library:ToggleUI()
end)
