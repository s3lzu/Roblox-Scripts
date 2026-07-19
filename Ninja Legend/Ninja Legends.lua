-- Main UI Library --
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("s3lzu | Ninja Legends", "Ocean")

-- Tabs --
local MainTab = Window:NewTab("Main")
local AutoTab = Window:NewTab("Auto Farming")
local UpgradeTab = Window:NewTab("Upgrades")
local MiscTab = Window:NewTab("Misc")

-- Sections --
local MainSection = MainTab:NewSection("Main")
local AutoSection = AutoTab:NewSection("Auto Farm")
local UpgradeSection = UpgradeTab:NewSection("Upgrades")
local MiscSection = MiscTab:NewSection("Misc")

-- Variables --
local autoswing = false
local autobuyDagger = false
local autobuyCrystal = false
local selectedDagger = "Frost Dagger"
local selectedCrystal = "Electro Crystal"

-- Dagger order
local daggerOrder = {
    "Earth Dagger", "Frost Dagger", "Lightning Dagger", 
    "Unstable Dagger", "Darkmatter Dagger"
}

-- Crystal order (add more as needed)
local crystalOrder = {
    "Electro Crystal",
    -- Add others like "Fire Crystal", "Ice Crystal", etc. here
}

-- Auto Swing --
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

-- Auto Buy Next Dagger
AutoSection:NewToggle("Auto Buy Next Dagger", "Spams next dagger", function(state)
    autobuyDagger = state
    if autobuyDagger then
        spawn(function()
            while autobuyDagger and task.wait(0.8) do
                local player = game:GetService("Players").LocalPlayer
                local Event = player:FindFirstChild("saberEvent")
                if not Event then continue end
                
                local owned = player:FindFirstChild("ownedSwords") or player:FindFirstChild("OwnedSwords")
                local folder = game:GetService("ReplicatedStorage").Weapons.Ground
                
                if not owned then continue end
                
                for _, name in ipairs(daggerOrder) do
                    if not owned:FindFirstChild(name) and not owned:FindFirstChild(name:gsub(" ", "")) then
                        local item = folder:FindFirstChild(name)
                        if item then
                            Event:FireServer("buyBlade", item)
                            print("Buying Dagger: " .. name)
                            task.wait(1.2)
                            break
                        end
                    end
                end
            end
        end)
    end
end)

-- Auto Buy Next Crystal (NEW)
AutoSection:NewToggle("Auto Buy Next Crystal", "Spams next crystal", function(state)
    autobuyCrystal = state
    if autobuyCrystal then
        spawn(function()
            while autobuyCrystal and task.wait(0.8) do
                local player = game:GetService("Players").LocalPlayer
                local Event = player:FindFirstChild("saberEvent")
                if not Event then continue end
                
                local owned = player:FindFirstChild("ownedSwords") or player:FindFirstChild("OwnedSwords") -- might be same folder or different
                local folder = game:GetService("ReplicatedStorage").Crystals.Ground
                
                if not owned then continue end
                
                for _, name in ipairs(crystalOrder) do
                    if not owned:FindFirstChild(name) and not owned:FindFirstChild(name:gsub(" ", "")) then
                        local item = folder:FindFirstChild(name)
                        if item then
                            Event:FireServer("buyCrystal", item)
                            print("Buying Crystal: " .. name)
                            task.wait(1.2)
                            break
                        end
                    end
                end
            end
        end)
    end
end)

-- Manual Dagger
MainSection:NewDropdown("Dagger Selection", "Select Dagger", 
    {"Earth Dagger", "Frost Dagger", "Lightning Dagger", "Unstable Dagger", "Darkmatter Dagger"}, 
function(currentOption) selectedDagger = currentOption end)

MainSection:NewButton("Buy Selected Dagger", "", function()
    local Event = game:GetService("Players").LocalPlayer:FindFirstChild("saberEvent")
    local item = game:GetService("ReplicatedStorage").Weapons.Ground[selectedDagger]
    if Event and item then Event:FireServer("buyBlade", item) end
end)

-- Manual Crystal
MainSection:NewDropdown("Crystal Selection", "Select Crystal", 
    {"Electro Crystal"},  -- Add more crystal names here
function(currentOption) selectedCrystal = currentOption end)

MainSection:NewButton("Buy Selected Crystal", "", function()
    local Event = game:GetService("Players").LocalPlayer:FindFirstChild("saberEvent")
    local item = game:GetService("ReplicatedStorage").Crystals.Ground[selectedCrystal]
    if Event and item then 
        Event:FireServer("buyCrystal", item)
        print("Bought Crystal: " .. selectedCrystal)
    end
end)

MiscSection:NewKeybind("Toggle UI", "Default Key: F", Enum.KeyCode.F, function()
    Library:ToggleUI()
end)
